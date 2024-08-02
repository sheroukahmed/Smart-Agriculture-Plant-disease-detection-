import 'package:flutter/material.dart';
import 'package:apptrial/modules/profile/ProfileSections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:apptrial/shared/Components/Components.dart';

import 'profile.dart';

class mange_profile extends StatefulWidget {
  @override
  State<mange_profile> createState() => _mange_profileState();
}

class _mange_profileState extends State<mange_profile> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final  TextEditingController emailcontroller_up=TextEditingController();
  // final TextEditingController passwordcontroller_up=TextEditingController();
  final TextEditingController username=TextEditingController();
  final TextEditingController Addresscont=TextEditingController();
  final TextEditingController gender=TextEditingController();
  final TextEditingController phone_nocont=TextEditingController();
  final TextEditingController age_cont=TextEditingController();

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
          content: Text('Error Getting User  ${e}!'),
        ),
      );
    }
  }
  Future updateUserData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(instance.currentUser!.uid)
          .get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(instance.currentUser!.uid)
            .set({
          "User name":username.text,
          "Email": emailcontroller_up.text,
          "phone number":phone_no,
          "address":Addresscont.text,
          "age":agecont,
          "gender":gender.text
        });
        getUserData();
        setState(() {});
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating User Data due to ${e}!'),
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
        title: Text('Mange Account'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon:Icon(
            Icons.done,
            size: 30.0,
          ), onPressed: () {
                Navigator.pop(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
          },)
        ],
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
            const SizedBox(height: 15.00,),
            Expanded(
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ProfileSections(
                              title: "Name", details:username.text , icon: Icons.perm_contact_calendar_rounded,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.edit), onPressed: (
                                ){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Update User name"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            labelText: 'New User name',
                                            controller:username ,
                                          )
                                        ],
                                      ),
                                    ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                String enteredname = username.text;
                                                print(enteredname);
                                                updateUserData();
                                              },
                                              child: Text('Done'))
                                        ],
                                      );
                                    },
                                  );
                                }),
                          ),

                          ProfileSections(
                              title: "Address", details: Addresscont.text, icon: Icons.location_on,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.edit), onPressed: (
                                ){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Update Address"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            labelText: 'New Address',
                                            controller:Addresscont ,
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            String enteredAddress = Addresscont.text;
                                            print(enteredAddress);
                                            updateUserData();
                                          },
                                          child: Text('Done'))
                                    ],
                                  );
                                },
                              );
                            }),
                          ),

                          ProfileSections(
                              title: "Mobile Number", details: phone_no.toString(), icon: Icons.phone_android,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.edit), onPressed: (
                                ){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Update Mobile Number"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            labelText: 'New Mobile Number',
                                            controller: phone_nocont,
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            phone_no =int.parse(phone_nocont.text);
                                            print(phone_no);
                                            updateUserData();
                                          },
                                          child: Text('Done'))
                                    ],
                                  );
                                },
                              );
                            }),
                          ),

                          ProfileSections(
                              title: "Email", details:emailcontroller_up.text , icon: Icons.mail,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.edit), onPressed: (
                                ){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Update Email"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            labelText: 'New Email',
                                            controller:username ,
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            String enteredEmail = emailcontroller_up.text;
                                            print(enteredEmail);
                                            updateUserData();
                                          },
                                          child: Text('Done'))
                                    ],
                                  );
                                },
                              );
                            }),
                          ),

                          ProfileSections(
                              title: "Age", details: agecont.toString(), icon: Icons.calendar_month,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.edit), onPressed: (
                                ){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Update Age"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            labelText: 'New Age',
                                            controller:age_cont ,
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            agecont = int.parse(age_cont.text);
                                            print(agecont);
                                            updateUserData();
                                          },
                                          child: Text('Done'))
                                    ],
                                  );
                                },
                              );
                            }),
                          ),

                          ProfileSections(
                              title: "Gender", details: gender.text, icon: Icons.male_outlined,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: IconButton(icon: Icon(Icons.edit), onPressed: (
                                ){
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("Update Gender"),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomTextFormField(
                                            labelText: 'New Gender',
                                            controller:gender ,
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            String enteredGender = gender.text;
                                            print(enteredGender);
                                            updateUserData();
                                          },
                                          child: Text('Done'))
                                    ],
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
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





