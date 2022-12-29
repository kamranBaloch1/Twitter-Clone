import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twitter_clone/Backend/Auth/googleLogin.dart';

import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Auth/Regitser/usernameScreen.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';

class DateOfBirthScreen extends StatefulWidget {
  const DateOfBirthScreen({super.key});

  @override
  State<DateOfBirthScreen> createState() => _DateOfBirthScreenState();
}

class _DateOfBirthScreenState extends State<DateOfBirthScreen> {
  TextEditingController dateInput = new TextEditingController();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    dateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isloading ? bgColor : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: _isloading
              ? AlertLoadingBar(message: "Please wait...")
              : Column(
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
                        "What is your birth",
                        style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "date?",
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
                        "This won't be public.",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      ///Date pciker start
                      Container(
                          width: 280.w,
                          height: 45.h,
                          child: Center(
                              child: TextField(
                            controller: dateInput,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                labelText: "Date of birth",
                                contentPadding: const EdgeInsets.all(15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.r))),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ))),

                      // Date picker end
                      SizedBox(
                        height: 340.h,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                          // alignment: Alignment.bottomRight,
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.offAll(UsernameScreen());
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15.w),
                              alignment: Alignment.center,
                              width: 60.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Text(
                                "Skip",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              String dofb = dateInput.text.trim();

                              if (dofb.isNotEmpty) {
                                setState(() {
                                  _isloading = true;
                                });

                                await GoogleAuthMethods()
                                    .SavingTheUserDateOfBirth(dofb);

                                setState(() {
                                  _isloading = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please select your date of birth",
                                    toastLength: Toast.LENGTH_LONG);
                              }
                            },
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
                        ],
                      )),
                    ]),
        )),
      ),
    );
  }
}
