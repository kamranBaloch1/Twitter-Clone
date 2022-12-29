import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/Backend/Auth/login.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Auth/Common/ForgotPasswordScreen.dart';
import 'package:twitter_clone/Widget/CustomTextField.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';
import 'package:twitter_clone/Widget/PasswordFiledWidget.dart';

class PasswordScreen extends StatefulWidget {
  String? email;
  PasswordScreen({super.key, required this.email});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var _emailC = new TextEditingController();
  TextEditingController _passwordC = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailC = new TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLoading ? bgColor : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: _isLoading
              ? AlertLoadingBar(message: "Please wait...")
              : Column(
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
                        "Enter your password",
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
                      child: CustomTextField("", 320.w, 52.h, _emailC, false),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: PasswordFieldWidget(
                            controller: _passwordC,
                            heigth: 53.h,
                            width: 320.w,
                            isObscure: true)),
                    SizedBox(
                      height: 290.h,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.w, vertical: 10.h),
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
                          onTap: () async {
                            String password = _passwordC.text.trim();
                            if (password.isNotEmpty) {
                              setState(() {
                                _isLoading = true;
                              });
                              await LoginMethods().LoginWithEmailAndPassword(
                                  widget.email, password);
                              setState(() {
                                _isLoading = false;
                              });
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
                              "Log in",
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
