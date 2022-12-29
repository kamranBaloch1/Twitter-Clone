import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/Backend/Auth/googleLogin.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Auth/Login/emailScreen.dart';
import 'package:twitter_clone/Screens/Auth/Regitser/registerScreen.dart';
import 'package:twitter_clone/Widget/CustomButton.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLoading ? bgColor : Colors.white,
      body: SafeArea(
        child: _isLoading
            ? AlertLoadingBar(message: "please wait...")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/img/icon.png",
                        width: 35.w,
                        height: 35.h,
                      )),
                  SizedBox(
                    height: 120.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 33.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "See what's  ",
                          style: TextStyle(
                            fontSize: 29.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "happening in the ",
                          style: TextStyle(
                            fontSize: 29.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "world right now. ",
                          style: TextStyle(
                            fontSize: 29.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Timer(Duration(seconds: 2), () {
                              setState(() {
                                _isLoading = true;
                              });
                            });
                            await GoogleAuthMethods()
                                .signInWithGoogle()
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                            });
                          },
                          child: Container(
                            width: 270.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 8.h),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(30.r)),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  "assets/img/googleIcon.png",
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                Expanded(
                                  child: Text(
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    "Continue with Google",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: CustomButton(
                            "Create account",
                            270.w,
                            43.h,
                            Colors.black,
                            20,
                            Colors.white,
                            16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "By signing up, you agree to our ",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              "Terms",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 103, 177, 238)),
                            ),
                            Text(
                              ", ",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              "Privacy",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 103, 177, 238)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Policy",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 103, 177, 238)),
                            ),
                            Text(
                              ", and",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              " Cookie Use",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 103, 177, 238)),
                            ),
                            Text(
                              ".",
                              style: TextStyle(
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Have an account already? ",
                              style: TextStyle(
                                  fontSize: 18.2.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black45),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EmailScreen()),
                                );
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                    fontSize: 18.2.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
