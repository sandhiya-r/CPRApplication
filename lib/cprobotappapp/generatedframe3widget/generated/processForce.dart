//script to process FSR sensor data that is received
import 'dart:async';
import 'package:flutter/cupertino.dart';

// value notifier
final ValueNotifier<String> notify = ValueNotifier<String>("Place palm on sternum");
final ValueNotifier<Text> colorNotify = ValueNotifier<Text>(Text(
    "Place Hands on Sternum",
    overflow: TextOverflow.visible,
    textAlign: TextAlign.center,
    style: TextStyle(
        height: 1.219000021616618,
        fontSize: 20.0,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w700,
        color: Color.fromARGB(255, 255, 0, 0))));

//object to create and listen to streams for handling int values
final StreamController<int> fsrcontroller = StreamController<int>();



//add received sensor values to stream
final StreamSubscription<int> fsrsubscription = fsrcontroller.stream.listen((event) {
  //what happens when data is received
  //print(value);
  if (event>5){
    print("Hand detected");
    changeForceText();
  }


});

void changeForceText() async {
  notify.value="Correct Hand Placement";
}

void changeBackText() async {
  notify.value="Place hands on sternum";
}

void changeText() async {
   colorNotify.value = Text(
       "Correct Hand Placement",
       overflow: TextOverflow.visible,
       textAlign: TextAlign.center,
       style: TextStyle(
           height: 1.219000021616618,
           fontSize: 20.0,
           fontFamily: 'Montserrat',
           fontWeight: FontWeight.w700,
           color: Color.fromARGB(255, 0, 255, 0)));
}