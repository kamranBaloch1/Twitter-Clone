

import 'package:flutter/cupertino.dart';

Widget CustomButton(String title,double width,double height,Color bgColor,double brdRadius,Color txtColor,double textSize){
  return Container(
    alignment: Alignment.center,
    width:width ,
    height: height,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(brdRadius)
    ),
    child: Text(title,style: TextStyle(
      color: txtColor,
      fontWeight: FontWeight.bold,
      fontSize: textSize
    ),),
  );
}