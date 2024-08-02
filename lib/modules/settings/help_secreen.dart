
import 'package:flutter/material.dart';

import '../../privacy_policy.dart';
import '../../terms.dart';



class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Help Center'),
        centerTitle: true,
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
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.mail),
                title: Text('Contact Support'),
                onTap: ()  {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Policy'),
                onTap: ()  {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  privacy()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.description),
                title: Text('Terms of Service'),
                onTap: ()  {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  terms()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}