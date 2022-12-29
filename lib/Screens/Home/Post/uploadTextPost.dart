import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/Backend/Home/post.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Widget/CustomButton.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';

class UploadTextPost extends StatefulWidget {
  const UploadTextPost({super.key});

  @override
  State<UploadTextPost> createState() => _UploadTextPostState();
}

class _UploadTextPostState extends State<UploadTextPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

//Shared pref vaiables
  String? profileUrl = sharedPreferences!.getString("PHOTOURL");

  // Textediting controllers

  TextEditingController tweet = new TextEditingController();

  bool _isloading = false;

  // Uplaod post function

  savePost() async {
    String tweets = tweet.text.trim();

    if (tweets.isNotEmpty) {
      setState(() {
        _isloading = true;
      });

      // await PostMethods().shareTextPostFirestote(tweets);
      setState(() {
        _isloading = false;
      });
    } else {
      Fluttertoast.showToast(
          msg: "Please write something", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isloading ? bgColor : Colors.white,
      body: _isloading
          ? AlertLoadingBar(message: "loading...")
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 12.w, top: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                size: 25.sp,
                              )),
                          GestureDetector(
                            onTap: () {
                              savePost();
                            },
                            child: CustomButton("Tweet", 70.w, 34.h,
                                Colors.blue, 20.r, Colors.white, 16.sp),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w, top: 30.h),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(profileUrl!),
                      ),
                    ),
                    Container(
                      width: 200.w,
                      margin: EdgeInsets.symmetric(
                          horizontal: 50.w, vertical: 10.h),
                      child: TextField(
                        controller: tweet,
                        decoration: InputDecoration(
                            hintText: "What's happening?",
                            border: InputBorder.none),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, left: 30.w),
                      child: CustomButton("Add location", 100.w, 40.h, bgColor,
                          20.r, Colors.white, 15.sp),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
