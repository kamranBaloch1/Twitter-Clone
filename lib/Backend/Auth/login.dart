import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Auth/Common/startScreen.dart';
import 'package:twitter_clone/Screens/Auth/Login/emailScreen.dart';

import 'package:twitter_clone/Screens/Home/HomeScreens/Home.dart';

class LoginMethods {
  LoginWithEmailAndPassword( email, String password) async {
    try {
      User? currentUser;
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        currentUser = value.user;
      });

      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser!.uid)
            .get()
            .then((record) async{
          if (record.data()!['account_completed'] == true) {
            if (record.data()!['account_status'] == true) {
             
            //  Saving userinfo to sharedPref

            await sharedPreferences!.setStringList("FOLLOWERS", record.data()!['followers'].cast<String>());
            await sharedPreferences!.setStringList("FOLLOWING", record.data()!['following'].cast<String>());
            await sharedPreferences!.setString("NAME", record.data()!['name']);
            await sharedPreferences!.setString("EMAIL", record.data()!['email']);
            await sharedPreferences!.setString("DOB", record.data()!['dateOfBirth']);
            await sharedPreferences!.setString("UID", currentUser!.uid);
            await sharedPreferences!.setString("PHOTOURL", record.data()!['profileUrl']);
            await sharedPreferences!.setString("USERNAME", record.data()!['username']);
            await sharedPreferences!.setString("COVER_PHOTO",record.data()!['cover_photo']);
            await sharedPreferences!.setString("BIO", record.data()!['bio']);
        
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
                msg: "No user found for that email or password.", toastLength: Toast.LENGTH_LONG);
          }
        });
        
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email or password.",
            toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "No user found for that email or password.",
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }


  // Forgot Password 

  ResendPassword(String email)async{
   try {
        await FirebaseAuth.instance
    .sendPasswordResetEmail(email: email).then((value) {
  
       Fluttertoast.showToast(
            msg: "We have sent a password reset link to this email",
            toastLength: Toast.LENGTH_LONG);
            Get.offAll(StartScreen());
    });
   } catch (e) {
      Fluttertoast.showToast(
            msg: "There is no user records corresponding this email address",
            toastLength: Toast.LENGTH_LONG);
   }
  }
}
