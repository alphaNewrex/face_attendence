import 'dart:convert';

import 'package:face_attendence/models/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'add_class.dart';

class EditStudent extends StatefulWidget {
  EditStudent({Key? key}) : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  @override
  Widget build(BuildContext context) {
    Student student = ModalRoute.of(context)!.settings.arguments as Student;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
        actions: [
          GestureDetector(
            onTap: () => deleteStudent(student),
            child: Container(
              margin: EdgeInsets.only(right: 25),
              child: Center(
                child: Text(
                  'DELETE',
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(student.image),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: student.name,
                onChanged: (value) {
                  student.name = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Name'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: student.id,
                onChanged: (value) {
                  student.id = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Registration No.'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: student.attend,
                onChanged: (value) {
                  student.attend = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Attendance'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: () async {
                  Map<String, dynamic> data = {
                    "name": student.name,
                    "attendance": student.attend,
                    "id": student.id,
                    "image": student.image,
                    "parentId": student.parentId,
                    "pId": student.pId,
                  };
                  print(data);
                  await FirebaseFirestore.instance
                      .collection('Courses')
                      .doc(student.parentId)
                      .collection('students')
                      .doc(student.pId)
                      .update(data);
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future deleteStudent(Student student) async {
    var endpoint = Uri.parse(
        "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/largepersongroups/${student.cName.toLowerCase()}/persons/${student.pId}");
    var response = await http.delete(
      endpoint,
      headers: {
        "Ocp-Apim-Subscription-Key": key,
      },
    );
    if (response.statusCode == 200) {
      await FirebaseFirestore.instance
          .collection('Courses')
          .doc(student.parentId)
          .collection('students')
          .doc(student.pId)
          .delete();
      Fluttertoast.showToast(
          msg: 'Deleted',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
      Navigator.pop(context);
    } else {
      var res = jsonDecode(response.body);
      Fluttertoast.showToast(
          msg: res['error']['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
    }
  }
}
