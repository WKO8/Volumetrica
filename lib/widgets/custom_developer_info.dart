import 'package:flutter/material.dart';

class CustomDeveloperInfo extends StatelessWidget {
  final AssetImage photo; 
  final String name;
  final String responsibility;
  final Color textColor;

 const CustomDeveloperInfo({super.key, required this.photo, required this.name, required this.responsibility, required this.textColor});

 @override
 Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                 fit: BoxFit.cover,
                 image: photo,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                 fontFamily: 'Inter',
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
                 color: textColor,
                ),
              ),
              Text(
                responsibility,
                style: TextStyle(
                 fontFamily: 'Inter',
                 fontSize: 14,
                 fontWeight: FontWeight.w400,
                 color: textColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
 }
}
