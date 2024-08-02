import 'package:apptrial/modules/profile/mange_account.dart';
import 'package:flutter/material.dart';
import 'package:apptrial/modules/profile/ProfileSections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final emailcontroller_up=TextEditingController();
  final passwordcontroller_up=TextEditingController();
  final username=TextEditingController();
  final Addresscont=TextEditingController();
  final gender=TextEditingController();
  late int phone_no=0;
  late int agecont=0;


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
          emailcontroller_up.text = userData['Email'];
          try {
            phone_no = userData['phone number'];
            print(userData['phone number']);
          } catch (e) {
            phone_no = 1;
          }
          username.text = userData['User name'];
          agecont=userData['age'];
          Addresscont.text=userData['address'];
          gender.text=userData['gender'];
        });
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error Getting User Data due to ${e}!'),
        ),
      );
    }
  }
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  // Future<void> printUserProfile() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.green.shade800,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column (
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                      backgroundColor: Color(0xffB3B5B0),
                      radius: 30,
                      child: Icon(Icons.person, color: Colors.black, size: 40)
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 20.0 ,
                        ),
                        Text("My Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28)),
                      ],
                    ),
                  )
                ],
              ),
            ),

            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> mange_profile()));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: Colors.lightGreen.shade800),
                      borderRadius: BorderRadius.circular(15)
                  ), backgroundColor: Colors.lightGreen.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
              child: const Text("Manage your account", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 15.00,),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.shade50,
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(
                          color: Colors.white
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ProfileSections(
                          title: "Name", details:username.text , icon: Icons.perm_contact_calendar_rounded),
                      ProfileSections(
                          title: "Address", details: Addresscont.text, icon: Icons.location_on),
                      ProfileSections(
                          title: "Mobile Number", details: phone_no.toString(), icon: Icons.phone_android),
                      ProfileSections(
                          title: "Email", details:emailcontroller_up.text , icon: Icons.mail),
                      ProfileSections(
                          title: "Age", details: agecont.toString(), icon: Icons.calendar_month),
                      ProfileSections(
                          title: "Gender", details: gender.text, icon: Icons.male_outlined),
                    ],
                  ),

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}