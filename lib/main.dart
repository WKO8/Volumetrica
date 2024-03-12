// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:volumetrica/pages/home.dart';
import 'package:volumetrica/pages/settings.dart';

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
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
