 
 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:line_icons/line_icons.dart';
import 'package:twitter_clone/Screens/Home/Post/UploadPost.dart';
import 'package:twitter_clone/Screens/Home/Post/uploadTextPost.dart';

 showUsernameDialog(BuildContext context) {
    // set up the button
    Widget image =  ListTile(
            leading: Icon(LineIcons.image),
            title: Text(
              "Photos",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
            onTap: () {
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadPost()),
            );
            },
          );
    Widget tweet =  ListTile(
            leading:Icon(LineIcons.twitter),
            title: Text(
              "Tweet",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
            onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const  UploadTextPost()),
            );
            },
          );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
     
      actions: [
        tweet,
        image
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

