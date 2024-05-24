import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/constants.dart';
import 'trip_controller.dart';

class TripPage extends StatelessWidget {
  TripController control = Get.put(TripController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('Trip Page'),
    );
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
