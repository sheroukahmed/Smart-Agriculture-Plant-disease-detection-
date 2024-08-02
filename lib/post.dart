import 'dart:convert';
import 'dart:io';
import 'package:apptrial/shared/Components/Components.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'shared/Components/String_manger.dart';

class posting extends StatefulWidget {
  final Uri urlmodel;

  posting({required this.urlmodel});

  @override
  _postingState createState() => _postingState();
}

class _postingState extends State<posting> {
  FirebaseAuth instance = FirebaseAuth.instance;
  late File _image = File('');
  late String _response = '';

  final Imageurl_cont = TextEditingController();
  final response_cont = TextEditingController();

  Future savehistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      StringManager.uId = user.uid;
      await adduserhistory(
        Imageurl_cont.text.trim(),
        response_cont.text.trim(),
      );
    }
  }

  Future adduserhistory(String response, String imageurl) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("Plants").doc().set({
      'image_link': imageurl,
      'label': response,
      'uid': user!.uid,
    });
  }

  final picker = ImagePicker();

  Future getImage_gallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // setState(() {
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future getImage_camera() async {
    final image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
  }

  Future sendImage(Uri link) async {
    final url_diseasetype =
        Uri.parse('https://92c9-102-43-3-52.ngrok-free.app/disease');
    if (_image == null) {
      // Add null check here
      print('No image selected.');
      return;
    }
    final url = widget.urlmodel;
    try {
      final request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData =
            await response.stream.transform(utf8.decoder).join();
        String imageurl = await uploadImage(_image);
        setState(() {
          _response = responseData;
          print(imageurl);
        });
        await adduserhistory(_response, imageurl);
      } else {
        print('Error!!: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> uploadImage(File image) async {
    String? imageurl;
    await FirebaseStorage.instance
        .ref()
        .child('Images/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) async {
      imageurl = await value.ref.getDownloadURL();
    });
    return imageurl!;
  }


  void initState() {
    super.initState();
  }

  _centerWidget() {
    if (_image != null && _image.path.isNotEmpty) {
      return Image.file(
        _image!,
        height: 300,
      );
    } else {
      return Image.asset(
        'images/Leaf-placeholder.png',
        height: 300,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Insert Image"),
          centerTitle: true,
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _centerWidget(),
              SizedBox(height: 20),
              if (_response != null) SizedBox(height: 20),
              Text(
                _response!,
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,),
              CustomMaterialButton(
                onPressed: () {
                  sendImage(widget.urlmodel);
                },
                text: 'Send Image',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Colors.green.shade800,
        children: [
          SpeedDialChild(
              child: Icon(Icons.camera),
              label: 'camera',
              onTap: () {
                getImage_camera();
              }),
          SpeedDialChild(
              child: Icon(Icons.image),
              label: 'Gallery',
              onTap: () {
                getImage_gallery();
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
