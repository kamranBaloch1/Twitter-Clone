import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:twitter_clone/Screens/Auth/Common/startScreen.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(uid)
            .get()
            .then((record) async {
          if (record.data()!['account_completed'] == true) {
            if (record.data()!['account_status'] == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const StartScreen()),
              );
              Fluttertoast.showToast(
                  msg: "Your acccount is been blocked.",
                  toastLength: Toast.LENGTH_LONG);
            }
          } else {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StartScreen()),
            );
            Fluttertoast.showToast(
                msg: "No user found for that email or password.",
                toastLength: Toast.LENGTH_LONG);
          }
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StartScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150.h,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 100.w),
                child: Image.asset(
                  'assets/img/logo.png',
                  width: 140.w,
                ))
          ],
        ),
      ),
    );
  }
}
