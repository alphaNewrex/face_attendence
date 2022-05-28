import 'package:face_attendence/screens/add_class.dart';
import 'package:face_attendence/screens/add_student.dart';
import 'package:face_attendence/screens/class_page.dart';
import 'package:face_attendence/screens/home_page.dart';
import 'package:face_attendence/screens/login_page.dart';
import 'package:face_attendence/screens/take_attendance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_gate.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/class': (context) => ClassPage(),
        '/student': (context) => AddStudentPage(),
        '/attend': (context) => AttendancePage(),
        '/addClass': (context) => AddClassPage(),
      },
    );
  }
}
