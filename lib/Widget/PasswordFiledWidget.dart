
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




   class PasswordFieldWidget extends StatefulWidget {
    double? width;
    double? heigth; TextEditingController? controller;
    bool isObscure=true;


   PasswordFieldWidget({super.key, required this.controller,required this.heigth,required this.width,required this.isObscure});

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
    width: widget.width,
    height: widget.heigth,
    child: TextField(
      
      obscureText: widget.isObscure,
      controller: widget.controller,
            decoration: InputDecoration(
                labelText: "Password",
                 suffixIcon: IconButton(
                    icon: Icon(
                        widget.isObscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.isObscure = !widget.isObscure;
                      });
                    }),
  
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.r))),
            onChanged: (value) {
        
               
            },
),
  );

  }
}







