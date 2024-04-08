// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:volumetrica/pages/home.dart';
import 'package:volumetrica/pages/about.dart';
import 'package:volumetrica/pages/recovery.dart';
import 'package:volumetrica/pages/signin.dart';
import 'package:volumetrica/pages/signup.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 final cameras = await availableCameras();
 runApp(MyApp(cameras: cameras));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({super.key, required this.cameras});

  // functions & methods
  void userTapped() {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(cameras: cameras),
      routes: {
        '/home': (context) => HomePage(cameras: cameras),
        '/about': (context) => AboutPage(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/recovery': (context) => Recovery(),
      },
    );
  }
}
