
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:twitter_clone/Global/global.dart';

import 'package:twitter_clone/Screens/Home/User/profile.dart';

class MyDrawer extends StatelessWidget {
  String? name = sharedPreferences!.getString("NAME");
  String? profileUrl = sharedPreferences!.getString("PHOTOURL");
  String? username = sharedPreferences!.getString("USERNAME");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            accountName: GestureDetector(
              onTap: (){
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserProfile()),
            );
              },
              child: Text(
                name!,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
            ),
            accountEmail: Text(
              "@${username}",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(profileUrl!),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Profile",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.topic_sharp),
            title: Text(
              "Topics",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text(
              "Bookmarks",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list_sharp),
            title: Text(
              "List",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text(
              "Twitter Circle",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 20.sp,
            ),
            title: Text(
              "Settings and privacy",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              size: 20.sp,
            ),
            title: Text(
              "Help Center",
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
