const { onCall } = require("firebase-functions/v2/https");
const { HttpsError } = require("firebase-functions/v2/https");
const {onDocumentCreated, onDocumentUpdated } = require("firebase-functions/v2/firestore");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");
const nodemailer = require('nodemailer');
const cors = require("cors")({origin: true});
const stripe = require("stripe")('sk_test_51RofpWBkqmbwnoQDj9bpkp0McUBJlpru0yvAa5tfCR94tAc9TdzQQL7bEcbeg2CL7xz1n5NHm03wOuq8qF83EICu00KHDAHo45');

admin.initializeApp();

const db = admin.firestore();

// Define the secrets
const EMAIL_USER = defineSecret("EMAIL_USER");
const EMAIL_PASS = defineSecret("EMAIL_PASS");


// when admin  announce something  
exports.sendNotification = onCall(async (request) => {
  const { role, title, body } = request.data;

  if (!role || !title || !body) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Missing required fields: role, title, body"
    );
  }

  try {
    // Query all users with matching role
    const usersSnapshot = await admin.firestore()
      .collection("users")
      .where("role", "==", role)
      .get();

    const tokens = [];
    usersSnapshot.forEach(doc => {
      const token = doc.data().fcmToken;
      if (token) tokens.push(token);
    });

    if (tokens.length === 0) {
      console.log(`No FCM tokens found for role '${role}'`);
      return { success: false, message: "No tokens found" };
    }

    const message = {
      notification: {
        title: title,
        body: body,
      },
      tokens: tokens,
    };

    const response = await admin.messaging().sendEachForMulticast(message);

    return {
      success: true,
      message: `Notification sent to ${response.successCount}/${tokens.length} users`,
      failedCount: response.failureCount,
    };
  } catch (error) {
    console.error("Notification error:", error);
    throw new functions.https.HttpsError("internal", "Notification failed");
  }
});

// when emailnotification/feedback notification on then send email
exports.sendFeedbackEmailToCreator = onCall(
  { secrets: [EMAIL_USER, EMAIL_PASS] },
  async (request) => {
    try {
      const { feedbackData } = request.data || {};

      if (!feedbackData) {
        throw new HttpsError("invalid-argument", "Missing feedbackData");
      }

      const {
        userId,
        userName,
        contentId,
        contentType,
        contentName,
        feedbackMessage,
        rating,
        suggestion,
        email
      } = feedbackData;

      if (!contentId || !contentType) {
        throw new HttpsError(
          "invalid-argument",
          "contentId and contentType are required"
        );
      }

      console.log(`📝 Feedback received for ${contentType}: ${contentName} (${contentId})`);

      // 1️⃣ Find creatorId depending on contentType
      let creatorId = null;
      let creatorEmail = null;
      let creatorData = null;

      if (contentType === "Program" || contentType === "Workout") {
        // From discovery collection
        const contentDoc = await db.collection("discovery").doc(contentId).get();
        if (!contentDoc.exists) {
          throw new HttpsError("not-found", `${contentType} not found`);
        }

        const contentData = contentDoc.data();
        creatorId = contentData.userId;
      } else if (contentType === "Creator") {
        // From users collection directly
        creatorId = contentId;
      }

      if (!creatorId) {
        throw new HttpsError("failed-precondition", "Creator ID not found");
      }

      // 2️⃣ Get creator details
      const creatorDoc = await db.collection("users").doc(creatorId).get();
      if (!creatorDoc.exists) {
        throw new HttpsError("not-found", "Creator not found");
      }

      creatorData = creatorDoc.data();
      creatorEmail = creatorData.email;

      // 3️⃣ Check notification preferences
      const notifications = creatorData.notifications || {};
      if (
        !creatorEmail ||
        !notifications.emailNotifications ||
        !notifications.receiveFeedbackEmail
      ) {
        console.log(`⚠️ Creator ${creatorId} has feedback emails disabled`);
        return { success: false, message: "Email notifications disabled" };
      }

      // 4️⃣ Setup email transport
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: EMAIL_USER.value(),
          pass: EMAIL_PASS.value(),
        },
      });

      // 5️⃣ Create email template
      const subject = `New Feedback on your ${contentType}`;
      const html = `
        <div style="font-family: Arial, sans-serif; line-height:1.6;">
          <h2>📢 New Feedback Received</h2>
          <p>Hi ${creatorData.name || "there"},</p>
          <p>We hope you’re doing well!</p>
          <p>You’ve just received new feedback on your ${contentType.toLowerCase()} <b>"${contentName}"</b>.</p>
          <p><strong>From:</strong> ${userName || "Anonymous"}</p>
          <p><strong>${contentType}:</strong> ${contentName || "Untitled"}</p>
          <p><strong>Feedback:</strong> ${feedbackMessage || "No message provided."}</p>
          ${suggestion ? `<p><strong>Suggestion:</strong> ${suggestion}</p>` : ""}
          ${email ? `<p><strong>Suggestion:</strong> ${email}</p>` : ""}
          <hr/>
          <p style="font-size: 12px; color: #777;">
           We sent you this message because you love staying connected with your audience on Musculo.
          </p>
        </div>
      `;

      // 6️⃣ Send email
      await transporter.sendMail({
        from: `"Musculo App" <${EMAIL_USER.value()}>`,
        to: creatorEmail,
        subject,
        html,
      });

      console.log(`📧 Feedback email sent to ${creatorEmail}`);
      return { success: true };
    } catch (error) {
      console.error("❌ Error sending feedback email:", error);
      throw new HttpsError("internal", error.message);
    }
  }
);

// when user cancel program or workout  send notification to user and creator
exports.sendCancelNotification = onCall(  
  {
    secrets: [EMAIL_USER, EMAIL_PASS],
  }, async (request) => {
  const { userId, creatorId, type, itemName } = request.data;

  if (!userId || !creatorId || !type || !itemName) {
    throw new HttpsError("invalid-argument", "Missing required fields.");
  }

  try {
    const userDoc = await db.collection("users").doc(userId).get();
    const creatorDoc = await db.collection("users").doc(creatorId).get();

    if (!userDoc.exists || !creatorDoc.exists) {
      throw new HttpsError("not-found", "User or creator not found.");
    }

    const userData = userDoc.data();
    const creatorData = creatorDoc.data();

    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: EMAIL_USER.value(),
          pass: EMAIL_PASS.value(),
        },
      });

    // Prepare messages
    const messages = [];
    const emailPromises = [];
   
     // 🔹 Notify the creator that the user cancelled their program/workout (FCM)
    if (
     creatorData?.fcmToken &&
     creatorData?.notifications?.creatorCancelNotice === true &&
     creatorData?.notifications?.phoneNotifications === true
    ) {
      messages.push({
          notification: {
          title: `${type === "program" ? "Program" : "Workout"} Cancelled`,
          body: `${userData.name || "A user"} cancelled your ${type} "${itemName}".`,
        },
        token: creatorData.fcmToken,
        data: {
          type,
          action: "cancelled",
          by:"user",
        },
      });
       console.log(`📨 Will notify creator (${creatorId})`);
    }

    // 🔹 Notify the user (confirmation message)(FCM)
     if (
      userData?.fcmToken &&
      userData?.notifications?.refundNotice === true && 
      userData?.notifications?.phoneNotifications ===true
    ) {
      messages.push({
        notification: {
          title: `${type === "program" ? "Program" : "Workout"} Cancelled`,
          body: `You successfully cancelled your ${type} "${itemName}".`,
        },
        token: userData.fcmToken,
        data: {
          type,
          action: "cancelled",
          by: "self",
        },
      });
      console.log(`📨 Will notify user (${userId})`);
    }

     // 🔹 Notify the creator (Email)
      if (
        creatorData?.email &&
        creatorData?.notifications?.creatorCancelNotice === true &&
        creatorData?.notifications?.emailNotifications === true
      ) {
        const subject = `${type === "program" ? "Program" : "Workout"} Cancelled`;
        const html = `
          <h3>${userData.name || "A user"} cancelled your ${type}:</h3>
          <p><b>${itemName}</b> has been cancelled.</p>
          <p>Log in to your Musculo creator dashboard for more details.</p>
        `;
        emailPromises.push(
          transporter.sendMail({
            from: `"Musculo App" <${EMAIL_USER.value()}>`,
            to: creatorData.email,
            subject,
            html,
          })
        );
        console.log(`📧 Will email creator (${creatorId})`);
      }

      // 🔹 Notify the user (Email)
      if (
        userData?.email &&
        userData?.notifications?.refundNotice === true &&
        userData?.notifications?.emailNotifications === true
      ) {
        const subject = `${type === "program" ? "Program" : "Workout"} Cancelled`;
        const html = `
          <h3>You cancelled your ${type}:</h3>
          <p><b>${itemName}</b> has been successfully cancelled.</p>
          <p>If this wasn’t you, please contact support.</p>
        `;
        emailPromises.push(
          transporter.sendMail({
            from: `"Musculo App" <${EMAIL_USER.value()}>`,
            to: userData.email,
            subject,
            html,
          })
        );
        console.log(`📧 Will email user (${userId})`);
      }


    // ✅ Send notifications if any exist
     if (messages.length > 0) {
      await Promise.all(messages.map((msg) => admin.messaging().send(msg)));
      console.log(`✅ Sent ${messages.length} cancellation FCM notifications`);
    } 

     // ✅ Send emails
      if (emailPromises.length > 0) {
        await Promise.all(emailPromises);
        console.log(`✅ Sent ${emailPromises.length} email notifications`);
      }

      if (messages.length === 0 && emailPromises.length === 0) {
        console.log("⚠️ No notifications sent (no preferences enabled)");
      }

    return { success: true };
  } catch (error) {
    console.error("❌ Error sending cancellation notification:", error);
    throw new HttpsError("internal", "Failed to send cancellation notification");
  }
});


// ✅ Unified helper: Send notification (Push + Email)
async function sendNotificationToUsersWithPreference(preferenceField, title, body, data = {}, emailUser, emailPass) {
  try {
    // 1️⃣ Get users who have both preferenceField & phoneNotifications on
    const usersSnapshot = await db
      .collection("users")
      .where(`notifications.${preferenceField}`, "==", true)
      .get();

    const pushTokens = [];
    const emailList = [];

    usersSnapshot.forEach((doc) => {
      const user = doc.data();
      const notifications = user.notifications || {};

      // Collect push tokens if phoneNotifications are ON
      if (notifications.phoneNotifications === true && user.fcmToken) {
        pushTokens.push(user.fcmToken);
      }

      // Collect email if emailNotifications are ON
      if (notifications.emailNotifications === true && user.email) {
        emailList.push(user.email);
      }
    });

    // =============================
    // 🔹 1. Send Push Notifications
    // =============================
    if (pushTokens.length > 0) {
      const message = {
        notification: { title, body },
        data,
        tokens: pushTokens,
      };

      const response = await admin.messaging().sendEachForMulticast(message);
      console.log(
        `✅ Sent ${response.successCount}/${pushTokens.length} push notifications for ${preferenceField}`
      );
    } else {
      console.log(`⚠️ No push tokens found for ${preferenceField}`);
    }

    // =============================
    // 🔹 2. Send Email Notifications
    // =============================
    if (emailList.length > 0) {
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: emailUser,
          pass: emailPass,
        },
      });

      const mailPromises = emailList.map((email) =>
        transporter.sendMail({
          from: `"Musculo App" <${emailUser}>`,
          to: email,
          subject: title,
          html: `
            <div style="font-family: Arial, sans-serif;">
              <h3>${title}</h3>
              <p>${body}</p>
              <hr/>
              <p style="font-size: 12px; color: #777;">
                You are receiving this email because you subscribed to ${preferenceField} notifications in Musculo App.
              </p>
            </div>
          `,
        })
      );

      await Promise.all(mailPromises);
      console.log(`📧 Sent ${emailList.length} email notifications for ${preferenceField}`);
    } else {
      console.log(`⚠️ No emails found for ${preferenceField}`);
    }

    return { success: true };
  } catch (error) {
    console.error(`❌ Error sending ${preferenceField} notifications:`, error);
    return { success: false, error };
  }
}


// when new program or workout is created 
exports.onProgramOrWorkoutCreated = onDocumentCreated(
  {
    document:"discovery/{docId}",
    secrets: [EMAIL_USER, EMAIL_PASS],
  },
  
  async (event) => {
  const data = event.data.data();
  const docId = event.params.docId;

  const isWorkout = !!data.workoutName;
  const isProgram = !!data.programName;

  // 🏋️ New workout created
  if (isWorkout) {
    const title = "New Workout Added!";
    const body = `Check out the new workout "${data.workoutName}" available now.`;
    await sendNotificationToUsersWithPreference("upcomingTrainingReminder", title, body, {
      type: "workout",
      id: docId,
    },
   process.env.EMAIL_USER,
   process.env.EMAIL_PASS
  );
  }

  // 📘 New program created
  if (isProgram) {
    const title = "New Program Added!";
    const body = `Discover the new program "${data.programName}" now available.`;
    await sendNotificationToUsersWithPreference("upcomingTrainingReminder", title, body, {
      type: "program",
      id: docId,
    },
    process.env.EMAIL_USER,
    process.env.EMAIL_PASS
  );
  }

  return null;
});

// when  programName, programPrice or workoutName, workoutPrice is updated 
exports.onProgramOrWorkoutNameChange = onDocumentUpdated(  
  {
    document:"discovery/{docId}",
    secrets: [EMAIL_USER, EMAIL_PASS],
  },
  async (event) => {
  const before = event.data.before.data();
  const after = event.data.after.data();
  const docId = event.params.docId;


  const isWorkout = !!after.workoutName;
  const isProgram = !!after.programName;
  // Compare old and new workoutName
  if (isWorkout && before.workoutName !== after.workoutName) {
    console.log(
      `🏋️ Workout name changed: '${before.workoutName}' → '${after.workoutName}'`
    );

    await sendNotificationToUsersWithPreference(
      "programOrWorkoutNameChanged",  // ✅ Only users where this == true
      "Workout Name Changed",
      `"${before.workoutName}" has been renamed to "${after.workoutName}".`,
      { type: "workout",
        id: docId,
        oldName: before.workoutName,
        newName: after.workoutName,
       },
      process.env.EMAIL_USER,
      process.env.EMAIL_PASS
    );
  }
  if (isProgram &&  before.programName !== after.programName) {
    console.log(
      `🏋️ program name changed: '${before.programName}' → '${after.programName}'`
    );

    await sendNotificationToUsersWithPreference(
      "programOrWorkoutNameChanged",  // ✅ Only users where this == true
      "Program Name Changed",
      `"${before.programName}" has been renamed to "${after.programName}".`,
      { type: "program",
        id: docId,
        oldName: before.programName,
        newName: after.programName,
         },
        process.env.EMAIL_USER,
        process.env.EMAIL_PASS
    );
  }

    if (before.price !== after.price) {
       let title, body, type, itemName;

       if (isWorkout) {
        title="Workout Price Updated";
        itemName = after.workoutName || "Workout";
        type="workout";
       }else if (isProgram) {
        title="Program Price Updated";
        itemName= after.programName || "Program";
        type = "program";
       }else{
        return null;
       }
    
   console.log(`💸 ${title}: "${itemName}" ${before.price} → ${after.price}`);

    await sendNotificationToUsersWithPreference(
      "programOrWorkoutPriceUpdated",  // ✅ Only users where this == true
      title,
       `The price for "${itemName}" changed from \$${before.price} to \$${after.price}.`,
      { 
        type,
        id: docId,
        oldPrice: before.price?.toString() ?? "N/A",
        newPrice: after.price?.toString() ?? "N/A",
      },
       process.env.EMAIL_USER,
       process.env.EMAIL_PASS
    );
  }

  return null;
});


// ✅ Main Cloud Function
exports.sendOtpIfUserExists = onCall(
  {
    secrets: [EMAIL_USER, EMAIL_PASS], // Attach secrets to function
   
    cors: true,
    enforceAppCheck: false
  },
  async (request) => {
    const email = request.data.email;

    if (!email) {
      throw new HttpsError("invalid-argument", "Email is required.");
    }

    try {
      const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: EMAIL_USER.value(),
          pass: EMAIL_PASS.value(),
        },
      });

      // 🔍 Check if user exists in Firebase Auth
      const userRecord = await admin.auth().getUserByEmail(email);

      // ✅ Generate 4-digit OTP
      const otp = Math.floor(1000 + Math.random() * 9000).toString();

      // 💾 Save OTP in Firestore (with TTL)
      await admin.firestore().collection("otp_verification").doc(email).set({
        otp,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: Date.now() + 3 * 60 * 1000 // 3 minutes
      });

      // 📧 Send OTP via email
      await transporter.sendMail({
        from: `"Musculo App" <${EMAIL_USER.value()}>`,
        to: email,
        subject: "Your OTP Code",
        html: `<h3>Your OTP is: <b>${otp}</b></h3><p>It will expire in 5 minutes.</p>`,
      });

      return { success: true, message: "OTP sent" };
    } catch (error) {
      if (error.code === "auth/user-not-found") {
        throw new HttpsError("not-found", "Email not registered.");
      }

      throw new HttpsError("internal", error.message);
    }
  }
);

// Verify OTP Function
exports.verifyPasswordResetOTP = onCall(
  {
    enforceAppCheck: false
  },
  async (request) => {
    const { email, otp } = request.data;

    if (!email || !otp) {
      throw new HttpsError('invalid-argument', 'Email and OTP are required.');
    }

    try {
      const otpDoc = await db.collection('otp_verification').doc(email).get();

      if (!otpDoc.exists) {
        throw new HttpsError('not-found', 'OTP not found for this email.');
      }

      const otpData = otpDoc.data();
      const { otp: storedOtp, expiresAt } = otpData;
      const now = Date.now();

      if (now > expiresAt) {
        // Clean up expired OTP
        await db.collection('otp_verification').doc(email).delete();
        throw new HttpsError('deadline-exceeded', 'OTP has expired. Please request a new one.');
      }

      if (otp !== storedOtp) {
        throw new HttpsError('permission-denied', 'Incorrect OTP.');
      }

      // Mark OTP as verified but don't delete it yet
      await db.collection('otp_verification').doc(email).update({
        verified: true,
        verifiedAt: admin.firestore.FieldValue.serverTimestamp()
      });

      return { 
        success: true, 
        message: 'OTP verified successfully. You can now reset your password.' 
      };
      
    } catch (error) {
      console.error('Error verifying OTP:', error);
      
      if (error instanceof HttpsError) {
        throw error;
      }
      
      throw new HttpsError('internal', 'Failed to verify OTP.');
    }
  }
);

// Reset Password Function
exports.resetPassword = onCall(
  {
    enforceAppCheck: false
  },
  async (request) => {
    const { email, otp, newPassword } = request.data;

    if (!email || !otp || !newPassword) {
      throw new HttpsError('invalid-argument', 'Email, OTP, and new password are required.');
    }

    if (newPassword.length < 6) {
      throw new HttpsError('invalid-argument', 'Password must be at least 6 characters long.');
    }

    try {
      const otpDoc = await db.collection('otp_verification').doc(email).get();

      if (!otpDoc.exists) {
        throw new HttpsError('not-found', 'OTP session not found.');
      }

      const otpData = otpDoc.data();
      const { otp: storedOtp, expiresAt, verified } = otpData;
      const now = Date.now();

      if (now > expiresAt) {
        await db.collection('otp_verification').doc(email).delete();
        throw new HttpsError('deadline-exceeded', 'OTP session has expired.');
      }

      if (otp !== storedOtp || !verified) {
        throw new HttpsError('permission-denied', 'Invalid or unverified OTP.');
      }

      // Get user and update password
      const userRecord = await admin.auth().getUserByEmail(email);
      await admin.auth().updateUser(userRecord.uid, {
        password: newPassword
      });

      // Clean up OTP document
      await db.collection('otp_verification').doc(email).delete();

      return { 
        success: true, 
        message: 'Password reset successfully. You can now login with your new password.' 
      };
      
    } catch (error) {
      console.error('Error resetting password:', error);
      
      if (error.code === 'auth/user-not-found') {
        throw new HttpsError('not-found', 'User not found.');
      }
      
      if (error instanceof HttpsError) {
        throw error;
      }
      
      throw new HttpsError('internal', 'Failed to reset password.');
    }
  }
);

// Stripe Payment Intent Function
exports.stripePaymentintentRequest = onCall(
  { 
    enforceAppCheck: false // Changed to false for testing, change back to true in production
  }, 
  async (request) => {
    try {
      const { email, amount } = request.data;

      if (!email || !amount) {
        throw new HttpsError("invalid-argument", "Missing email or amount.");
      }

      let customerId;
      const customerList = await stripe.customers.list({
        email: email,
        limit: 1,
      });

      if (customerList.data.length > 0) {
        customerId = customerList.data[0].id;
      } else {
        const customer = await stripe.customers.create({
          email: email
        });
        customerId = customer.id;
      }

      const ephemeralKey = await stripe.ephemeralKeys.create( 
        { customer: customerId },           
        { apiVersion: '2024-06-20' }
      );
  
      const paymentIntent = await stripe.paymentIntents.create({
        amount:Math.round(Number(amount)),
        currency: 'eur',
        customer: customerId,
        automatic_payment_methods: {
        enabled: true,
        },
        setup_future_usage: 'off_session',
      });

      return { 
        paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: customerId,
        success: true,
        message: "Payment intent created successfully"
      };
    } catch (error) {
      console.error("Stripe Payment Intent Error:", error.message);
      throw new HttpsError("unknown", error.message);
    }
  }
);

exports.registerUser = onCall(async (request) => {
  const { email, password, name, gender, age, level_of_fitness } = request.data;
  
  if (!email || !password) {
    console.error('Missing email or password');
    throw new HttpsError(
      'invalid-argument',
      'Email and password are required.'
    );
  }

  if (password.length < 6) {
    console.error('Password too short');
    throw new HttpsError(
      'invalid-argument',
      'Password must be at least 6 characters long.'
    );
  }

  try {
    // 🔐 Create Firebase Auth user
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password, 
    });
    
    const uid = userRecord.uid;
    
    // 🔥 Save to Firestore
    await admin.firestore().collection("users").doc(uid).set({
      email: email,
      name: name,
      gender: gender,
      role: "user",
      age: age,
      profileImageUrl: null,
      userid: uid,
      level_of_fitness: level_of_fitness || null,
      dateOB: null,
      overviewText: "",
      experienceText: "",
      goalText: "",
      favExercise: "",
      status: "active",
      list_of_programs: [],
      list_of_workouts: [],
      finishedwork: 0,
      spentMins: 0,
      sold: [],
      subPlane: "free",
      rating: 0.0,
      review: [],
      countRating: 0,
      withdraw: 0.0,
      subscriptionDate: null,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return {
      success: true,
      uid,
      message: "User registered and data saved successfully",
    };
  } catch (error) {
    console.error('Error creating user or Firestore document:', error);

    if (error.code === 'auth/email-already-in-use') {
      throw new HttpsError(
        'already-exists',
        'The provided email is already in use by an existing user.'
      );
    } else if (error.code === 'auth/invalid-email') {
      throw new HttpsError(
        'invalid-argument',
        'The email address is not valid.'
      );
    } else if (error.code === 'auth/weak-password') {
      throw new HttpsError(
        'invalid-argument',
        'The password is too weak. It must be at least 6 characters long.'
      );
    }

    // Default fallback
    throw new HttpsError(
      'unknown',
      'An unknown error occurred during user creation.',
      error.message
    );
  }
});

exports.creatorPlane = onCall(async (request) => {
  const { userid, name, overviewText, experienceText, goalText, planType } = request.data;

  if (!userid) {
    throw new HttpsError('invalid-argument', 'User ID (uid) is required.');
  }

  try {
    const userRef = admin.firestore().collection("users").doc(userid);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw new HttpsError('not-found', 'User not found.');
    }

    const updates = {
      ...(name && { name }),
      role: 'creator', // Always update role to creator
      subPlane: planType ?? 'premium',
      ...(overviewText && { overviewText }),
      ...(experienceText && { experienceText }),
      ...(goalText && { goalText }),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await userRef.update(updates);

    return {
      success: true,
      message: 'User profile updated successfully.',
      updatedFields: updates,
    };

  } catch (error) {
    console.error('Error updating user profile:', error);
    throw new HttpsError('unknown', 'An error occurred while updating the user profile.', error.message);
  }
});

exports.cancelcreatorPlane = onCall(async (request) => {
  const { userid } = request.data;

  if (!userid) {
    throw new HttpsError('invalid-argument', 'User ID (uid) is required.');
  }

  try {
    const userRef = admin.firestore().collection("users").doc(userid);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw new HttpsError('not-found', 'User not found.');
    }

    const updates = {
      role: 'user',
      subPlane: 'free',
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    };

    await userRef.update(updates);

    return {
      success: true,
      message: 'User profile updated successfully.',
      updatedFields: updates,
    };

  } catch (error) {
    console.error('Error updating user profile:', error);
    throw new HttpsError('unknown', 'An error occurred while updating the user profile.', error.message);
  }
});