import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/generated/processTOF.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quickalert/quickalert.dart';

class Certification extends StatefulWidget {
  @override
  _CertPage createState() => _CertPage();
}

/*
Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed:()=>ble2.connectDevice(),
                      child: const Text('Bluetooth Connect'),
                    )
                )
 */
class _CertPage extends State<Certification> {

  final ReactiveBle ble2 = new ReactiveBle();
  final CountDownController timercontroller = CountDownController();

  late double rate_percent;
  late double recoil_percent;
  late double depth_percent;

  @override
  void initState() {
    super.initState();
    this.rate_percent = 0.0;
    this.recoil_percent = 0.0;
    this.depth_percent = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.lightBlueAccent,
                  padding: const EdgeInsets.all(16.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed:()=>ble2.connectDevice(),
                child: const Text('Bluetooth Connect'),
              )
          ),

          Text(
          '''CPR Testing in Progress...''',
          //overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.2189999580383302,
            fontSize: 25.0,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 9, 48, 83),
          )),

            CircularCountDownTimer(
              duration: 32,
              initialDuration: 0,
              controller: timercontroller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height/2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Color.fromARGB(255, 31, 100, 162),
              fillGradient: null,
              backgroundColor: Color.fromARGB(255, 9, 48, 83),
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,
              autoStart: false,
              onStart: () {
                debugPrint('Countdown Started');
              },
              onComplete: () {
                debugPrint('Countdown Ended');
                updateRecoilText(ReactiveBle.recoilflag,ReactiveBle.compressionflag).then((value)=>{ //will change percentage to correct value based on compression metrics
                  setState(() {
                    this.recoil_percent = value;

                  })
                });

                updateDepthText(ReactiveBle.depthflag,ReactiveBle.compressionflag).then((value)=>{ //will change percentage to correct value based on compression metrics
                  setState(() {
                    this.depth_percent = value;
                  })
                });

                updateRateText(ReactiveBle.rateflag,ReactiveBle.compressionflag).then((value)=>{ //will change percentage to correct value based on compression metrics
                  setState(() {
                    this.rate_percent = value;
                    if (this.rate_percent > 0.79 && this.depth_percent >0.49 && this.recoil_percent>0.49){

                      QuickAlert.show( //quick alert dialog to show pass result
                        context: context,
                        type: QuickAlertType.success,
                        text: 'CPR Certification Completed!',
                        autoCloseDuration: const Duration(seconds: 5),
                      );


                    }
                    else{
                      //changeFailText();
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'FAIL',
                        text: 'CPR Certification Failed',
                        autoCloseDuration: const Duration(seconds: 5),
                      );

                    }

                  })
                });
                print("PERCENTS"+this.rate_percent.toString()+","+this.depth_percent.toString());



                //() => ble2.changeDepthText;
              },
              onChange: (String timeStamp) {
                debugPrint('Countdown Changed $timeStamp');
              },
              timeFormatterFunction: (defaultFormatterFunction, duration) {
                if (duration.inSeconds == 0) {
                  return 'Done';
                } else {
                  return Function.apply(defaultFormatterFunction, [duration]);
                }
              },
            ),


          SizedBox(height: 0), //to create spacing between widgets

          FloatingActionButton(
            child: Icon(Icons.timer),
            backgroundColor: Color.fromARGB(255, 9, 48, 83),
            foregroundColor: Colors.white,
            onPressed: () => timercontroller.start()
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              CircularPercentIndicator(
                radius: 63.0,
                lineWidth: 20.0,
                percent: rate_percent,
                animation: true,
                backgroundColor: Color.fromARGB(100, 9, 48, 83),
                progressColor: Color.fromARGB(255,9,48,83),
                circularStrokeCap: CircularStrokeCap.round,
                  center: Text("Rate: "+((rate_percent*100).toInt()).toString()+"%", style: TextStyle(fontFamily: 'Montserrat'))

              ), //rate
              CircularPercentIndicator(
                radius: 63.0,
                lineWidth: 20.0,
                percent: depth_percent,
                animation: true,
                backgroundColor: Color.fromARGB(100,35,105,35),
                progressColor: Color.fromARGB(255, 35, 105, 35),
                circularStrokeCap: CircularStrokeCap.round,
                center: Text("Depth: "+((depth_percent*100).toInt()).toString()+"%", style: TextStyle(fontFamily: 'Montserrat'))

              ), //depth
              CircularPercentIndicator(
                radius: 63.0,
                lineWidth: 20.0,
                percent: recoil_percent,
                animation: true,
                backgroundColor: Color.fromARGB(100, 210, 238, 93),
                progressColor: Color.fromARGB(255, 210, 238, 93),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text("Recoil: "+((recoil_percent*100).toInt()).toString()+"%", style: TextStyle(fontFamily: 'Montserrat'))


              )  //recoil
            ],
          ),
          Positioned(
            left: 100.0,
                right:null,
              top:null,
            bottom:100.0,
            width:500.0,
            height:200.0,
            child:
            ValueListenableBuilder( //DISPLAY RESULTS OF FORCE SENSOR WHEN CHANGED
                valueListenable: pass_notify,
                builder: (BuildContext context, String value, Widget? child) {
                  return Text(
                      value,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.219000021616618,
                          fontSize: 20.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 9, 48, 83)));
                }),
          )


        ]
      )
    );
  }
}


//BLUETOOTH PART
//BLUETOOTH
class ReactiveBle {

  final FlutterReactiveBle flutterReactiveBle2 = FlutterReactiveBle();

  //late StreamSubscription<ConnectionStateUpdate> connection;
  static int depthval = 0;
  static int depthflag = 0;
  static int compressionflag = 0;
  static int recoilflag = 0;
  static int rateflag = 0;
  static int handflag = 0;
  static String allValues = "";
  static int depthcounter = 0;
  static int ratecounter = 0;
  static int recoilcounter = 0;
  static int compressioncounter = 0;

  //QualifiedCharacteristic characteristic;

  // void changeDepthText() async {
  //   depth_notify.value="Number of Depth Targets Reached: " + depthcounter.toString();
  // }

  void connectDevice() async {
    flutterReactiveBle2.statusStream.listen((status) {
      print(status);
    });

    final characteristic2 = QualifiedCharacteristic(
        serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
        characteristicId: Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
        deviceId: 'A0:6C:65:C9:FE:D5' //HM-10
      //deviceId: 'E4:E1:12:2E:5A:F3', //HM-19
    );

    // //start the stream controller for FSR
    // fsrcontroller2.stream.listen((event) {
    //   //what happens when data is received
    //   //print(value);
    //   if (event>5){
    //     print("Hand detected");
    //     changeForceText();
    //   }
    //   else{
    //     changeBackText();}
    // });

    //start the stream controller for depth values
    depthcontroller.stream.listen((event) {
      //what happens when data is received
      //print(value);

        print("Correct Depth reading ");
        depthcounter = event; //increment depth counter
        //changeForceText();


    });

    //start the stream controller for recoil values
    recoilcontroller.stream.listen((event) {
      //what happens when data is received
      //print(value);

        recoilcounter = event; //increment depth counter
        //changeForceText();

    });

    //start the stream controller for rate values
    ratecontroller.stream.listen((event) {
      //what happens when data is received
      //print(value);
       //flag for correct depth is 1

        print("Correct Rate reading ");
        ratecounter = event; //increment depth counter
        //changeForceText();

    });

    //start the stream controller for compression values
    compcontroller.stream.listen((event) {
      //what happens when data is received
      //print(value);
      //flag for correct depth is 1
        print("Correct comp reading ");
        compressioncounter = event; //increment depth counter
        //changeForceText();

    });

    flutterReactiveBle2.connectToAdvertisingDevice(
      id: 'A0:6C:65:C9:FE:D5',
      withServices: [],
      prescanDuration: const Duration(seconds: 5),
      connectionTimeout: const Duration(seconds: 10),
    ).listen((state) async {
      if (state.connectionState == DeviceConnectionState.connected) {
        print('Connected to device!');
        flutterReactiveBle2.writeCharacteristicWithoutResponse(characteristic2, value: [0x01]); //SENDING TO ARDUINO
        //await flutterReactiveBle2.writeCharacteristicWithResponse(characteristic2, value: [0x01]);

        flutterReactiveBle2.subscribeToCharacteristic(characteristic2).listen(
              (data) {
            //depthval = int.parse(String.fromCharCodes(data));
            //Code  for receiving multiple values from Arduino
            allValues = String.fromCharCodes(data);
            var parsedValues = allValues.split(',');
            print(parsedValues[0]);
            print(parsedValues[1]);
            depthval = int.parse(parsedValues[0]);
            depthflag = int.parse(parsedValues[1]);
            recoilflag = int.parse(parsedValues[2]);
            rateflag = int.parse(parsedValues[3]);
            compressionflag = int.parse(parsedValues[4]);
            handflag = int.parse(parsedValues[5]);

            depthcontroller.add(depthflag);
            recoilcontroller.add(recoilflag);
            ratecontroller.add(rateflag);
            compcontroller.add(compressionflag);

            print(String.fromCharCodes(data));
            //print(data);
            // parse
          },
          onError: (dynamic error) {
            print('Error occurred when subscribing to characteristic');
          },
        );
      }
    }, onError: (dynamic error) {
      print(error.toString());
    });
  }
}
