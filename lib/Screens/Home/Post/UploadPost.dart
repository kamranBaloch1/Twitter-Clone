import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/Backend/Home/post.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Widget/CustomButton.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';
import 'package:twitter_clone/enum/postEnum.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFromGallery();
  }

//Shared pref vaiables
  String? profileUrl = sharedPreferences!.getString("PHOTOURL");

  // Textediting controllers

  TextEditingController caption = new TextEditingController();

  //  geting the user image

  XFile? selectedImg;
  bool _isloading = false;

  getImageFromGallery() async {
    setState(() {
      _isloading = true;
    });
    selectedImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {});
    _isloading = false;
  }

  // Uplaod post function

  savePost() async {
    String cap = caption.text.trim();

    if (selectedImg != null) {
      if (cap.isNotEmpty) {
         setState(() {
          _isloading=true;
        });
       
        await PostMethods().sharePostImageFirestote(cap, selectedImg!);
        setState(() {
          _isloading=false;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Please write a caption", toastLength: Toast.LENGTH_LONG);
      }
    } else {
      Fluttertoast.showToast(
          msg: "An internal error accoured please try again",
          toastLength: Toast.LENGTH_LONG);
    }

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isloading? bgColor :Colors.white,
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
                            onTap:   (){
                              savePost();
                            },
                            child: CustomButton("Tweet", 70.w, 34.h, Colors.blue, 20.r,
                                Colors.white, 16.sp),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                      child: TextField(
                        controller: caption,
                        decoration: InputDecoration(
                            hintText: "Add a comment", border: InputBorder.none),
                      ),
                    ),
                    selectedImg != null
                        ? Container(
                            alignment: Alignment.center,
                            width: 300.w,
                            height: 200.h,
                            margin: EdgeInsets.only(left: 25.w),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: FileImage(File(selectedImg!.path))),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          )
                        : Text("Error"),
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
