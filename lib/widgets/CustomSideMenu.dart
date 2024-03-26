// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volumetrica/widgets/CustomButton.dart';

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({super.key});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(child:
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Color(0xFFAFD3E9), Color(0xFF20A4F3)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                ),
              ),
              child: Column(
                children: [
                  Theme(data: Theme.of(context).copyWith(
                    dividerTheme: const DividerThemeData(color: Colors.transparent)
                  ), 
                  child: DrawerHeader(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0, left: 15.0),
                          child: CustomButton(
                            scaffoldContext: context,
                            content: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            width: 60,
                            height: 40,
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFF448AB5),
                            onPressed: () => {
                              Navigator.pop(context)
                            },
                          ),
                        ),
                      ],
                    )
                  )),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // home page list tile
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.cube_fill,
                              color: Color(0xFF448AB5),
                              size: 30,
                            ),
                            title: Text(
                              "Volume",
                              style: TextStyle(
                                color: Color(0xFF448AB5),
                                fontSize: 20
                              ),
                            ),
                            onTap: () {
                              // pop drawer first
                              Navigator.pop(context);
                                        
                              // go to home page
                              Navigator.pushNamed(context, '/home');
                            },
                          ),
                          
                          SizedBox(height: 20),
                          
                          // history page list tile
                          ListTile(
                            leading: Icon(
                              Icons.history,
                              size: 30,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Histórico",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                            onTap: () {
                              // pop drawer first
                              Navigator.pop(context);
                                        
                              // go to settings page
                              Navigator.pushNamed(context, '/settings');
                            },
                          ),
                          
                          SizedBox(height: 20),
                          
                          // about page list tile
                          ListTile(
                            leading: Icon(
                              Icons.info_outline,
                              size: 30,
                              color: Colors.white,
                            ),
                            title: Text(
                              "Sobre",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                              ),
                            ),
                            onTap: () {
                              // pop drawer first
                              Navigator.pop(context);
                                        
                              // go to settings page
                              Navigator.pushNamed(context, '/settings');
                            },
                          )
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      )
    );
  }
}