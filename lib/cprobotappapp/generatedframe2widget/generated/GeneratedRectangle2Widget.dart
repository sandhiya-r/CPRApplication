import 'package:flutter/material.dart';

/* Rectangle Rectangle 2
    Autogenerated by FlutLab FTF Generator
  */
class GeneratedRectangle2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/Certification'),
    child:
    Container(
      width: 208.0,
      height: 183.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          color: Color.fromARGB(255, 217, 217, 217),
        ),
      ),
    )
    );
  }
}