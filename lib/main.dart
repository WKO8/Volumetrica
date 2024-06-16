// ignore_for_file: prefer_const_constructors
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volumetrica/others/database_manager.dart';
import 'package:volumetrica/pages/home.dart';
import 'package:volumetrica/pages/about.dart';
import 'package:volumetrica/pages/management.dart';
import 'package:volumetrica/pages/profile.dart';
import 'package:volumetrica/pages/recovery.dart';
import 'package:volumetrica/pages/signin.dart';
import 'package:volumetrica/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); // Garanta que as câmeras estejam disponíveis
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DatabaseManager()),
    ],
    child: MyApp()
  ));
}


// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { // Chamando initialize
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(cameras: cameras),
      routes: {
        '/home': (context) => HomePage(cameras: cameras),
        '/about': (context) => AboutPage(),
        '/profile': (context) => ProfilePage(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/recovery': (context) => Recovery(),
        '/management': (context) => UsersManagementPage(),
      },
    );
  }
}