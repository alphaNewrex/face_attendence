// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder(
                stream: studentStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.docs.map((e) {
                        return Container(
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
                                margin: const EdgeInsets.symmetric(vertical: 8),
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
                                    
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
