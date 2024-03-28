// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:volumetrica/pages/home.dart';
import 'package:volumetrica/pages/about.dart';
import 'package:volumetrica/pages/signin.dart';
import 'package:volumetrica/pages/signup.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // functions & methods
  void userTapped() {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/about': (context) => AboutPage(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
      },
    );
  }
}
