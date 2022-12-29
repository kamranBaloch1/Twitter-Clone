

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_clone/Backend/Auth/login.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Widget/CustomTextField.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forEmail = new TextEditingController();
  bool _isLoading = false;
   var emailRegx = RegExp(
      "[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  @override
  void dispose() {
    // TODO: implement dispose
    forEmail.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: _isLoading?bgColor:Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: 15.w),
            child: _isLoading? AlertLoadingBar(message: "Please wait"): Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 27.sp,
                          )),
                      SizedBox(
                        width: 120.w,
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/img/icon.png",
                            width: 30.w,
                            height: 30.h,
                          )),
                    ],
                  ),
                  SizedBox(height: 50.h,),
                   Text(
                      "Find your Twitter account",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                      SizedBox(height: 20.h,),
                   Text(
                      "Enter the, email associated with your",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h,),
                   Text(
                      "account to change your password",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                      SizedBox(height: 30.h,),

                    
                  CustomTextField("Email",320.w, 45.h, forEmail, true),

                     SizedBox(height: 290.h,),
              Divider(
                
                thickness: 1,
              ),

               GestureDetector(
                onTap: ()async{
                  String resetEmail = forEmail.text.trim();
                  if(resetEmail.isNotEmpty){
                     if(resetEmail.contains(emailRegx)){
                        setState(() {
                      _isLoading = true;
                    });
                    await LoginMethods().ResendPassword(resetEmail);
                    setState(() {
                      _isLoading = false;
                    });
                     }
                     else{
                    Fluttertoast.showToast(msg: "Please provide a valid email address" ,toastLength: Toast.LENGTH_LONG);
                  }
                  }else{
                    Fluttertoast.showToast(msg: "Please write your email address" ,toastLength: Toast.LENGTH_LONG);
                  }
                },
                 child: Container(
                   alignment: Alignment.bottomRight,
                   child: Container(
                        margin: EdgeInsets.only(right: 15.w,top: 20.h),
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
          ),
        ),
      ),


    );
  }
}