import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Home/Post/postDesign.dart';
import 'package:twitter_clone/Widget/CustomButton.dart';
import 'package:twitter_clone/Widget/LoadinBar.dart';
import 'package:twitter_clone/models/postModel.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  String cuid = sharedPreferences!.getString("UID").toString();

  var userInfo = {};
  dynamic? followers;
  dynamic? following;
  bool isLoading = true;

  getUserInfo() async {
    var query =
        await FirebaseFirestore.instance.collection("Users").doc(cuid).get();
    userInfo = query.data()!;
    followers = query.data()!['followers'].length;
    following = query.data()!['following'].length;
    setState(() {
      isLoading = false;
    });
  }

//  String formattedDate =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isLoading ? bgColor : Colors.white,
      body: isLoading
          ? AlertLoadingBar(message: "Loading...")
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.h,
                  ),
                  //Showing user profile information
                  Stack(
                    children: [
                      if (userInfo['cover_photo'] != "")
                        Container(
                          child: Image.network(
                            userInfo['cover_photo'],
                            width: MediaQuery.of(context).size.width,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150.h,
                          decoration: BoxDecoration(color: bgColor),
                        ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(top: 110.h, left: 20.w),
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundImage: NetworkImage(userInfo['profileUrl']),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: Container(
                              alignment: Alignment.bottomRight,
                              child: CustomButton(
                                  "Edit profile",
                                  100.w,
                                  40.h,
                                  Color.fromARGB(255, 226, 218, 218),
                                  30.r,
                                  Colors.black,
                                  14.sp)),
                        ),
                        Text(userInfo['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.black)),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          " @" + userInfo['username'],
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          userInfo['bio'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomRow(
                            icon: Icons.circle,
                            text: "Born " + userInfo['dateOfBirth']),
                        SizedBox(
                          height: 5.h,
                        ),
                        CustomRow(
                            icon: Icons.calendar_month_outlined,
                            text: "Joined " +
                                DateFormat.yMMM().format(
                                    (userInfo['createdOn'] as Timestamp)
                                        .toDate())),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            CustomFollowRow(
                                followLength: following,
                                followTitle: "Following"),
                            SizedBox(
                              width: 20.h,
                            ),
                            CustomFollowRow(
                                followLength: followers,
                                followTitle: "Followers")
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Text("Tweets",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19.sp,
                                color: Colors.black)),
                        Divider(
                          height: 50.h,
                          thickness: 2,
                        ),

                        //showing timline posts

                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Posts")
                              .where("uid", isEqualTo: cuid)
                              
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                setState(() {
                                  isLoading = true;
                                });
                                return AlertLoadingBar(message: "loading...");
                              } else if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      PostModel postModel = PostModel.fromJson(
                                          snapshot.data.docs[index].data()
                                              as Map<String, dynamic>);
                                      return PostDesign(postModel: postModel);
                                    });
                              } else {
                                return Center(
                                  child: Text("some thing went wrong"),
                                );
                              }
                            } else {
                              return Center(
                                child: Text("No Posts"),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  //Showing user profile information end
                ],
              ),
            ),
    );
  }
}

class CustomRow extends StatelessWidget {
  String text;
  IconData icon;
  CustomRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 20.sp,
          color: Colors.black54,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}

class CustomFollowRow extends StatelessWidget {
  String followTitle;
  int followLength;
  CustomFollowRow(
      {super.key, required this.followTitle, required this.followLength});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          followLength.toString(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          followTitle,
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
