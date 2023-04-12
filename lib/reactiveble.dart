import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class ReactiveBle {
  final FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<ConnectionStateUpdate> connection;
  late int depth;

  late QualifiedCharacteristic characteristic;

  //disconnect from device

  //discover BLE devices
 /* void discover(){
    flutterReactiveBle.scanForDevices(withServices: [], scanMode: ScanMode.lowLatency).listen((device) {
    //code for handling results
    }, onError: () {
    //code for handling error});
  });
  }*/

  //connect to Arduino
  void connectDevice() async{
    connection = flutterReactiveBle.connectToDevice(id: 'E4:E1:12:2E:5A:F3').listen((state){
      if (state.connectionState == DeviceConnectionState.connected){
        //change status to connected

        // receiving from arduino
        characteristic  = QualifiedCharacteristic(
            serviceId: Uuid.parse("0000ffe0-0000-1000-8000-00805f9b34fb"),
            characteristicId: Uuid.parse("0000ffe1-0000-1000-8000-00805f9b34fb"),
            deviceId:'E4:E1:12:2E:5A:F3' );
  }

});

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

    //once characteristic is found, subscribe to read continuously
    flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
      // code to handle incoming data
      print(data); //check if data is being displayed
      depth = data[0];
      print(depth);
    }, onError: (dynamic error) {
      // code to handle errors
    });
  }

}

