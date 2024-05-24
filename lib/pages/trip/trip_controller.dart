import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/trip_service.dart';

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
  TextEditingController txtName = TextEditingController();
  RxList<File> images = <File>[].obs;
  Timer? timer;

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
    // print('recordTrip');
    // print(this.takePictureEnable.value); // false stop, true start
    // buttons
    if (this.firstRecord.value == false) {
      // only the first time
      this.firstRecord.value = true;
    }
    this.takePictureEnable.value = !this.takePictureEnable.value;
    this.uploadEnable.value = false;
    if (this.firstRecord.value && !this.takePictureEnable.value) {
      this.uploadEnable.value = true;
    }
    // timer
    if (this.timer!.isActive) {
      this.timer!.cancel();
    } else {
      startLocationUpdates();
    }
  }

  void takePicture(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      images.value.add(File(pickedFile.path));
    }
  }

  void startLocationUpdates() async {
    this.timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      try {
        var currentLocationData = await location.getLocation();
        print('getLocation');
        print(currentLocationData.latitude);
        print(currentLocationData.longitude);
        latitude.value = currentLocationData.latitude!;
        longitude.value = currentLocationData.longitude!;
        focused.value = true;
      } catch (e) {
        print('Error al obtener la ubicación: $e');
      }
    });
  }

  void uploadTrip(BuildContext context) {
    // print('Controller dice... Subir Recorrido');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Estamos a un paso de grabar el nuevo recorrido'),
          content: Text('Si descide grabar el recorrido no podŕa retomarlo.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Grabar'),
              onPressed: () {
                // Acción a realizar al aceptar
                TripService service = TripService();
                service.save(this.txtName.text.trim(), this.images);
                Navigator.of(context).pop();
                this.firstRecord.value = false;
                this.uploadEnable.value = false;
              },
            ),
          ],
        );
      },
    );
  }
}
