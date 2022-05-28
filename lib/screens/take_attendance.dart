import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:face_attendence/screens/add_student.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/classes.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_class.dart';

class AttendancePage extends StatefulWidget {
  AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

Future markAttendace(Classes? doc) async {
  var list = [];
  var endpoint = Uri.parse(
      "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/detect");

  File file = File(singleImage!.path);
  final bytes = file.readAsBytesSync();
  print(bytes);
  var response = await http.post(endpoint,
      headers: {
        "Content-Type": "application/octet-stream",
        "Ocp-Apim-Subscription-Key": key,
      },
      body: bytes);

  if (response.statusCode == 200) {
    var dat = jsonDecode(response.body) as List;
    print(dat);
    for (int i = 0; i < dat.length; i++) {
      list.add(dat[i]['faceId'] as String);
    }
    print(list);
    var endpoint2 = Uri.parse(
        "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/identify");

    Map data = {
      "faceIds": list,
      "largePersonGroupId": doc!.name,
      "maxNumOfCandidatesReturned": 1,
      "confidenceThreshold": 0.5,
    };
    var body = jsonEncode(data);

    var response2 = await http.post(
      endpoint2,
      headers: {
        "Content-Type": "application/json",
        "Ocp-Apim-Subscription-Key": key,
      },
      body: body,
    );
    print('check');
    if (response2.statusCode == 200) {
      var resp = jsonDecode(response2.body) as List;
      // print(resp);
      // print(resp[0]);
      for (int i = 0; i < resp.length; i++) {
        var temp = resp[i]['candidates'] as List;
        print(temp);
        if (temp.isEmpty) {
          continue;
        } else {
          var rpersonId = temp[0]['personId'] as String;

          var oldatt = await FirebaseFirestore.instance
              .collection('Courses')
              .doc(doc.id)
              .collection('students')
              .doc(personID)
              .get();

          var oldattN =
              (int.parse(oldatt['attendance'].toString()) + 1).toString();

          await FirebaseFirestore.instance
              .collection('Courses')
              .doc(doc.id)
              .collection('students')
              .doc(rpersonId)
              .update({'attendance': oldattN});
          singleImage = null;
        }
      }
    } else {
      var res = jsonDecode(response2.body);
      print(res);
    }
  } else {
    var res = jsonDecode(response.body);
    print(res);
  }
}

XFile? singleImage;

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    Classes? doc = ModalRoute.of(context)!.settings.arguments as Classes?;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Take Attendance',
          textAlign: TextAlign.center,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            singleImage != null && singleImage!.path.isNotEmpty
                ? Image.file(
                    File(singleImage!.path),
                    height: 200,
                  )
                : Image.asset(
                    'assets/dummy.jpg',
                    height: 200,
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    singleImage = await imageGallery();
                    if (singleImage != null && singleImage!.path.isNotEmpty) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(
                    Icons.image_outlined,
                  ),
                  label: const Text('Pick Gallery'),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    singleImage = await imageCamera();
                    if (singleImage != null && singleImage!.path.isNotEmpty) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Pick Camera'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            singleImage != null && singleImage!.path.isNotEmpty
                ? ElevatedButton(
                    onPressed: () async {
                      await markAttendace(doc);
                      Navigator.pop(context);
                    },
                    child: const Text('Mark Attendance'))
                : const SizedBox.shrink(),
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
