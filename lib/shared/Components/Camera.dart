import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => Camerastate();

}

class Camerastate extends State<Camera> {
  File? imageFile;
  void getfromcamera () async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
    maxHeight: 1080,
    maxWidth: 1080,
    );
    setState(() {
      imageFile=File(pickedFile!.path);
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold (
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
           SizedBox(height: 50,),
           imageFile != null ?
           Container(
               child: Image.file(imageFile!),
               ):
           Container(
             child: Icon(
               Icons.camera_enhance_rounded,
               color: Colors.green.shade800,
               size: MediaQuery.of(context).size.width*.6,

           ),
           ),
           Padding(
               padding: const EdgeInsets.all(30.0),
             child: ElevatedButton(
               child: Text('capture'),
               onPressed: (){
                 getfromcamera();
               },
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all((Colors.green.shade800)),
                 padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                 textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16))

               ),
             ) ,
           )
         ],

       ),
     ) ,
   );
  }

}

