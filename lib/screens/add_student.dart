// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/classes.dart';
import 'add_class.dart';

class AddStudentPage extends StatefulWidget {
  AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

var personID;
bool _isloading = false;
Future addStudent(Classes? doc, BuildContext context) async {
  _isloading = true;
  var endpoint = Uri.parse(
      "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/largepersongroups/${doc!.name.toLowerCase()}/persons");
  Map data = {
    "name": sName,
  };
  var body = jsonEncode(data);

  var response = await http.post(endpoint,
      headers: {
        "Content-Type": "application/json",
        "Ocp-Apim-Subscription-Key": key,
      },
      body: body);

  if (response.statusCode == 200) {
    var res = jsonDecode(response.body);
    personID = res['personId'];
    print(personID);

    Map<String, dynamic> student = {
      "name": sName,
      "attendance": sAttend,
    };

    var uri = Uri.parse(
        "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/largepersongroups/${doc.name}/persons/${personID}/persistedFaces?detectionModel=detection_03");

    File file = File(singleRegisterImage!.path);
    final bytes = file.readAsBytesSync();
    print(bytes);

    var response2 = await http.post(uri,
        headers: {
          "Content-Type": "application/octet-stream",
          "Ocp-Apim-Subscription-Key": key,
        },
        body: bytes);

    if (response2.statusCode == 200) {
      print('Check');
      var da = jsonDecode(response2.body);
      print(da['persistedFaceId']);

      var uri2 = Uri.parse(
          "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/largepersongroups/${doc.name}/train");

      var responseTrain = await http.post(uri2, headers: {
        "Ocp-Apim-Subscription-Key": key,
      });

      if (responseTrain.statusCode == 202) {
        await FirebaseFirestore.instance
            .collection('Courses')
            .doc(doc.id)
            .collection('students')
            .doc(personID)
            .set(student);
        print('added databse');
        print("Train Successful");
        singleRegisterImage = null;
      } else {
        print(responseTrain.statusCode);
        var res = jsonDecode(responseTrain.body);
        print(res);
        Fluttertoast.showToast(
            msg: res['error']['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0);
      }
    } else {
      print(response2.statusCode);
      var res = jsonDecode(response2.body);
      Fluttertoast.showToast(
          msg: res['error']['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
      print(res);
    }
  } else {
    print('error 2');
    var res = jsonDecode(response.body);
    print(res);
  }
}

XFile? singleRegisterImage;

class _AddStudentPageState extends State<AddStudentPage> {
  @override
  Widget build(BuildContext context) {
    
    Classes? doc = ModalRoute.of(context)!.settings.arguments as Classes?;
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    singleRegisterImage != null &&
                            singleRegisterImage!.path.isNotEmpty
                        ? Image.file(
                            File(singleRegisterImage!.path),
                            height: 100,
                          )
                        : Image.asset(
                            'assets/user.jpg',
                            height: 100,
                          ),
                    Spacer(),
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            singleRegisterImage = await imageGallery();
                            if (singleRegisterImage != null &&
                                singleRegisterImage!.path.isNotEmpty) {
                              setState(() {});
                            }
                          },
                          icon: const Icon(
                            Icons.image_outlined,
                          ),
                          label: const Text('Pick Gallery'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            singleRegisterImage = await imageCamera();
                            if (singleRegisterImage != null &&
                                singleRegisterImage!.path.isNotEmpty) {
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: const Text('Pick Camera'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                singleRegisterImage != null &&
                        singleRegisterImage!.path.isNotEmpty
                    ? DetailsWidget(
                        doc: doc,
                      )
                    : const SizedBox.shrink()
              ],
            ),
            _isloading
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

Future<XFile?> imageGallery() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}

Future<XFile?> imageCamera() async {
  return await ImagePicker().pickImage(source: ImageSource.camera);
}

late String sName, sAttend;

class DetailsWidget extends StatefulWidget {
  final Classes? doc;
  const DetailsWidget({Key? key, required this.doc}) : super(key: key);

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => sName = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter full name',
            ),
          ),
          SizedBox(height: 10),
          TextField(
            onChanged: (value) => sAttend = value,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Days already attended',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              setState(() {
                _isloading = true;
                print(_isloading);
              });
              await addStudent(widget.doc, context);
              setState(() {
                _isloading = false;
                print(_isloading);
              });
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text('Add Student'),
          )
        ],
      ),
    );
  }
}
