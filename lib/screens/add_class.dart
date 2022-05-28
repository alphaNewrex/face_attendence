// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class AddClassPage extends StatefulWidget {
  AddClassPage({Key? key}) : super(key: key);

  @override
  State<AddClassPage> createState() => _AddClassPageState();
}

var key = "51fdfbeac0b84c0fb37feb43378d0c0e";

class _AddClassPageState extends State<AddClassPage> {
  bool _isLoading = false;
  late String semester, cName, taughtBy, pid;

  Future addClass() async {
    setState(() {
      _isLoading = true;
    });

    var endpoint = Uri.parse(
        "https://faceattendance69.cognitiveservices.azure.com/face/v1.0/largepersongroups/${cName}");
    var uuid = await FirebaseAuth.instance.currentUser!.uid;
    // ignore: unnecessary_cast
    Map<String, dynamic> data = {
      "name": cName,
      "pid": 'pid',
      "sem": semester,
      "t_by": taughtBy,
      "uuid": uuid,
    };
    Map data_json = {
      "name": cName,
      "recognitionModel": 'recognition_04',
    } as Map;
    var body = jsonEncode(data);

    var response = await http.put(
      endpoint,
      headers: {
        "Content-Type": "application/json",
        "Ocp-Apim-Subscription-Key": key,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      await FirebaseFirestore.instance.collection('Courses').add(data);
      setState(() {
        _isLoading = false;
      });
      Navigator.pop(context);
    } else {
      print(response.body);
      var err = jsonDecode(response.body);

      Fluttertoast.showToast(
          msg: err['error']['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Class'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Enter Class Details',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) => cName = value,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Class Name/Code'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) => taughtBy = value,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Taught by'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onChanged: (value) => semester = value,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Semester'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      showDialog(
                          context: context,
                          builder: (BuildContext contextD) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                title: Text('Add Class'),
                                content: Text(
                                    'Are you sure you want to add this class?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'No'),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pop(contextD);

                                      addClass();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.add_circle_outline),
                    label: Text('Submit'),
                  ),
                ],
              ),
              _isLoading == true
                  ? Center(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 160, 0, 0),
                              child: CircularProgressIndicator()),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
