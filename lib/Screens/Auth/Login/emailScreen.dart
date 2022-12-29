import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_clone/Screens/Auth/Common/ForgotPasswordScreen.dart';
import 'package:twitter_clone/Screens/Auth/Login/passwordScreen.dart';
import 'package:twitter_clone/Widget/CustomTextField.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController _emailC = new TextEditingController();
  var emailRegx = RegExp(
      "[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
             
             
             
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  "To get started, first enter",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Text(
                  "your email address",
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomTextField(
                    "Email address", 320.w, 52.h, _emailC, true),
              ),
              SizedBox(
                height: 320.h,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForgotPasswordScreen()));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(100.r)),
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_emailC.text.contains(emailRegx)) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PasswordScreen(email: _emailC.text.trim())),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please enter a correct email address",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.w),
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
