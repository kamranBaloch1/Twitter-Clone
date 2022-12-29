import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/Global/global.dart';



PreferredSizeWidget CustomAppbar() {
   String? profileUrl = sharedPreferences!.getString("PHOTOURL");
  return AppBar(
    backgroundColor: Colors.white,
    iconTheme:IconThemeData(color: Colors.black),
    centerTitle: true,
    title: Image(
      image: AssetImage(
        "assets/img/icon.png",
      ),
      width: 25.w,
      height: 25.h,
    ),
  actions: [
   Padding(
     padding:  EdgeInsets.only(right: 10.w),
     child: CircleAvatar(
      radius: 15.r,
      backgroundImage: NetworkImage(profileUrl!),
     ),
   )
  ],
  );
}
