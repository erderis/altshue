import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:altshue/app/modules/home/providers/beranda_provider.dart';
import 'package:altshue/app/modules/home/views/home_view.dart';
import 'package:altshue/app/utils/services/local_storage.dart';
import 'package:altshue/app/utils/ui/show_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomeController extends GetxController {
  final steps = 0.obs;
  int stepCounter = 1;
  int currentStep = 0;
  int duration = 0;
  final durationDisplay = '0'.obs;
  final distance = 0.0.obs;

  //default activity
  int stepDefault = 0;
  int durationDefault = 0;
  double distanceDefault = 0.0;

  bool callcontroller = false;

  //activity
  void getActivity() {}

  void postActivity() {
    Map dataActivity = {
      'Steps': steps.value.toString(),
      'Distance': distance.value.toString(),
      'Hours': (duration / 3600).toString()
    };
    print(dataActivity);
    HomeProvider().acitivitySave(dataActivity: dataActivity).then((response) {
      if (response.status == 200) {
        getActivity();
      } else {
        showToasts(text: response.message);
      }
    });
  }

  bool isFirstGet = false;

  void getDefaultActivity() {
    final now = DateTime.now();
    if (now.day == getCurrentDay()) {
      isFirstGet = true;

      if (getStep() != null) {
        stepDefault = getStep()!.toInt();
        steps.value = stepDefault;
      }
      if (getDuration() != null) {
        durationDefault = getDuration()!.toInt() * 1000;
        print('durationDefault $durationDefault');
        final displayTime =
            StopWatchTimer.getDisplayTimeMinute(durationDefault);
        if (displayTime[0] == '0') {
          durationDisplay.value = displayTime.substring(1);
        } else {
          durationDisplay.value = displayTime;
        }
      }
      if (getDistance() != null) {
        distanceDefault = getDistance()!.toDouble();
        distance.value = distanceDefault;
      }
    } else {
      saveCurrentDay(now.day);
      eraseDataActivity();
    }
  }

  //bluetooth
  //alat 1
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

//battery alat 1
  final String BATTERY_UUID = "0000180f-0000-1000-8000-00805f9b34fb";
  final String LEVEL_UUID = "00002a19-0000-1000-8000-00805f9b34fb";

  //alat 2
  // final String SERVICE_UUID = "6e400001-b5a3-f393-e0a9-e50e24dcca9e";
  // final String CHARACTERISTIC_UUID = "6e400003-b5a3-f393-e0a9-e50e24dcca9e";
  final isConnected = false.obs;

  void changeConnected(BluetoothDevice device) async {
    device.connect();
    callcontroller = true;

    device.state.listen((event) {
      print('event ${event.index}');
      if (event.index == 0) {
        isConnected.value = false;
        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        locationSubscription.cancel();
        changeConnected(device);
      } else {
        if (callcontroller) {
          isConnected.value = true;
          getDefaultActivity();
          discoverService(device);
          startTimer();
          setDistance();
        }
      }
    });
  }

  void discoverService(BluetoothDevice device) async {
    callcontroller = false;

    List<BluetoothService> services = await device.discoverServices();

    // for (int i = 0; i < services.length; i++) {
    //   print('uuid service is ${services[i].uuid.toString()}');
    //   for (int j = 0; j < services[i].characteristics.length; j++) {
    //     print(
    //         'uuid characteristic level is ${services[i].characteristics[j].uuid.toString()}');
    //   }
    // }

    for (var service in services) {
      if (service.uuid.toString() == BATTERY_UUID) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == LEVEL_UUID) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              print('battery is :: ${utf8.decode(value)}');
              if (utf8.decode(value).isNotEmpty) {
                // batteryPercent.value = int.parse(utf8.decode(value));
              }
            });
          }
        }
      }
      if (service.uuid.toString() == SERVICE_UUID) {
        for (var characteristic in service.characteristics) {
          print('uuid is ${characteristic.uuid.toString()}');
          if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              // print('value dari service ketiga:: ${utf8.decode(value)},');
              print('value dari service ketiga:: ${utf8.decode(value)},');
              final newValue = utf8.decode(value);
              // print('data step is ${newValue.split('#')[0].split('@')[1]}');
              // final dataStepNew = newValue.split('#')[0].split('@')[1];
              if (value.isNotEmpty) {
                //battery alat 2
                // batteryPercent.value =
                //     int.parse(newValue.split('#')[1].split('!')[0]);

                //alat 1
                final step = int.parse(newValue);

                // alat 2
                // final step = int.parse(newValue.split('#')[0].split('@')[1]);

                if ((step == 1 || step == 0) && stepDefault == 0) {
                  steps.value = step;
                  currentStep = step;
                } else {
                  if (step != currentStep) {
                    steps.value += 2;
                    currentStep = step;

                    if (isFirstGet) {
                      steps.value -= 2;
                      isFirstGet = false;
                    }
                  }
                }
                saveStep(steps.value);
              }
            });
          }
        }
      }
    }
  }

  StopWatchTimer _stopWatchTimer = StopWatchTimer();

  void startTimer() {
    _stopWatchTimer = StopWatchTimer(
      onChange: (value) {
        final displayTime =
            StopWatchTimer.getDisplayTimeMinute(value + durationDefault);
        if (displayTime[0] == '0') {
          durationDisplay.value = displayTime.substring(1);
        } else {
          durationDisplay.value = displayTime;
        }
      },
    );
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    _stopWatchTimer.secondTime.listen((value) {
      duration = value + durationDefault ~/ 1000;
      saveDuration(duration);

      if (duration % 60 * 20 == 0 && steps.value != 0) {
        postActivity();
      }
    });
  }

  //distance

  Location location = Location();
  late StreamSubscription<LocationData> locationSubscription;
  setDistance() {
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      print('heading:: ${currentLocation.verticalAccuracy}');
      distance.value += (2 / 1000);
      saveDistance(distance.value);
    });
  }

  void toBluetoothList() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

//     BluetoothEnable.enableBluetooth.then((value){
//   if (value == "true"){
//     //Bluetooth has been enabled
//   }
//   else if (result == "false") {
//     //Bluetooth has not been enabled
//   }
// });

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
      } else {
        showDialogBluetooth();
      }
    } else {
      showDialogBluetooth();
    }
  }

  //battery
  final batteryPercent = 0.obs;

  //close app

  DateTime currentBackPressTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showToasts(
        text: 'Tekan sekali lagi untuk keluar',
      );
      return Future.value(false);
    }
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
    return Future.value(false);
  }

  @override
  void onInit() {
    getDefaultActivity();
    super.onInit();
  }
}
