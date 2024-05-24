import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class TripController extends GetxController {
  Location location = Location();
  RxDouble latitude = (-11.99107547525432).obs;
  RxDouble longitude = (-76.5996417595332).obs;
  RxBool focused = false.obs;
  final Key mapKey = UniqueKey();
  RxBool firstRecord = false.obs;
  RxBool takePictureEnable = false.obs;
  RxBool recordEnable = true.obs;
  RxBool uploadEnable = false.obs;

  Future<void> getLocation(MapController mapController) async {
    try {
      var currentLocationData = await location.getLocation();
      print('getLocation');
      print(currentLocationData.latitude);
      print(currentLocationData.longitude);
      latitude.value = currentLocationData.latitude!;
      longitude.value = currentLocationData.longitude!;
      mapController.move(LatLng(latitude.value, longitude.value), 15.0);
      focused.value = true;
    } catch (e) {
      print('Error al obtener la ubicación: $e');
    }
  }

  void recordTrip() {
    print('recordTrip');
    // print(this.takePictureEnable.value); // false stop, true start
    if (this.firstRecord.value == false) {
      // only the first time
      this.firstRecord.value = true;
    }
    this.takePictureEnable.value = !this.takePictureEnable.value;
    this.uploadEnable.value = false;
    if (this.firstRecord.value && !this.takePictureEnable.value) {
      this.uploadEnable.value = true;
    }
  }

  void takePicture() {
    print('Controller dice... Tomar Foto');
  }

  void uploadTrip() {
    print('Controller dice... Subir Recorrido');
    this.firstRecord.value = false;
    this.uploadEnable.value = false;
  }
}
