import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:twitter_clone/Global/global.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/messages.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/notification.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/search.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/speaker.dart';
import 'package:twitter_clone/Screens/Home/HomeScreens/timeline.dart';
import 'package:twitter_clone/Widget/MyAppbar.dart';
import 'package:twitter_clone/Widget/MyDrawer.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    
    TimeLineScreen(),
    SearchScreen() ,
    SpeakerScreen(),
    NotificationScreen(),
    MessagesScreen()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppbar(),
      drawer: MyDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Color.fromARGB(255, 226, 222, 222),
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                 
                ),
                GButton(
                  icon: LineIcons.search,
                
                ),
                GButton(
                  icon: LineIcons.microphone,
                  
                ),
               
                GButton(
                  icon: LineIcons.bell,
                 
                ),
                GButton(
                  icon: Icons.mail_outlined,
                 
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}