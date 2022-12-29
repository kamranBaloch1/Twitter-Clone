

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertLoadingBar extends StatelessWidget {
  String message;
   AlertLoadingBar({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        
        children: <Widget>[
              SizedBox(height: 250..h,),

           CircularProgressIndicator(
            color: Colors.white,
           ),

           SizedBox(height: 20..h,),

           Text(message,style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp
           ),)


        ],

      ),
    );
  }
}