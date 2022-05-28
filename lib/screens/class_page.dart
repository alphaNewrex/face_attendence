// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
                        return Stack(
                          children: [
                            Container(
                              height: 40,
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
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: AssetImage('assets/user.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(e['name']),
                                Spacer(),
                                Text(e['attendance']),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            )
                          ],
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
