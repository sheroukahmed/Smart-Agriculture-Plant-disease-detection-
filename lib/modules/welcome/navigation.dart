import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../history/history.dart';
import '../home/home_screen.dart';
import '../profile/profile.dart';
import '../settings/settings.dart';

class navigator extends StatefulWidget {
  @override
  State<navigator> createState() => _navigatorState();
}

class _navigatorState extends State<navigator> {
  int bottom_navigate = 1;

  final List<IconData> iconList = [
    Icons.energy_savings_leaf,
    Icons.home,
    Icons.person,
    Icons.settings
  ];

  final List<String> titleList = [
    'Home',
    'History',
    'Profile',
    'Settings'
  ];

  void onTabTapped(int index) {
    setState(() {
      bottom_navigate = index;
    });
  }

  Widget getScreen() {
    switch (bottom_navigate) {
      case 0:
        return ExampleParallax();
      case 1:
        return homeScreen();
      case 2:
        return ProfileScreen();
      case 3:
        return SettingScreen();
      default:
        return homeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: getScreen()
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.green.shade800,
        items: <Widget>[
          Icon(iconList[0], size: 30),
          Icon(iconList[1], size: 30),
          Icon(iconList[2], size: 30),
          Icon(iconList[3], size: 30),
        ],
        index: bottom_navigate,
        onTap: onTabTapped,
      ),
    );
  }
}
