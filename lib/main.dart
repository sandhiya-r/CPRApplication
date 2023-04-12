import 'package:flutter/material.dart';
import 'package:flutterapp/cprobotappapp/generatedframe1widget/GeneratedFrame1Widget.dart';
import 'package:flutterapp/cprobotappapp/generatedframe2widget/GeneratedFrame2Widget.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/GeneratedFrame3Widget.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/bluetooth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/Certification.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/videopage.dart';
void main(){

  runApp(CPRobotAppApp());
}

class CPRobotAppApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/GeneratedFrame1Widget',
      routes: {
        '/GeneratedFrame1Widget': (context) => SplashScreen(),
        '/GeneratedFrame2Widget': (context) => GeneratedFrame2Widget(),
        '/GeneratedFrame3Widget': (context) => GeneratedFrame3Widget(),
        '/Certification': (context) => Certification(),
        '/Demo': (context) => Demo()
      },
    );
  }
}
