import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/Backend/Auth/signup.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';

class ProfilePicScreen extends StatefulWidget {
  const ProfilePicScreen({super.key});

  @override
  State<ProfilePicScreen> createState() => _ProfilePicScreenState();
}

class _ProfilePicScreenState extends State<ProfilePicScreen> {
  XFile? pickedImg;
  bool _isloading = false;

  pickImageFromGallery() async {
    pickedImg = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isloading ? bgColor : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: _isloading
              ? AlertLoadingBar(message: "Saving profile picture...")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/img/icon.png",
                          width: 30.w,
                          height: 30.h,
                        )),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      "Pick a profile picture",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "Have a favorite selfie? Upload it now.",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    pickedImg != null
                        ? Container(
                            margin: EdgeInsets.only(left: 70.w, top: 50.h),
                            alignment: Alignment.center,
                            width: 155.w,
                            height: 160.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(pickedImg!.path))),
                                borderRadius: BorderRadius.circular(20.r)),
                          )
                        : Container(
                            margin: EdgeInsets.only(left: 70.w, top: 50.h),
                            alignment: Alignment.center,
                            width: 155.w,
                            height: 160.h,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(20.r)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      pickImageFromGallery();
                                    },
                                    icon: Icon(
                                      Icons.photo_camera,
                                      color: Colors.blue,
                                      size: 40.sp,
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "Upload",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                ),
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 220.h,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (pickedImg != null) {
                          setState(() {
                            _isloading = true;
                          });
                          await SignupMethods()
                              .SavingTheuserrofilePhoto(pickedImg!);
                          setState(() {
                            _isloading = false;
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please select a profile picture",
                              toastLength: Toast.LENGTH_LONG);
                        }
                      },
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 15.w),
                          alignment: Alignment.center,
                          width: 60.w,
                          height: 32.h,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        )),
      ),
    );
  }
}
