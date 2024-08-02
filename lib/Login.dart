import 'package:apptrial/modules/welcome/navigation.dart';
import 'package:apptrial/shared/Components/Components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apptrial/modules/signup/signup.dart';

class Login extends StatelessWidget {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void SignIn(BuildContext context, String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => navigator(),
        ),
      );
    }).catchError((error) {
      print("hi" + error.toString());
    });
  }

  var formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          automaticallyImplyLeading: false,
          leading: const BackButton(
            color: Colors.black,
          )),
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
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomTextFormField(
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'EMAIL MUST NOT BE EMPTY';
                        }
                        return null;
                      },
                      labelText: 'Email Address',
                      focusColor: Colors.lightGreen,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomTextFormField(
                      controller: passwordcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      onFieldSubmitted: (String value) {
                        print(value);
                      },
                      onChanged: (String value) {
                        print(value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'PASSWORD MUST NOT BE EMPTY';
                        }
                        return null;
                      },
                      labelText: 'Password',
                      focusColor: Colors.lightGreen,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.green.shade800,
                      ),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipPath(
                        child: Container(
                            width: double.infinity,
                            //color: Colors.lightGreen,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen.shade800,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: CustomMaterialButton(
                                text: 'login',
                                color: Colors.lightGreen.shade800,
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    print(emailcontroller.text);
                                    print(passwordcontroller.text);
                                    SignIn(context, emailcontroller.text,
                                        passwordcontroller.text);
                                  }
                                },
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account ?'),
                        CustomTextButton(
                            text: 'signup',
                            color: Colors.green.shade800,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signup()));
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
