// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {

  final Icon firstIcon;
  final Icon secondIcon;
  final Widget firstText;
  final Widget secondText;
  final Color? backgroundColor;
  final LinearGradient? linearGradient;
  final BorderRadius? borderRadius;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback? onPressed;

  const CustomBottomNavigationBar({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    this.firstText = const Text(""),
    this.secondText = const Text(""),
    this.backgroundColor = Colors.grey,
    this.linearGradient,
    this.borderRadius,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    required this.onPressed,
  });

  @override
  State<CustomBottomNavigationBar> createState() => CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late final BorderRadius borderRadius;
  late final bool hasLinearGradient;

  @override
  void initState() {
    super.initState();
    borderRadius = widget.borderRadius ?? const BorderRadius.only(
      topLeft: Radius.circular(15), 
      topRight: Radius.circular(15)
    );
    hasLinearGradient = widget.linearGradient != null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        decoration: hasLinearGradient 
        ? BoxDecoration(
          gradient: widget.linearGradient,
          borderRadius: widget.borderRadius) 
        : BoxDecoration(color: widget.backgroundColor),
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.firstIcon,
                widget.firstText,
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.secondIcon,
                widget.secondText,
              ],
            ),
          ],
        )
      );
  }
}