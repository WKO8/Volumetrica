// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volumetrica/widgets/custom_button.dart';

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({super.key});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  final ValueNotifier<int> _selectedIndexNotifier = ValueNotifier<int>(0); // Initialize the selected index to 0 (or any default index)

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
                      child: ValueListenableBuilder<int>(
                        valueListenable: _selectedIndexNotifier,
                        builder: (context, selectedIndex, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // home page list tile
                              _buildListTile(
                                icon: CupertinoIcons.cube_fill,
                                text: "Volume",
                                index: 0,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/home');
                                },
                              ),
                              SizedBox(height: 20),
                              // history page list tile
                              _buildListTile(
                                icon: Icons.history,
                                text: "Histórico",
                                index: 1,
                                onTap: () {
                                  // Navigator.pop(context);
                                  // Navigator.pushNamed(context, '/home'); // Assuming you want to navigate to the home page with history opened
                                },
                              ),
                              SizedBox(height: 20),
                              // about page list tile
                              _buildListTile(
                                icon: Icons.info_outline,
                                text: "Sobre",
                                index: 2,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, '/about');
                                },
                              ),
                            ]
                          );
                        },
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

  Widget _buildListTile({required IconData icon, required String text, required int index, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: _selectedIndexNotifier.value == index ? Color(0xFF448AB5) : Colors.white,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _selectedIndexNotifier.value == index ? Color(0xFF448AB5) : Colors.white,
          fontSize: 20
        ),
      ),
      onTap: () {
        _selectedIndexNotifier.value = index; // Update the selected index without setState
        onTap();
      },
    );
  }
}
