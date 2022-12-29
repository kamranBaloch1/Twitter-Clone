import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/Home.dart';

class PostMethods {
  String uid = sharedPreferences!.getString("UID").toString();
  String photoUrl = sharedPreferences!.getString("PHOTOURL").toString();
  String username = sharedPreferences!.getString("USERNAME").toString();

  // share image post

  sharePostImageFirestote(String caption, XFile postUrl) async {
    try {
      //uploading the image in the firebase storage
      String? downloadUrl;
      String postId = DateTime.now().millisecondsSinceEpoch.toString();

      Reference ref =
          FirebaseStorage.instance.ref().child("Posts").child(postId);
      UploadTask uploadTask = ref.putFile(File(postUrl.path));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      await snapshot.ref.getDownloadURL().then((url) {
        downloadUrl = url;
      });

      //  Saving the post in user collection
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(uid)
          .collection("Posts")
          .doc(postId)
          .set({
        "postId": postId,
        "caption": caption,
        "username": username,
        "userProfileUrl": photoUrl,
        "postUrl": downloadUrl,
        "likes": [],
        "uid": uid,
        "location": "",
        "createdOn": DateTime.now()
      });
      //  Saving the post in post collection
      await FirebaseFirestore.instance.collection("Posts").doc(postId).set({
        "postId": postId,
        "caption": caption,
        "username": username,
        "userProfileUrl": photoUrl,
        "postUrl": downloadUrl,
        "likes": [],
        "uid": uid,
        "location": "",
        "createdOn": DateTime.now()
      });

      // Navigation the user in home page
      Fluttertoast.showToast(
          msg: "Tweet is been posted", toastLength: Toast.LENGTH_LONG);
      Get.offAll(HomeScreen());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
  // share text post

  // shareTextPostFirestote(String tweet) async {
  //   try {
  //     String postId = DateTime.now().millisecondsSinceEpoch.toString();

  //     //  Saving the post in user collection
  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(uid)
  //         .collection("Posts")
  //         .doc(postId)
  //         .set({
  //        "postId": postId,
  //       "caption": tweet,
  //       "type": "text",
  //        "postUrl": "",
  //        "isTextPost":true,
  //       "username": username,
  //       "userProfileUrl": photoUrl,
  //       "likes": [],
  //       "uid": uid,
  //       "location": "",
  //       "createdOn": DateTime.now()
  //     });
  //     //  Saving the post in post collection
  //     await FirebaseFirestore.instance.collection("Posts").doc(postId).set({
  //       "postId": postId,
  //       "caption": tweet,
  //       "type": "text",
  //       "postUrl": "",
  //        "isTextPost":true,
  //       "username": username,
  //       "userProfileUrl": photoUrl,
  //       "likes": [],
  //       "uid": uid,
  //       "location": "",
  //       "createdOn": DateTime.now()
  //     });

  //     // Navigation the user in home page
  //     Fluttertoast.showToast(
  //         msg: "Tweet is been posted", toastLength: Toast.LENGTH_LONG);
  //     Get.offAll(HomeScreen());
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
  //   }
  // }
}
