const {onCall, HttpsError} = require("firebase-functions/v2/https");
const functions = require("firebase-functions");
const {defineSecret} = require("firebase-functions/params");
const admin = require("firebase-admin");
const nodemailer = require('nodemailer');
const stripe= require("stripe")("sk_test_51MikpdSDuIYZV8eSOEOY2Y5ZAECPFyujfeaREKy9bR5aAKc5TQD5HXkY5L7BscA6e9SXzqo7agNIgc6nIVaUWVes00c1S2vqZ3");
admin.initializeApp();
const db = admin.firestore();

const gmailEmail = defineSecret("GMAIL_EMAIL");
const gmailPassword = defineSecret("GMAIL_PASSWORD");


// Create transporter function to avoid recreating it
function createTransporter() {
  return nodemailer.createTransport({
    service: 'Gmail',
    auth: {
      user: gmailEmail.value(),
      pass: gmailPassword.value(),
    },
  });
}


function generateOTP() {
  return Math.floor(1000 + Math.random() * 9000).toString();
}

// Send OTP for Password Reset - Updated for v2
exports.sendPasswordResetOTP = onCall(
  { 
    secrets: [gmailEmail, gmailPassword],
    enforceAppCheck: false 
  }, 
  async (request) => {
    const { email } = request.data;

    if (!email) {
      throw new HttpsError('invalid-argument', 'Email is required.');
    }

    try {
      // Check if user exists in Firebase Auth
      let userExists = false;
      try {
        await admin.auth().getUserByEmail(email);
        userExists = true;
      } catch (authError) {
        if (authError.code !== 'auth/user-not-found') {
          throw authError;
        }
      }

      if (!userExists) {
        throw new HttpsError('not-found', 'No user found with this email address.');
      }

      const otp = generateOTP();
      const expiresAt = admin.firestore.Timestamp.fromDate(new Date(Date.now() + 10 * 60000)); // 10 min expiry

      await db.collection('password_resets').doc(email).set({
        otp,
        expiresAt,
        verified: false,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
      });

     const transporter = createTransporter();
      
      await transporter.sendMail({
        from: gmailEmail.value(),
        to: email,
        subject: 'Password Reset OTP - Your App Name',
        html: `
          <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px;">
            <h2 style="color: #333; text-align: center;">Password Reset Request</h2>
            <p>You have requested to reset your password. Please use the following OTP to proceed:</p>
            <div style="background-color: #f4f4f4; padding: 20px; text-align: center; margin: 20px 0; border-radius: 8px;">
              <h1 style="color: #2196F3; letter-spacing: 3px; margin: 0;">${otp}</h1>
            </div>
            <p><strong>This OTP will expire in 10 minutes.</strong></p>
            <p style="color: #666; font-size: 14px;">If you didn't request this password reset, please ignore this email and ensure your account is secure.</p>
          </div>
        `,
        text: `Your OTP for password reset is: ${otp}. It expires in 10 minutes.`
      });

      return { 
        success: true, 
        message: 'OTP sent to your email successfully.' 
      };
      
    } catch (error) {
      console.error('Error sending OTP:', error);
      
      if (error instanceof HttpsError) {
        throw error;
      }
      
      throw new HttpsError('internal', 'Failed to send OTP. Please try again.');
    }
  }
);

// Verify OTP - Updated
exports.verifyPasswordResetOTP = onCall(async (request) => {
  const { email, otp } = request.data;

  if (!email || !otp) {
    throw new HttpsError('invalid-argument', 'Email and OTP are required.');
  }

  try {
    const otpDoc = await db.collection('password_resets').doc(email).get();

    if (!otpDoc.exists) {
      throw new HttpsError('not-found', 'OTP not found for this email.');
    }

    const otpData = otpDoc.data();
    const { otp: storedOtp, expiresAt, verified } = otpData;
    const now = admin.firestore.Timestamp.now();

    if (now.toMillis() > expiresAt.toMillis()) {
      // Clean up expired OTP
      await db.collection('password_resets').doc(email).delete();
      throw new HttpsError('deadline-exceeded', 'OTP has expired. Please request a new one.');
    }

    if (otp !== storedOtp) {
      throw new HttpsError('permission-denied', 'Incorrect OTP.');
    }

    // Mark OTP as verified but don't delete it yet
    await db.collection('password_resets').doc(email).update({
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
});

// Reset Password - New function
exports.resetPassword = onCall(async (request) => {
  const { email, otp, newPassword } = request.data;

  if (!email || !otp || !newPassword) {
    throw new HttpsError('invalid-argument', 'Email, OTP, and new password are required.');
  }

  if (newPassword.length < 6) {
    throw new HttpsError('invalid-argument', 'Password must be at least 6 characters long.');
  }

  try {
    const otpDoc = await db.collection('password_resets').doc(email).get();

    if (!otpDoc.exists) {
      throw new HttpsError('not-found', 'OTP session not found.');
    }

    const otpData = otpDoc.data();
    const { otp: storedOtp, expiresAt, verified } = otpData;
    const now = admin.firestore.Timestamp.now();

    if (now.toMillis() > expiresAt.toMillis()) {
      await db.collection('password_resets').doc(email).delete();
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
    await db.collection('password_resets').doc(email).delete();

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
});


// Function to handle Stripe payment intent creation
exports.stripePaymentintentRequest= onCall( { enforceAppCheck: true, }, async(request)=>{
  
  try {
  const { email, amount, currency } = request.data;

    if (!email || !amount || !currency) {
      throw new HttpsError("invalid-argument", "Missing email, amount, or currency.");
    }


    let cunstomerId;
    const cunstomerList=await stripe.customers.list({
      email: email,
      limit:1,
    });
    if(cunstomerList.data.length>0){
      cunstomerId=cunstomerList.data[0].id;
    } else{
      const customer=await stripe.customers.create({
        email:email
      });
      cunstomerId=customer.id
    }
    const ephemeralKey = await stripe.ephemeralKeys.create( 
      { customer: cunstomerId },           
     { apiVersion: '2024-06-20' });
  
      const paymentIntent=await stripe.paymentIntents.create({
        amount: amount,
        currency:currency,
        customer: cunstomerId,
         automatic_payment_methods: {
        enabled: true,
      },
      });
     return { paymentIntent: paymentIntent.client_secret,
        ephemeralKey: ephemeralKey.secret,
        customer: cunstomerId,
        success:true,
        message: "Payment intent created successfully",}
  } catch (error) {
    console.error("Stripe Payment Intent Error:", error.message);
    throw new HttpsError("unknown", error.message);
  }
})




exports.registerUser = onCall(async (request) => {
    const {email, password, name,gender,age,level_of_fitness} =request.data;
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
      
      email: email ,
      name : name ,
      gender:gender ,
      role: "user",
      age: age,
      profileImageUrl: null,
      userid: uid,
      level_of_fitness:level_of_fitness || null,
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
  const { userid} = request.data;

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
      role: 'user', // Always update role to creator
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
