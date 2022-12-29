import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/Backend/Auth/signup.dart';
import 'package:twitter_clone/Widget/CustomTextField.dart';

import 'package:twitter_clone/Widget/LoadinBar.dart';
import 'package:twitter_clone/Widget/PasswordFiledWidget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameC = new TextEditingController();
  TextEditingController _emailC = new TextEditingController();
  TextEditingController _dobC = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _nameC.dispose();
    _emailC.dispose();
    _dobC.dispose();
    _password.dispose();
    super.dispose();
  }

  var emailRegx = RegExp(
      "[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  bool _isLoading = false;

  SignupTheUser() async {
    String name = _nameC.text.trim();
    String email = _emailC.text.trim();
    String dob = _dobC.text.trim();
    String password = _password.text.trim();

    if (name.isNotEmpty && email.isNotEmpty && dob.isNotEmpty) {
      if (email.contains(emailRegx)) {
        if (password.length >= 8) {
          setState(() {
            _isLoading = true;
          });
          await SignupMethods().CreatingUserAccount(email, password, name, dob);
          setState(() {
            _isLoading = false;
          });
        } else {
          Fluttertoast.showToast(
              msg: "Password should be 8 characters long",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Please provide a valid email address",
            toastLength: Toast.LENGTH_LONG);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all fields", toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLoading ? Colors.blue : Colors.white,
      body: _isLoading
          ? AlertLoadingBar(message: "Loading...")
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
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
                    height: 20.h,
                  ),

                  Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 27.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100.h,
                  ),

                  CustomTextField("Name", 280.w, 45.h, _nameC, true),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextField("Email", 280.w, 45.h, _emailC, true),
                  SizedBox(
                    height: 24.h,
                  ),

                  PasswordFieldWidget(
                      controller: _password,
                      heigth: 45.h,
                      width: 280.w,
                      isObscure: true),
                  SizedBox(
                    height: 24.h,
                  ),

                  ///Date pciker start
                  Container(
                      width: 280.w,
                      height: 45.h,
                      child: Center(
                          child: TextField(
                        controller: _dobC,
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
                              _dobC.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ))),

                  // Date picker end

                  SizedBox(
                    height: 115.h,
                  ),
                  Divider(),

                  GestureDetector(
                    onTap: SignupTheUser,
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
    );
  }
}
