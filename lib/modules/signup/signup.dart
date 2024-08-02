import 'package:apptrial/shared/Components/Components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apptrial/Login.dart';
import '../../shared/Components/String_manger.dart';


class signup extends StatefulWidget
{
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var formkey1 = GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  late String id;

  final emailcontroller_up=TextEditingController();
  final passwordcontroller_up=TextEditingController();
  final confpasswordcontroller_up=TextEditingController();
  final username=TextEditingController();
  final phone_no=TextEditingController();
  final Addresscont=TextEditingController();
  final agecont=TextEditingController();
  final gender=TextEditingController();
  String _gender="Female"  ;
  late String _selectedgender ;

  @override
  void dispose(){
    emailcontroller_up.dispose();
    passwordcontroller_up.dispose();
    username.dispose();
    phone_no.dispose();
    Addresscont.dispose();
    agecont.dispose();
    gender.dispose();
    super.dispose();
  }

  Future signup() async{
    if (passwordConfirmed()){
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailcontroller_up.text,
        password: passwordcontroller_up.text,
      ).then((value) async {
        StringManager.uId = value.user!.uid;
        await
        adduserinfo(
          emailcontroller_up.text.trim(),
          username.text.trim(),
          int.parse(phone_no.text.trim()),
          Addresscont.text.trim(),
          int.parse(agecont.text.trim()),
          gender.text.trim(),

        );
      });
    }
  }
  
  Future adduserinfo(String email,String name , int phoneno , String address , int age, String gender) async{
    FirebaseFirestore.instance
        .collection("users")
        .doc(StringManager.uId)
        .set({
    'Email':email,
    'User name':name,
    'phone number':phoneno,
    'address':address,
    'age':age,
    'uid':StringManager.uId,
    'gender':_gender,

    });
  }
  bool passwordConfirmed(){
    if (passwordcontroller_up.text.trim() == confpasswordcontroller_up.text.trim() ){
      return true;
    }else{
      return false;
    }
  }

  bool _acceptedTermsAndConditions = false;
  void _onTermsAndConditionsChanged(bool value) {
    setState(() {
      _acceptedTermsAndConditions = value;
    });
  }

  int? _selectedValue;
  void _onRadioValueChanged(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }
  void _onSubmit() {
    if (_selectedValue == null) {
      // No radio button has been selected, show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please select an option.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
          automaticallyImplyLeading: false,
        leading: const BackButton(
        color: Colors.black,
        )
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
              child: Form(
                key:formkey1 ,
                child: Column(
                  children:
                  [
                    Text(
                      'SignUp',
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
                      controller: emailcontroller_up,
                      keyboardType: TextInputType.emailAddress,
                      validator:(value)
                        {
                          if (value == null || value.isEmpty)
                          {
                            return 'EMAIL MUST NOT BE EMPTY';
                          }else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        } ,
                      labelText: 'Email Address',
                      focusColor :Colors.lightGreen ,
                      prefixIcon: Icon(
                            Icons.email,
                            color: Colors.green.shade800,
                          ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomTextFormField(
                      controller: username,
                      validator:(value)
                      {
                         if (value == null || value.isEmpty)
                        {
                        return 'USERNAME MUST NOT BE EMPTY';
                        }else if(!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                           return 'Username can only contain letters, numbers, and underscores';
                         }
                         return null;
                      } ,
                      labelText: 'User Name',
                      prefixIcon: Icon(
                            Icons.person,
                            color: Colors.green.shade800,
                          ),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller: phone_no,
                      keyboardType: TextInputType.number,
                      validator:(value)
                      {
                        if (value == null || value.isEmpty)
                        {
                          return 'MOBILE NUMBER MUST NOT BE EMPTY';
                        }else if (!RegExp(r'^\+?\d{10,12}$').hasMatch(value)) {
                        return 'Please enter a valid phone number';
                        }
                        return null;
                      } ,
                      labelText: 'Mobile Number',
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller: Addresscont,
                      validator:(value)
                      {
                        if (value == null || value.isEmpty)
                        {
                          return 'Address MUST NOT BE EMPTY';
                        } else if (!RegExp(r'^[a-zA-Z0-9\s\-\,\#\.]').hasMatch(value)){
                          return 'Please enter a valid address';
                        }
                        return null;
                      } ,
                      labelText: 'Address',
                      prefixIcon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.green.shade800,
                      ),

                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller:agecont ,
                      keyboardType: TextInputType.number,
                      validator:(value)
                      {
                        if (value == null || value.isEmpty)
                        {
                          return 'Age MUST NOT BE EMPTY';
                        }else {
                          final age = int.tryParse(value);
                          if (age == null || age < 15 || age > 100) {
                            return 'Please enter a valid age between 18 and 100';
                          }
                        }
                        return null;
                      } ,
                      labelText: 'Age',
                      prefixIcon: Icon(
                        Icons.date_range_outlined,
                        color: Colors.green.shade800,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.black,
                        radioTheme: RadioThemeData(
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.green.shade800),
                        ),
                      ),
                      child: RadioListTile(
                        title: Text("Female"),
                          value: "Female",
                          groupValue: _gender,
                          onChanged: (value){
                          setState(() {
                            _gender= value.toString();
                          });
                          },
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.black,
                        radioTheme: RadioThemeData(
                          fillColor: MaterialStateColor.resolveWith((states) => Colors.green.shade800),
                        ),
                      ),
                      child: RadioListTile(
                        title: Text("Male"),
                        value: "Male",
                        groupValue: _gender,
                        onChanged: (value){
                          setState(() {
                            _gender= value.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFormField(
                      controller:passwordcontroller_up ,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator:(value)
                        {
                          if (value == null || value.isEmpty)
                          {
                            return 'PASSWORD MUST NOT BE EMPTY';
                          }else if (value.length < 6) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        } ,
                      labelText: 'Password',
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
                    CustomTextFormField(
                      controller: confpasswordcontroller_up,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator:(value)
                        {
                          if (value == null || value.isEmpty)
                          {
                            return 'PLEASE CONFIRM YOUR PASSWORD';
                          }else if (passwordConfirmed() == false) {
                            return 'Passwords do not match';
                          }
                          return null;
                        } ,
                          labelText: 'Confirm Password',
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
                    Checkbox(
                      value: _acceptedTermsAndConditions,
                      onChanged: (bool? value)=>_onTermsAndConditionsChanged(value?? false),
                    ),
                    Text('I have read and accept the terms and conditions'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipPath(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.lightGreen.shade800,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ) ,
                          child:
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Login()));
                            } ,
                            child: CustomMaterialButton(
                              text: 'signup',
                              color: Colors.lightGreen.shade800,
                              onPressed: (){
                                if(formkey1.currentState!.validate()){
                                  print(username.text);
                                  print(emailcontroller_up.text);
                                  print(passwordcontroller_up.text);
                                  signup();
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Login()));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Already have an account ?'
                        ),
                        CustomTextButton(
                            text: 'login',
                            color: Colors.green.shade800,
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                               builder: (context) => Login()));
                            }
                        )
                      ],
                    ),
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