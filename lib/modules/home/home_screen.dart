import 'package:apptrial/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptrial/shared/Components/models.dart';
import '../history/history.dart';
import '../profile/profile.dart';
import '../settings/settings.dart';

class homeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => homeScreenstate();
}

class homeScreenstate extends State<homeScreen> {
  FirebaseAuth instance = FirebaseAuth.instance;

  int bottom_navigate = 0;

  final List<IconData> iconList = [
    Icons.home,
    Icons.energy_savings_leaf,
    Icons.person,
    Icons.settings
  ];

  final List<String> titleList = ['Home', 'History', 'Profile', 'Settings'];

  void onTabTapped(int index) {
    setState(() {
      bottom_navigate = index;
    });
  }

  Widget getScreen() {
    switch (bottom_navigate) {
      case 0:
        return homeScreen();
      case 1:
        return ExampleParallax();
      case 2:
        return ProfileScreen();
      case 3:
        return SettingScreen();
      default:
        return homeScreen();
    }
  }

  final username = TextEditingController();

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<dynamic> getUserProfileField(String fieldName) async {
    final DocumentSnapshot<Object?> snapshot =
        await usersCollection.doc(uid).get();
    return snapshot.get(fieldName);
  }

  Future getUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(instance.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          username.text = userData['User name'];
        });
        print(username.text);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Getting User Data ${e}!'),
        ),
      );
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 120.0,
          backgroundColor: Colors.green.shade800,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.0,
              ),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35.0,
                  child: Icon(Icons.person, color: Colors.black, size: 50)
              ),
              SizedBox(
                width: 50.0,
              ),
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          elevation: 0.0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    Text(
                      '  Welcome , ${username.text} ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade50,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: IndexedStack(
                  index: bottom_navigate,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => posting(urlmodel:url_genus)
                                ),
                            );
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('images/genus_ c.jpeg'),
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Species',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 8)
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => posting(urlmodel:url_attacks)
                              ),
                            );
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('images/attack_ c.jpeg'),
                                  height: 95.0,
                                  width: 95.0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Attacks',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 8)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => posting(urlmodel:url_disornot)
                              ),
                            );
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('images/disease_c 2.jpeg'),
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Diseases',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 8)
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => posting(urlmodel:url_struct)
                              ),
                            );
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('images/352131.jpg'),
                                  height: 100.0,
                                  width: 100.0,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  'Structure',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 2,
                                      blurRadius: 8)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}