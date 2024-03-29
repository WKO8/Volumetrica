// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volumetrica/widgets/custom_button.dart';
import 'package:volumetrica/widgets/custom_bottom_navigation_bar.dart';
import 'package:volumetrica/widgets/custom_side_menu.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final colorButton = Color(0xFF448AB5);
  final colorGradient1 = Color(0xFF448AB5);
  final colorGradient2 = Color(0xFF1E3C4F);
  final colorButtonSelected = Color(0xFF20A4F3);
  final colorWhite = Color(0xFFF8F8FF);
  final colorTransparent = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (BuildContext context) {
                    return CustomButton(
                      scaffoldContext: context,
                      content: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      width: 60,
                      height: 40,
                      color: colorButton,
                      onPressed: () => {
                        _scaffoldKey.currentState!.openDrawer()
                      },
                    );
                }),
                Builder(builder: (BuildContext context) {
                  return CustomButton(
                    scaffoldContext: context,
                    content: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    width: 60,
                    height: 40,
                    color: colorButton,
                    onPressed: () => {
                      Navigator.pushNamed(context, '/signin')
                    },
                  );
                })
              ],
            ),
          ),
        ),
      ),
      drawer: CustomSideMenu(),
      body: Column(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  scaffoldContext: context,
                  content: Icon(
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
                  content: Icon(
                    Icons.add_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                  width: 60,
                  height: 60,
                  color: colorButton,
                  borderRadius: BorderRadius.circular(50),
                  onPressed: () => {},
                ),
                CustomButton(
                  scaffoldContext: context,
                  content: Icon(
                    Icons.camera,
                    size: 35,
                    color: Colors.white,
                  ),
                  width: 50,
                  height: 50,
                  color: colorButton,
                  borderRadius: BorderRadius.circular(50),
                  onPressed: () => {},
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
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), 
          topRight: Radius.circular(15)
        ),
        onPressed: () => {},
      )
    );
  }
}
