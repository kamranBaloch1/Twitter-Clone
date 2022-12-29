
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/models/postModel.dart';

class PostDesign extends StatefulWidget {
  PostModel postModel;
  PostDesign({super.key, required this.postModel});

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  String img = sharedPreferences!.getString("PHOTOURL").toString();
  
  // String cover = sharedPreferences!.getString(").toString();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage:
                  NetworkImage(widget.postModel.profileUrl.toString()),
            ),
            SizedBox(
              width: 15.w,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Text(
                widget.postModel.username.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.sp),
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Text(DateFormat.yMMMEd()
                  .format(widget.postModel.createdOn!.toDate())),
            )
          ],
        ),
      
        Container(
                padding: EdgeInsets.only(
                  left: 50.w,
                  bottom: 10.h,
                ),
                margin: EdgeInsets.only(right: 5.w),
                child: Text(
                  widget.postModel.caption.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
              ),
                Container(
                  padding: EdgeInsets.only(
                    left: 50.w,
                  ),
                  child: Image.network(
                   widget.postModel.postUrl.toString(),
                    width: 250.w,
                    height: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
        Padding(
          padding: EdgeInsets.only(left: 50.w, top: 10.h),
          child: Row(
            children: [
              DataRow(icon: Icons.comment, text: "22"),
              SizedBox(
                width: 15.h,
              ),
              DataRow(icon: Icons.favorite, text: "62"),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        )
      ],
    );
  }
}

class DataRow extends StatelessWidget {
  String text;
  IconData icon;
  DataRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.black54),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black54),
        )
      ],
    );
  }
}
