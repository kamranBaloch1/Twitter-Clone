
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CustomTextField(String labelText, double width,double heigth ,TextEditingController controller,bool enable){
  return Container(
    width: width,
    height: heigth,
    child: TextField(
      
      enabled: enable,
      controller: controller,
            decoration: InputDecoration(
                labelText: labelText,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r))),
            onChanged: (value) {
              
               
            },
),
  );

}