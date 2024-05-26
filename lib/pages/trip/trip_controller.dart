import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bson/bson.dart';
import 'package:path/path.dart' as path;
import '../../models/entities/track.dart';
import '../../models/entities/picture.dart';
import '../../repositories/track_repository.dart';
import '../../repositories/picture_repository.dart';
import '../../services/trip_service.dart';

class TripController extends GetxController {
  ObjectId id = ObjectId();
  TrackRepository trackRepository = TrackRepository();
  PictureRepository pictureRepository = PictureRepository();
  Location location = Location();
  RxDouble latitude = (-11.99107547525432).obs;
  RxDouble longitude = (-76.5996417595332).obs;
  RxDouble altitude = (0.0).obs;
  RxBool focused = false.obs;
  final Key mapKey = UniqueKey();
  RxBool firstRecord = false.obs;
  RxBool takePictureEnable = false.obs;
  RxBool recordEnable = true.obs;
  RxBool uploadEnable = false.obs;
  TextEditingController txtName = TextEditingController();
  RxList<File> tempImages = <File>[].obs;
  Timer? timer;

  Future<void> getLocation(MapController mapController) async {
    try {
      var currentLocationData = await location.getLocation();
      print('getLocation');
      print(currentLocationData.latitude);
      print(currentLocationData.longitude);
      latitude.value = currentLocationData.latitude!;
      longitude.value = currentLocationData.longitude!;
      altitude.value = currentLocationData.altitude!;
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
    if (this.timer != null && this.timer!.isActive) {
      this.timer!.cancel();
    } else {
      startLocationUpdates();
    }
  }

  void takePicture(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      tempImages.value.add(file);
      String name = path.basename(file.path);
      final picture = Picture(
          id: ObjectId(),
          latitude: latitude.value,
          longitude: longitude.value,
          altitude: altitude.value,
          created: DateTime.now(),
          url: '${this.id?.toHexString()}/${name}');
      //print(picture);
      try {
        await pictureRepository.insert(picture);
        print('Picture insertado correctamente.');
      } catch (e) {
        print('Error al insertar el picture: $e');
      }
      focused.value = true;
    }
  }

  void startLocationUpdates() async {
    this.timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      try {
        var currentLocationData = await location.getLocation();
        //print('getLocation');
        //print(currentLocationData.latitude);
        //print(currentLocationData.longitude);
        latitude.value = currentLocationData.latitude!;
        longitude.value = currentLocationData.longitude!;
        altitude.value = currentLocationData.altitude!;
        final track = Track(
          id: ObjectId(),
          latitude: latitude.value,
          longitude: longitude.value,
          altitude: altitude.value,
          created: DateTime.now(),
        );
        print(track);
        try {
          await trackRepository.insert(track);
          print('Track insertado correctamente.');
        } catch (e) {
          print('Error al insertar el track: $e');
        }
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
              onPressed: () async {
                TripService service = TripService();
                List<Track> tracks = await this.trackRepository.fetchAll();
                List<Picture> pictures =
                    await this.pictureRepository.fecthAll();
                service.save(
                  this.id,
                  this.txtName.text.trim(),
                  this.tempImages,
                  tracks,
                  pictures,
                );
                Navigator.of(context).pop();
                this.firstRecord.value = false;
                this.uploadEnable.value = false;
                this.id = ObjectId();
                await this.trackRepository.deleteAll();
                await this.pictureRepository.deleteAll();
                this.tempImages.value.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
