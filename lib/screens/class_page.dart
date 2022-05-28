// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:face_attendence/models/student.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/classes.dart';

class ClassPage extends StatefulWidget {
  ClassPage({Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    Classes? doc = ModalRoute.of(context)!.settings.arguments as Classes?;
    List<List<dynamic>> rows = [
      ["Registation No.", "Name", "Attendance"]
    ];
    Future exportCSV() async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      var snapshot = await FirebaseFirestore.instance
          .collection('Courses')
          .doc(doc!.id)
          .collection('students')
          .get()
          .then(
        (value) {
          value.docs.forEach((element) {
            final data = element.data() as Map<String, dynamic>;
            List<dynamic> student = [
              data['id'],
              data['name'],
              data['attendance'],
            ];
            rows.add(student);
            print(data);
          });
        },
      );

      print(rows);
      String csv = const ListToCsvConverter().convert(rows);
      String? dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      print("dir $dir");
      String file = "$dir";

      File f = File(file + "/${doc.name}.csv");

      f.writeAsString(csv);
      final snackBar = SnackBar(
        content: const Text('Export Completed'),
        backgroundColor: (Colors.black),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () {
            OpenFile.open(f.path);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      rows = [
        ["Registation No.", "Name", "Attendance"]
      ];

      print('Export Completed');
    }

    var studentStream = FirebaseFirestore.instance
        .collection('Courses')
        .doc(doc!.id)
        .collection('students')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Course - ${doc.name.toUpperCase()}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                  onPressed: () {
                    print(doc.name + doc.pid);
                    Navigator.pushNamed(
                      context,
                      '/attend',
                      arguments: doc,
                    );
                  },
                  child: const Text('Take Attendance'),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/student',
                      arguments: doc,
                    );
                  },
                  child: const Text('Add Student'),
                ),
                const Spacer(),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: StreamBuilder(
                stream: studentStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.docs.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/editStud',
                              arguments: Student(
                                name: e['name'],
                                id: e['id'],
                                image: e['image'],
                                attend: e['attendance'],
                                parentId: doc.id,
                                pId: e.id,
                                cName: doc.name,
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width * 0.96,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(1, 2)),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.transparent,
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white24,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.all(8),
                                      // child: e['image'] == 'null'
                                      //     ? Image(
                                      //         image:
                                      //             AssetImage('assets/dummy.jpg'),
                                      //         fit: BoxFit.contain,
                                      //       )
                                      //     :
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            e['image'] as String,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e['name'].toString().trim(),
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          e['id'].toString().trim(),
                                          style: TextStyle(
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Text(e['attendance']),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Click \'Add Student\' to add a Student to database.',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          exportCSV();
        },
        label: Text('Export'),
        icon: Icon(Icons.import_export_outlined),
      ),
    );
  }
}
