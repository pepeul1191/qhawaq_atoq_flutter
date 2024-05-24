import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../configs/constants.dart';
import 'trip_summary_controller.dart';

class TripSummaryPage extends StatelessWidget {
  TripSummaryController control = Get.put(TripSummaryController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Text('TripSummary Page'),
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
