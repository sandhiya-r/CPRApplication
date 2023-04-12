//script to process Time-of-Flight sensor data that is received
import 'dart:async';
import 'package:flutter/cupertino.dart';


//value notifier
final ValueNotifier<String> pass_notify = ValueNotifier<String>("");

//object to create and listen to streams for handling int values
final StreamController<int> depthcontroller = StreamController<int>();
final StreamController<int> ratecontroller = StreamController<int>();
final StreamController<int> recoilcontroller = StreamController<int>();
final StreamController<int> compcontroller = StreamController<int>();

//add received sensor values to stream

//final StreamSubscription<int> subscription = controller.stream.listen((value) {
  //what happens when data is received
  //print(value);


Future<double> updateDepthText(int depthcount, int compcount) async { //show the percentage of depth targets reached
  //depthcount = number of correct depths reached, compcount = number of total compressions done
  double percent = (depthcount/compcount);
  if (percent > 1.0){ //if compressions exceed 100bpm speed, mark as correct since actual range is 100-120 bpm
  percent = 1.0;
  }
  return percent;
}

Future<double> updateRateText(int ratecount, int compcount) async {
  //assume that 50 compressions should be done in 30 seconds
  double percent = (ratecount/compcount);
  if (percent > 1.0){ //if compressions exceed 100bpm speed, mark as correct since actual range is 100-120 bpm
    percent = 1.0;
  }
  return percent;
}

Future<double> updateRecoilText(int recoilcount, int compcount) async {
  //assume that 60 compressions should be done in 30 seconds
  double percent = (recoilcount/compcount);
  if (percent > 1.0){ //if compressions exceed 100bpm speed, mark as correct since actual range is 100-120 bpm
    percent = 1.0;
  }
  return percent;

}


void changePassText() async {
  pass_notify.value="PASS";
}

void changeFailText() async {
  pass_notify.value="FAIL";
}