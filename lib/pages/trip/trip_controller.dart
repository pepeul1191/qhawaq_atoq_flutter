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
}
