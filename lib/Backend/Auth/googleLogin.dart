import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Auth/Regitser/dateOfBirthScreen.dart';
import 'package:twitter_clone/Screens/Auth/Regitser/usernameScreen.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/Home.dart';

class GoogleAuthMethods {
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        UserCredential usercredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (usercredential != null) {
          if (usercredential.additionalUserInfo!.isNewUser) {
            String currentuserId = FirebaseAuth.instance.currentUser!.uid;

            await FirebaseFirestore.instance
                .collection("Users")
                .doc(currentuserId)
                .set({
              "uid": currentuserId,
              "name": usercredential.user!.displayName,
              "email": usercredential.user!.email,
              "password": "googleAccount",
              "dateOfBirth": "",
              "username": "",
              "profileUrl": usercredential.user!.photoURL.toString(),
              "account_status": true,
              "account_completed": false,
              "online": true,
              "bio": "",
              "cover_photo": "",
              "followers": [],
              "following": [],
              "createdOn": DateTime.now()
            }).then((value) async {
              ///Saving userInfo to firestore

              await sharedPreferences!.setString(
                  "NAME", usercredential.user!.displayName.toString());
              await sharedPreferences!.setString(
                  "PHOTOURL", usercredential.user!.photoURL.toString());
              await sharedPreferences!.setString("UID", currentuserId);
              await sharedPreferences!
                  .setString("EMAIL", usercredential.user!.email.toString());
              await sharedPreferences!.setStringList("FOLLOWING", []);
              await sharedPreferences!.setStringList("FOLLOWERS", []);
              await sharedPreferences!.setString("COVER_PHOTO", "");
              await sharedPreferences!.setString("BIO", "");

              ///Navigating to date of Birth Screen

              Get.offAll(DateOfBirthScreen());
            });
          }

          ///If user is not a new  user

          else {
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((record) async {
              if (record.data()!['account_completed'] == true) {
                if (record.data()!['account_status'] == true) {
                  //  Saving userinfo to sharedPref

                  await sharedPreferences!.setStringList(
                      "FOLLOWERS", record.data()!['followers'].cast<String>());
                  await sharedPreferences!.setStringList(
                      "FOLLOWING", record.data()!['following'].cast<String>());
                  await sharedPreferences!
                      .setString("NAME", record.data()!['name']);
                  await sharedPreferences!
                      .setString("EMAIL", record.data()!['email']);
                  await sharedPreferences!
                      .setString("DOB", record.data()!['dateOfBirth']);
                  await sharedPreferences!
                      .setString("COVER_PHOTO", record.data()!['cover_photo']);
                  await sharedPreferences!
                      .setString("BIO", record.data()!['bio']);
                  await sharedPreferences!
                      .setString("UID", FirebaseAuth.instance.currentUser!.uid);
                  await sharedPreferences!
                      .setString("PHOTOURL", record.data()!['profileUrl']);
                  await sharedPreferences!
                      .setString("USERNAME", record.data()!['username']);

                  Fluttertoast.showToast(
                      msg: "Welcome back ${record.data()!['name']}",
                      toastLength: Toast.LENGTH_LONG);
                  Get.offAll(HomeScreen());
                } else {
                  FirebaseAuth.instance.signOut();
                  Fluttertoast.showToast(
                      msg: "Your acccount is been blocked.",
                      toastLength: Toast.LENGTH_LONG);
                }
              } else {
                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(
                    msg: "No user found for that email or password.",
                    toastLength: Toast.LENGTH_LONG);
              }
            });
          }
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  ///Saving the user Date of birth

  SavingTheUserDateOfBirth(String dob) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "dateOfBirth": dob,
      }).then((value) async {
        await sharedPreferences!.setString("DOB", dob);

        ///Navigating to username screen
        Get.offAll(UsernameScreen());
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
}
