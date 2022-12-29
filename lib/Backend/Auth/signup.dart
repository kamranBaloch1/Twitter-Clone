import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Auth/Regitser/profilPhotoScreen.dart';
import 'package:twitter_clone/Screens/Auth/Regitser/usernameScreen.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/Home.dart';

class SignupMethods {
  // Creating an user account

  CreatingUserAccount(
      String email, String password, String name, String dob) async {
    try {
      User? currentuser;
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        currentuser = auth.user;
      });

      if (currentuser != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(currentuser!.uid)
            .set({
          "uid": currentuser!.uid,
          "name": name,
          "email": email,
          "password": password,
          "dateOfBirth": dob,
          "username": "",
          "profileUrl": "",
          "account_status": true,
          "account_completed": false,
          "online":true,
          "bio":"",
          "cover_photo":"",
          "followers": [],
          "following": [],
          "createdOn": DateTime.now()
        }).then((value) async {
          
          await sharedPreferences!.setString("NAME", name);
          await sharedPreferences!.setString("DOB", dob);
          await sharedPreferences!.setString("UID", currentuser!.uid);
          await sharedPreferences!.setString("EMAIL", email);
          await sharedPreferences!.setString("COVER_PHOTO", "");
          await sharedPreferences!.setString("BIO", "");
          await sharedPreferences!.setStringList("FOLLOWING", []);
          await sharedPreferences!.setStringList("FOLLOWERS", []);
          
          Fluttertoast.showToast(
              msg: "Add a profile picture", toastLength: Toast.LENGTH_LONG);
          Get.offAll(ProfilePicScreen());
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "The password provided is too weak.",
            toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_LONG);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }


   ///  Saving the user profile photo


   SavingTheuserrofilePhoto(XFile photoUrl)async{
    try {
      String? downloadUrl;
      String uid = DateTime.now().millisecondsSinceEpoch.toString();

     Reference ref = FirebaseStorage.instance.ref().child("profilePics").child(uid);
     UploadTask uploadTask = ref.putFile(File(photoUrl.path));
     TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
     await snapshot.ref.getDownloadURL().then((url) {
          downloadUrl = url;
     });

       await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "profileUrl":downloadUrl
       }).then((value) async{
           await sharedPreferences!.setString("PHOTOURL", downloadUrl!);
          Fluttertoast.showToast(msg:"One step more", toastLength: Toast.LENGTH_LONG);
          Get.offAll(UsernameScreen());
       });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
   }
   ///  Saving the user profile photo


   SavingTheUsername(String username)async{
    try {
       await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).update({
        "username":username,
        "account_completed":true
       }).then((value) async{
        await sharedPreferences!.setString("USERNAME", username);
          Fluttertoast.showToast(msg:"Welcome  ${username}", toastLength: Toast.LENGTH_LONG);
          Get.offAll(HomeScreen());
       });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
   }





}
