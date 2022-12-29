

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_clone/Backend/Auth/signup.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Widget/CustomTextField.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {

  TextEditingController username = new TextEditingController();
   bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    username.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isloading?bgColor:Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: _isloading ? AlertLoadingBar(message: "Please wait..."): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10.h,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/img/icon.png",
                    width: 30.w,
                    height: 30.h,
                  )),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "What should we call you?",
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                "Your @username is unique. You can always",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h,),
              Text(
                "change it later",
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.h,),
               
               CustomTextField("Username", 320.w, 45.h, username, true),
              
                 SizedBox(height: 340.h,),  
                Divider(
                  thickness: 1,
                ),
      
                 GestureDetector(
                  onTap: ()async{
                    
                  String  name = username.text.trim().toLowerCase();
                    if(name.isNotEmpty){
                        setState(() {
                        _isloading = true;
                        });
                        await SignupMethods().SavingTheUsername(name);
                          setState(() {
                           _isloading = false;
                        });

                    }else{
                      Fluttertoast.showToast(msg: "Please write your username",toastLength: Toast.LENGTH_LONG);
                    }
                  },
                   child: Container(
                     alignment: Alignment.bottomRight,
                     child: Container(
                          margin: EdgeInsets.only(right: 15.w),
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
        )),
      ),
    );
  }
}
