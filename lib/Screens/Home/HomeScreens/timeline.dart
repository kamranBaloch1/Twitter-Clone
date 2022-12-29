

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/Screens/Auth/Common/startScreen.dart';
import 'package:twitter_clone/Screens/Home/Post/UploadPost.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen({super.key});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
   body: Center(
    child: 
   
     GestureDetector(
      onTap: (){
      FirebaseAuth.instance.signOut();
      Get.offAll(StartScreen());
      },
      child: Text("Baluch"))
   
   ),
     floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadPost()),
            );
        },
        child:  Icon(Icons.add,size: 30.sp,),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation:    FloatingActionButtonLocation.miniEndFloat,

     
    );
  }
}