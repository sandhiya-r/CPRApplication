import 'package:flutter/material.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/generated/GeneratedCPRMetricsWidget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutterapp/cprobotappapp/generatedframe3widget/generated/processForce.dart';



class GeneratedFrame3Widget extends StatefulWidget {
  @override
  _SensorPage createState() => _SensorPage();
}

class _SensorPage extends State<GeneratedFrame3Widget> {
  late List<SensorData> sensorData;
  late ChartSeriesController
      _chartSeriesController; //late means will be initialized on first use
  final ReactiveBle ble = new ReactiveBle();


  @override
  void initState() {
    sensorData = getChartData();
    Timer.periodic(const Duration(milliseconds: 50),
        updateDataSource); //call updateDataSource every 50 ms
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Container(
        width: 390.0,
        height: 844.0,
        child:
            Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Positioned(
            left: 0.0,
            top: 70.0,
            right: null,
            bottom: null,
            width: 256.0,
            height: 30.0,
            child: GeneratedCPRMetricsWidget(),
          ),
              Positioned(
                left:0.0,
                top:170.0,
                right:null,
                bottom:null,
                width:400.0,
                height:30.0,
                child: ValueListenableBuilder( //DISPLAY RESULTS OF FORCE SENSOR WHEN CHANGED
                      valueListenable: notify,
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
                          color: Color.fromARGB(255, 0, 0, 0)));
                      })

      ),
              Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.lightBlueAccent,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed:()=>ble.connectDevice(),
                    child: const Text('Bluetooth Connect'),
                  )
              ),

          Positioned.fill(
              left: 0.0,
              top: 200,
              right: 0.0,
              bottom: 0.0,
              child: SafeArea(
                  child: Scaffold(
                      body: SfCartesianChart(
                          annotations: <CartesianChartAnnotation>[
                            CartesianChartAnnotation(

                                coordinateUnit: CoordinateUnit.percentage,
                                region: AnnotationRegion.plotArea,
                  widget: Text('Recoil Target',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  x: '70%',
                  y: '30%'
              ),
                            CartesianChartAnnotation(

                                coordinateUnit: CoordinateUnit.percentage,
                                region: AnnotationRegion.plotArea,
                                widget: Text('Depth Target',
                                    style: TextStyle(
                                      fontSize: 14,
                                    )),
                                x: '70%',
                                y: '72%'
                            )

                          ],
                          primaryYAxis: NumericAxis(
                              minimum: 20,
                              maximum: 150,
                              anchorRangeToVisiblePoints: true,
                              plotBands: [
                                PlotBand(
                                    start: 105, // y-point for which the horizontal line needs to be drawn.
                                    end: 115,
                                    color: Colors.green,
                                    opacity: 0.3,
                                    borderColor: Colors.red,
                                    borderWidth: 2, // set the border width for the horizontal line.
                                    associatedAxisStart: 0 // set the required value for assicoated x-axis start  property
                                ),
                                PlotBand(
                                    start: 50, // y-point for which the horizontal line needs to be drawn.
                                    end: 60,
                                    color: Colors.green,
                                    opacity: 0.3,
                                    borderColor: Colors.red,
                                    borderWidth: 2, // set the border width for the horizontal line.
                                    associatedAxisStart: 0 // set the required value for assicoated x-axis start  property
                                )
                              ]),
                              series: <ChartSeries>[
                SplineSeries<SensorData, int>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    dataSource: sensorData,
                    xValueMapper: (SensorData sensor, _) => sensor.time,
                    yValueMapper: (SensorData sensor, _) => sensor.depth,
                    pointColorMapper: (SensorData sensor, _) {
                      if (sensor.depth >60) {
                        //ADJUST COLOR BASED ON DEPTH/RECOIL ACCURACY
                        return Color.fromRGBO(255, 0, 0, 1);
                      } else {
                        return Color.fromRGBO(0, 255, 0, 1);
                      }
                    })
              ])
                  )) //create Cartesian chart,
              ),
        ]),
      ),
    ));
  }





  //update data source method
  int time = 11;
  void updateDataSource(Timer timer) {
    //sensorData.add(SensorData(time++, math.Random().nextInt(20) +100));
    sensorData.add(SensorData(time++,ReactiveBle.depthval));
    //generating random depth values between 150 and 120
    sensorData.removeAt(
        0); //always remove the first point in the list to keep only window of points showing
    _chartSeriesController.updateDataSource(
        addedDataIndex:
            sensorData.length - 1, //add the new data point at the end
        removedDataIndex: 0 //remove the first one
        );
  }

  //get chart data for graphing sensor values
  List<SensorData> getChartData() {
    final List<SensorData> chartData = [
      SensorData(1, 0),
      SensorData(2, 0),
      SensorData(3, 0),
      SensorData(4, 0),
      SensorData(5, 0),
      SensorData(6, 0),
      SensorData(7, 0),
      SensorData(8, 0),
      SensorData(9, 0),
      SensorData(10, 0),
      SensorData(11, 0)
    ];
    return chartData;
  }
}

class SensorData {
  //temporary class here to simulate the received depth values from sensor
  SensorData(this.time, this.depth);
  final int depth;
  final int time;
}




//BLUETOOTH
class ReactiveBle {

  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  //late StreamSubscription<ConnectionStateUpdate> connection;
  static int depthval = 0;
  static int floatval = 0;
  static String allValues = "";
  static int depthflag = 0;
  static int compressionflag = 0;
  static int recoilflag = 0;
  static int rateflag = 0;
  static int handflag = 0;
   //QualifiedCharacteristic characteristic;

  //disconnect from device

  //discover BLE devices
  /* void discover(){
    flutterReactiveBle.scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
    //code for handling results
    }, onError: () {
    //code for handling error});
  });
  }*/
  void connectDevice() async {
    flutterReactiveBle.statusStream.listen((status) {
      print(status);
    });

    final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
      characteristicId: Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
      deviceId: 'A0:6C:65:C9:FE:D5' //HM-10
      //deviceId: 'E4:E1:12:2E:5A:F3', //HM-19
    );

    //start the stream controller for FSR
     fsrcontroller.stream.listen((event) {
      //what happens when data is received
      //print(value);
      if (event==1){
        print("Hand detected");
        changeForceText();
      }
     else{
        changeBackText();}
     });

     //start the stream controller for peak finding


    flutterReactiveBle.connectToAdvertisingDevice(
      id: 'A0:6C:65:C9:FE:D5',
      withServices: [],
      prescanDuration: const Duration(seconds: 5),
      connectionTimeout: const Duration(seconds: 10),
    ).listen((state) async {
      if (state.connectionState == DeviceConnectionState.connected) {
        print('Connected to device!');
        flutterReactiveBle.writeCharacteristicWithoutResponse(characteristic, value: [0x00]);
        //await flutterReactiveBle.writeCharacteristicWithResponse(characteristic, value: [0x00]);

        flutterReactiveBle.subscribeToCharacteristic(characteristic).listen(
              (data) {
                //depthval = int.parse(String.fromCharCodes(data));
                //Code  for receiving multiple values from Arduino
                 allValues = String.fromCharCodes(data);
                 var parsedValues = allValues.split(',');
                 print(parsedValues[0]);
                 print(parsedValues[1]);
                 depthval = int.parse(parsedValues[0]);
                 handflag = int.parse(parsedValues[5]);

                fsrcontroller.add(handflag);
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


///////////////////////////////////CODE STARTS HERE
  //connect to Arduino
  // void connectDevice() async{
  //   print('Got here!');
  //   flutterReactiveBle.statusStream.listen((status) {
  //     //code for handling status update
  //     print(status);
  //   });
  //
  //   flutterReactiveBle.connectToAdvertisingDevice(id: 'E4:E1:12:2E:5A:F3', withServices: [], prescanDuration: const Duration(seconds: 5), connectionTimeout: const Duration(seconds:  10)).listen((state) async{
  //     print(state.connectionState);
  //     if (state.connectionState == DeviceConnectionState.connected){
  //       //change status to connected
  //
  //       print('Got to connected!!');
  //       // receiving from arduino
  //       final characteristic  = QualifiedCharacteristic(
  //           serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
  //           characteristicId: Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
  //           deviceId:'E4:E1:12:2E:5A:F3' );
  //       print('It found the characteristic');
  //
  //       //final response = await flutterReactiveBle.readCharacteristic(characteristic);
  //       //print(response);
  //
  //       //once characteristic is found, subscribe to read continuously
  //             flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
  //           // code to handle incoming data
  //           print(data); //check if data is being displayed
  //           //depth = data[0];
  //           // print(depth);
  //         }, onError: (dynamic error) {
  //           print('Error occurred when subscribing to characteristic');
  //           // code to handle errors
  //         });
  //     }
  //
  //   },
  //   onError: (dynamic error){
  //     print(error.toString());
  //   });

//// ENDS HERE ORIGINAL CODE


    //flutterReactiveBle.connectToAdvertisingDevice( //FOR ANDROID ISSUES
    //     id: foundDeviceId,
    //     withServices: [serviceUuid],
    //     prescanDuration: const Duration(seconds: 5),
    //     servicesWithCharacteristicsToDiscover: {serviceId: [char1, char2]},
    //     connectionTimeout: const Duration(seconds:  2),
    //   ).listen((connectionState) {
    //     // Handle connection state updates
    //   }, onError: (dynamic error) {
    //     // Handle a possible error
    //   });



 // }

}
