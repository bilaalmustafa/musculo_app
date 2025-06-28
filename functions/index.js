const {onCall, HttpsError} = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();


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
   
    // const userDoc = {
    //   email: email || null,
    //   name : name || null,
    //   gender:gender || null,
    //   role: "user",
    //   age: age || null,
    //   profileImageUrl: null,
    //   userid: uid,
    //   level_of_fitness:level_of_fitness || null,
    //   dateOB: null,
    //   overviewText: "",
    //   experienceText: "",
    //   goalText: "",
    //   favExercise: "",
    //   status: "active",
    //   list_of_programs: [],
    //   list_of_workouts: [],
    //   finishedwork: 0,
    //   spentMins: 0,
    //   sold: [],
    //   subPlane: null,
    //   rating: 0.0,
    //   review: [],
    //   countRating: 0,
    //   withdraw: 0.0,
    //   subscriptionDate: null,
    //   createdAt: admin.firestore.FieldValue.serverTimestamp(),
    // };
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
      subPlane: null,
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


// exports.createUser = functions.https.onCall(async (data, context) => {
//   // Check if user is authenticated
//   console.log("Creating user with context:", context.auth);
//   if (!context.auth) {

//     throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
//   }

//   const userId = context.auth.uid;
// console.log("Creating user with IDDDD:", userId);
//   const {
//     name,
//     gender,
//     age,
//     profileImageUrl,
//     levelOfFitness,
//     email,
//     dateOfBirth,
//     overviewText,
//     experienceText,
//     goalText,
//     favExercise
//   } = data;

//   try {
//     const userDoc = {
//       name: name || null,
//       role: "user",
//       gender: gender || null,
//       age: age || null,
//       profileImageUrl: profileImageUrl || null,
//       userid: userId,
//       level_of_fitness: levelOfFitness || null,
//       email: email || null,
//       dateOB: dateOfBirth || null,
//       overviewText: overviewText || "",
//       experienceText: experienceText || "",
//       goalText: goalText || "",
//       favExercise: favExercise || "",
//       status: "active",
//       list_of_programs: [],
//       list_of_workouts: [],
//       finishedwork: 0,
//       spentMins: 0,
//       sold: [],
//       subPlane: null,
//       rating: 0,
//       review: [],
//       countRating: 0,
//       withdraw: 0,
//       subscriptionDate: null,
//     };

//     await db.collection("users").doc(userId).set(userDoc);
//     return { success: true, message: "User created successfully" };
//   } catch (error) {
//     console.error("Error creating user:", error);
//     throw new functions.https.HttpsError('internal', 'Failed to create user');
//   }
// });
