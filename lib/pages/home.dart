import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:volumetrica/others/auth_shared_preference.dart';
import 'package:volumetrica/widgets/camera.dart';
import 'package:volumetrica/widgets/camera_provider.dart';
import 'package:volumetrica/widgets/custom_button.dart';
import 'package:volumetrica/widgets/custom_bottom_navigation_bar.dart';
import 'package:volumetrica/widgets/custom_side_menu.dart';
// Importe a página de perfil

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const HomePage({
    super.key, 
    required this.cameras,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CameraDescription> cameras = [];

  XFile? capturedPhoto;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final colorButton = const Color(0xFF448AB5);
  final colorGradient1 = const Color(0xFF448AB5);
  final colorGradient2 = const Color(0xFF1E3C4F);
  final colorButtonSelected = const Color(0xFF20A4F3);
  final colorWhite = const Color(0xFFF8F8FF);
  final colorTransparent = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (context, cameraProvider, child) {
        final controller = cameraProvider.controller;
        return Stack(
          children: [
            if (controller.value.isInitialized)
              CameraApp(cameras: cameras),
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 150,
                backgroundColor: Colors.transparent,
                flexibleSpace: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          scaffoldContext: context,
                          content: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          width: 60,
                          height: 40,
                          color: colorButton,
                          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                        ),
                        CustomButton(
                          scaffoldContext: context,
                          content: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          width: 60,
                          height: 40,
                          color: colorButton,
                          onPressed: () async {
                            final isLoggedIn = await AuthSharedPreferences.loadLoggedInState();
                            if (isLoggedIn) {
                              // Redirecionar para a tela de perfil se o usuário estiver logado
                              Navigator.pushNamed(context, '/profile');
                            } else {
                              Navigator.pushNamed(context, '/signin');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              drawer: const CustomSideMenu(),
              body: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          scaffoldContext: context,
                          content: const Icon(
                            Icons.flip_camera_ios,
                            size: 35,
                            color: Colors.white,
                          ),
                          width: 50,
                          height: 50,
                          color: colorButton,
                          borderRadius: BorderRadius.circular(50),
                          onPressed: () => {},
                        ),
                        CustomButton(
                          scaffoldContext: context,
                          content: const Icon(
                            Icons.flip_camera_ios,
                            size: 35,
                            color: Colors.white,
                          ),
                          width: 50,
                          height: 50,
                          color: colorButton,
                          borderRadius: BorderRadius.circular(50),
                          onPressed: () async {
                            try {
                              final XFile photo = await controller.takePicture();
                              setState(() {
                                capturedPhoto = photo;
                              });
                              final cameraProvider = Provider.of<CameraProvider>(context, listen: false);
                              await cameraProvider.sendPhotoToServer(photo);
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        CustomButton(
                          scaffoldContext: context,
                          content: const Icon(
                            Icons.camera,
                            size: 35,
                            color: Colors.white,
                          ),
                          width: 50,
                          height: 50,
                          color: colorButton,
                          borderRadius: BorderRadius.circular(50),
                          onPressed: () => {
                            Navigator.pushNamed(context, '/management')
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: CustomBottomNavigationBar(
                firstIcon: Icon(
                  CupertinoIcons.cube,
                  size: 30,
                  color: colorButtonSelected,
                ),
                firstText: Text(
                  "Volume",
                  style: TextStyle(
                    fontSize: 12,
                    color: colorButtonSelected
                  ),
                ),
                secondIcon: Icon(
                  Icons.history,
                  size: 33,
                  color: colorWhite,
                ),
                secondText: Text(
                  "Histórico",
                  style: TextStyle(
                    fontSize: 12,
                    color: colorWhite
                  ),
                ),
                linearGradient: LinearGradient(
                  colors: [colorGradient1, colorGradient2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), 
                  topRight: Radius.circular(15)
                ),
                onPressed: () => {},
              ),
            ),
          ],
        );
      }
    );
  }
}