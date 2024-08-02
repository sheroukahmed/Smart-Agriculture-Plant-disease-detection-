import 'package:apptrial/Login.dart';
import 'package:apptrial/modules/signup/signup.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';

import '../../shared/Components/Components.dart';

class welcome_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image(image: AssetImage('images/logo.jpeg')),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipPath(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen.shade800,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: CustomMaterialButton(
                          text: 'login',
                          color: Colors.lightGreen.shade800,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipPath(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen.shade800,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: CustomMaterialButton(
                          text: 'signup',
                          color: Colors.lightGreen.shade800,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
