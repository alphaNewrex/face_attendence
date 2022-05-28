// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:face_attendence/models/classes.dart';
import 'package:face_attendence/widgets/app_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List imageList = [
  AssetImage("assets/banner1.jpg"),
  AssetImage("assets/banner2.jpg"),
  AssetImage("assets/banner3.jpg"),
  AssetImage("assets/banner4.jpg"),
  AssetImage("assets/banner5.jpg"),
  AssetImage("assets/banner6.jpg"),
  AssetImage("assets/banner7.jpg"),
  AssetImage("assets/banner8.jpg"),
  AssetImage("assets/banner9.jpg"),
  AssetImage("assets/banner10.jpg"),
  AssetImage("assets/banner11.jpg"),
  AssetImage("assets/banner12.jpg"),
];
var uuid = FirebaseAuth.instance.currentUser!.uid;

class _HomePageState extends State<HomePage> {
  var _isLoading = false;
  late Stream<QuerySnapshot> _courseStream;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    _courseStream = FirebaseFirestore.instance
        .collection('Courses')
        .where("uuid", isEqualTo: uuid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
          title: Text('Classrooms'),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            },
          ),
          automaticallyImplyLeading: false),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: StreamBuilder(
                    stream: _courseStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          children: snapshot.data!.docs.map((document) {
                            return Stack(
                              children: [
                                Container(
                                  height: 160,
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageList[Random().nextInt(11)],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/class',
                                                arguments: Classes(
                                                  name: document['name'],
                                                  pid: document['pid'],
                                                  id: document.id,
                                                  t_by: document['t_by'],
                                                  sem: document['sem'],
                                                ));
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 25, left: 15),
                                  width: 220,
                                  child: Text(
                                    document['name'].toString().toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 55, left: 15),
                                  child: Text(
                                    document['t_by'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 130, left: 15),
                                  child: Text(
                                    document['sem'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white70,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            'Add a class by clicking the button below.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addClass');
        },
        icon: Icon(Icons.add),
        label: Text('Add Class'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
