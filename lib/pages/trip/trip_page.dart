import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../components/circular_button_text.dart';
import 'trip_controller.dart';
import '../../configs/constants.dart';

class TripPage extends StatelessWidget {
  MapController mapController = MapController();
  TripController control = Get.put(TripController());
  final Key mapKey = UniqueKey();

  Widget _map() {
    return FlutterMap(
      key: mapKey,
      options: MapOptions(
        center: LatLng(control.latitude.value, control.longitude.value),
        minZoom: 5,
        maxZoom: 25,
        zoom: 5,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.dr_gym',
        ),
        MarkerLayer(markers: [
          control.focused.value != false
              ? Marker(
                  width: 40.0,
                  height: 40.0,
                  point:
                      LatLng(control.latitude.value, control.longitude.value),
                  child: Container(
                    child: Icon(
                      Icons.location_on,
                      size: 40.0,
                      color: appColor3,
                    ),
                  ),
                )
              : Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(0, 0),
                  child: Container(
                    child: Icon(
                      Icons.location_on,
                      size: 0.0,
                      color: appColor3,
                    ),
                  ),
                )
        ], key: mapKey)
      ],
      mapController: mapController,
    );
  }

  Widget _buildBody(BuildContext context) {
    control.getLocation(mapController);
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Nombre del Recorrido',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: Obx(() => _map()),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularTextButton(
                  icon: Icons.camera_alt,
                  text: 'Tomar Foto',
                  callback: () {
                    // Acción del botón 1
                  }),
              CircularTextButton(
                  icon: Icons.fiber_smart_record_sharp,
                  text: 'Iniciar Recorrido',
                  callback: () {
                    // Acción del botón 2
                  }),
              CircularTextButton(
                  icon: Icons.upload,
                  text: 'Subir Datos',
                  callback: () {
                    // Acción del botón 3
                  }),
            ],
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: appColor5,
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: _buildBody(context),
    ));
  }
}
