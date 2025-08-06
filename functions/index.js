const { onCall } = require("firebase-functions/v2/https");
const { HttpsError } = require("firebase-functions/v2/https");
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
  const { userid, name, overviewText, experienceText, goalText } = request.data;

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
      subPlane: 'premium',
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