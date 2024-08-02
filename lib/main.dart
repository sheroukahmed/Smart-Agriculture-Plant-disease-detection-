
import 'package:apptrial/modules/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(myapp());
}


class myapp extends StatelessWidget
{
  const myapp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black54,
        ),
        home :welcome_screen(),
      debugShowMaterialGrid: false,

    );
  }
}



