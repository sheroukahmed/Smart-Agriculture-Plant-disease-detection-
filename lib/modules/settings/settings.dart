import 'package:flutter/material.dart';
import 'package:apptrial/modules/profile/profile.dart';
import 'package:apptrial/modules/settings/notifications_screen.dart';
import 'package:apptrial/modules/settings/help_secreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apptrial/Login.dart';


class SettingScreen extends StatelessWidget{
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> clearHistory() async {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Plants')
          .where("uid", isEqualTo: uid)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;
      for (var doc in documents) {
        await doc.reference.delete();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Settings", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32)),
              ],
            ),
              SizedBox(
                height: 50.00,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.lightGreen.shade800,),
                          borderRadius: BorderRadius.circular(50)
                      ), backgroundColor: Colors.lightGreen.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
                  child: const Text("View Profile", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    clearHistory();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.lightGreen.shade800),
                          borderRadius: BorderRadius.circular(50)
                      ), backgroundColor: Colors.lightGreen.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
                  child: const Text("Clear history", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.lightGreen.shade800),
                          borderRadius: BorderRadius.circular(50)
                      ), backgroundColor: Colors.lightGreen.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
                  child: const Text("Notification", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.lightGreen.shade800),
                          borderRadius: BorderRadius.circular(50)
                      ), backgroundColor: Colors.lightGreen.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
                  child: const Text("Help", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Login()));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 3, color: Colors.lightGreen.shade800),
                          borderRadius: BorderRadius.circular(50)
                      ), backgroundColor: Colors.lightGreen.shade800,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80)),
                  child: const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}