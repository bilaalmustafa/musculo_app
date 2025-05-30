/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
const {onCall} = require("firebase-functions/v2/https");
const {logger} = require("firebase-functions"); // Recommended for structured logging
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore, Auth, etc.
const admin = require("firebase-admin");
const nodemailer = require("nodemailer");

admin.initializeApp();
const db = admin.firestore();
const auth = admin.auth();

// Configure Nodemailer using environment variables
// Ensure you have set these using:
// firebase functions:config:set gmail.email="YOUR_GMAIL_ADDRESS@gmail.com" gmail.password="YOUR_GENERATED_APP_PASSWORD"
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "user-email-here",
    pass: "user-app-password-here",
  },
});

// Helper: Generate 6-digit OTP
function generateOtp() {
  return Math.floor(100000 + Math.random() * 900000).toString(); // 6-digit OTP
}

// Helper: Get OTP expiration time (e.g., 5 minutes from now)
function getOtpExpirationTime() {
  return admin.firestore.Timestamp.fromDate(
    new Date(Date.now() + 5 * 60 * 1000) // 5 minutes
  );
}

/**
 * 1. sendOtpForPasswordReset: Sends an OTP to the user's email for password reset.
 * - Checks if the email belongs to an existing user.
 * - Generates and stores the OTP in Firestore with an expiration time.
 * - Sends the OTP via email using Nodemailer.
 */
exports.sendOtpForPasswordReset = onCall(async (request) => {
  // Add verbose logging for the incoming request data
  logger.info("🔥 sendOtpForPasswordReset: Raw incoming request:", JSON.stringify(request));
  logger.info("🔥 sendOtpForPasswordReset: Incoming data payload:", JSON.stringify(request.data));

  const email = request.data ? request.data.email : undefined; // Safely try to get email
  logger.info("🔥 sendOtpForPasswordReset: Extracted email value (before validation):", email);
  logger.info("🔥 sendOtpForPasswordReset: Type of extracted email:", typeof email);

  if (!email || typeof email !== 'string' || !email.includes('@')) {
    logger.error("🔥 sendOtpForPasswordReset: Email validation failed. Final check on email value:", email);
    throw new functions.https.HttpsError(
      "invalid-argument",
      "A valid email address is required."
    );
  }

  try {
    // 1. Check if user exists in Firebase Auth
    let userRecord;
    try {
      userRecord = await auth.getUserByEmail(email);
      logger.info(`User found for email: ${email}, UID: ${userRecord.uid}`);
    } catch (error) {
      if (error.code === 'auth/user-not-found') {
        logger.warn(`Attempted OTP send to non-existent user: ${email}`);
        throw new functions.https.HttpsError("not-found", "User not found with this email.");
      }
      logger.error("Error checking user existence:", error);
      throw new functions.https.HttpsError("internal", "Failed to check user existence.");
    }

    // 2. Generate OTP and expiration time
    const otp = generateOtp();
    const expiresAt = getOtpExpirationTime();

    // 3. Save OTP to Firestore (upsert: create or update)
    const otpRef = db.collection("otp_requests").doc(email);
    await otpRef.set({
      email: email,
      otp: otp,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      expiresAt: expiresAt,
      verified: false, // OTP has not been verified yet
      used: false,     // OTP has not been used for reset yet
      uid: userRecord.uid, // Store UID for later verification and reset
    });
    logger.info(`OTP ${otp} saved to Firestore for ${email}`);

    // 4. Email options
    const mailOptions = {
      from: "your-app-name <sender-email>", // Use your app name
      to: email,
      subject: "Your Password Reset OTP",
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; border: 1px solid #ddd; border-radius: 8px; overflow: hidden;">
          <div style="background-color: #f4f4f4; padding: 20px; text-align: center;">
            <h2 style="color: #333;">Password Reset Request</h2>
          </div>
          <div style="padding: 20px; text-align: center;">
            <p style="font-size: 16px; color: #555;">Your One-Time Password (OTP) for password reset is:</p>
            <div style="font-size: 36px; font-weight: bold; color: #007bff; padding: 15px 25px; background-color: #e9ecef; border-radius: 5px; display: inline-block; margin: 20px 0;">
              ${otp}
            </div>
            <p style="font-size: 14px; color: #888;">This code is valid for <strong>5 minutes</strong>.</p>
            <p style="font-size: 14px; color: #888;">If you did not request a password reset, please ignore this email.</p>
          </div>
          <div style="background-color: #f4f4f4; padding: 10px; text-align: center; font-size: 12px; color: #777;">
            &copy; ${new Date().getFullYear()} Your App Name. All rights reserved.
          </div>
        </div>
      `,
      text: `Your OTP code is: ${otp}. It expires in 5 minutes. If you didn't request this password reset, please ignore this email.`,
    };

    // 5. Send email
    await transporter.sendMail(mailOptions);
    logger.info(`OTP email sent successfully to ${email}`);

    return {
      success: true,
      message: "OTP sent successfully to your email."
    };

  } catch (error) {
    logger.error("Error in sendOtpForPasswordReset:", error);

    // Propagate HttpsErrors directly
    if (error instanceof functions.https.HttpsError) {
      throw error;
    }

    // Handle Nodemailer specific errors
    if (error.code === 'EAUTH' || error.responseCode === 535) {
      throw new functions.https.HttpsError("internal", "Email service authentication failed. Please check server configuration.");
    }

    // Generic error
    throw new functions.https.HttpsError("internal", "Failed to send OTP. Please try again later.");
  }
});

/**
 * 2. verifyOtp: Verifies the provided OTP against the stored one.
 * - Checks if the OTP exists, is not expired, and matches.
 * - Marks the OTP as verified if successful.
 */
exports.verifyOtp = onCall(async (request) => {
  const { email, otp } = request.data;

  logger.info("verifyOtp: Incoming data:", { email: email, otp: otp });

  if (!email || !otp || typeof email !== 'string' || typeof otp !== 'string') {
    logger.error("verifyOtp: Email or OTP missing/invalid.", { email: email, otp: otp });
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Email and OTP are required."
    );
  }

  try {
    const otpDocRef = db.collection("otp_requests").doc(email);
    const otpDoc = await otpDocRef.get();

    // 1. Check if OTP record exists
    if (!otpDoc.exists) {
      logger.warn(`Verification failed for ${email}: No OTP record found.`);
      throw new functions.https.HttpsError("not-found", "Invalid or expired OTP.");
    }

    const otpData = otpDoc.data();
    const currentTime = admin.firestore.Timestamp.now();

    // 2. Check if OTP has expired
    if (otpData.expiresAt.toDate() < currentTime.toDate()) {
      logger.warn(`Verification failed for ${email}: OTP expired.`);
      await otpDocRef.delete(); // Clean up expired OTP
      throw new functions.https.HttpsError("expired", "OTP has expired. Please request a new one.");
    }

    // 3. Check if OTP has already been verified/used
    if (otpData.verified === true) {
      logger.warn(`Verification failed for ${email}: OTP already verified.`);
      throw new functions.https.HttpsError("failed-precondition", "OTP already used or verified. Please request a new one.");
    }
    if (otpData.used === true) {
        logger.warn(`Verification failed for ${email}: OTP already used for reset.`);
        throw new functions.https.HttpsError("failed-precondition", "OTP already used for reset. Please request a new one.");
    }

    // 4. Check if provided OTP matches
    if (otpData.otp !== otp) {
      logger.warn(`Verification failed for ${email}: Incorrect OTP provided.`);
      throw new functions.https.HttpsError("unauthenticated", "Incorrect OTP. Please try again.");
    }

    // 5. Mark OTP as verified in Firestore
    await otpDocRef.update({
      verified: true,
      verifiedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    logger.info(`OTP successfully verified for ${email}`);

    return {
      success: true,
      message: "OTP verified successfully."
    };

  } catch (error) {
    logger.error("Error in verifyOtp:", error);

    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    throw new functions.https.HttpsError("internal", "Failed to verify OTP. Please try again.");
  }
});

/**
 * 3. resetPasswordWithOtp: Resets the user's password after OTP verification.
 * - Requires email, the original OTP, and the new password.
 * - Verifies the OTP (again, as a final check) and ensures it hasn't been used.
 * - Resets the password in Firebase Auth.
 * - Marks the OTP as "used" to prevent reuse.
 */
exports.resetPasswordWithOtp = onCall(async (request) => {
  const { email, otp, newPassword } = request.data;

  logger.info("resetPasswordWithOtp: Incoming data:", { email: email });

  if (!email || !otp || !newPassword || typeof email !== 'string' || typeof otp !== 'string' || typeof newPassword !== 'string') {
    logger.error("resetPasswordWithOtp: Missing email, OTP, or new password.");
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Email, OTP, and new password are required."
    );
  }

  if (newPassword.length < 6) { // Firebase Auth minimum password length
    logger.warn(`resetPasswordWithOtp: Password too short for ${email}.`);
    throw new functions.https.HttpsError(
      "invalid-argument",
      "New password must be at least 6 characters long."
    );
  }

  try {
    const otpDocRef = db.collection("otp_requests").doc(email);
    const otpDoc = await otpDocRef.get();

    // 1. Check if OTP record exists
    if (!otpDoc.exists) {
      logger.warn(`Password reset failed for ${email}: No OTP record found.`);
      throw new functions.https.HttpsError("not-found", "Invalid or expired OTP. Please request a new one.");
    }

    const otpData = otpDoc.data();
    const currentTime = admin.firestore.Timestamp.now();

    // 2. Re-verify OTP validity (even if verifyOtp was called before)
    if (otpData.expiresAt.toDate() < currentTime.toDate()) {
      logger.warn(`Password reset failed for ${email}: OTP expired.`);
      await otpDocRef.delete(); // Clean up expired OTP
      throw new functions.https.HttpsError("expired", "OTP has expired. Please request a new one.");
    }

    // 3. Ensure OTP was verified AND matches
    if (otpData.otp !== otp || otpData.verified !== true) {
      logger.warn(`Password reset failed for ${email}: OTP not verified or incorrect.`);
      throw new functions.https.HttpsError("unauthenticated", "Invalid or unverified OTP. Please verify your OTP first.");
    }

    // 4. Check if OTP has already been used
    if (otpData.used === true) {
      logger.warn(`Password reset failed for ${email}: OTP already used.`);
      throw new functions.https.HttpsError("already-exists", "This OTP has already been used. Please request a new one.");
    }

    // Get the user's UID using the stored UID from otp_requests
    const uid = otpData.uid;
    if (!uid) {
        logger.error(`UID not found in OTP record for ${email}. This should not happen if user existence was checked.`);
        throw new functions.https.HttpsError("internal", "User ID not found for password reset.");
    }

    // 5. Reset password in Firebase Auth
    await auth.updateUser(uid, { password: newPassword });
    logger.info(`Password successfully reset for user UID: ${uid}`);

    // 6. Mark OTP as used in Firestore
    await otpDocRef.update({
      used: true,
      usedAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    logger.info(`OTP marked as used for ${email}`);

    return {
      success: true,
      message: "Password reset successfully."
    };

  } catch (error) {
    logger.error("Error in resetPasswordWithOtp:", error);

    if (error instanceof functions.https.HttpsError) {
      throw error;
    }
    // Handle specific Firebase Auth errors for password update
    if (error.code === 'auth/user-not-found') {
        throw new functions.https.HttpsError("not-found", "User not found. Cannot reset password.");
    }
    if (error.code === 'auth/invalid-password') {
        throw new functions.https.HttpsError("invalid-argument", "The new password is too weak or invalid.");
    }

    throw new functions.https.HttpsError("internal", "Failed to reset password. Please try again.");
  }
});