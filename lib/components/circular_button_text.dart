import 'package:flutter/material.dart';
import 'package:qhawaq_atoq/configs/constants.dart';

class CircularTextButton extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback callback;
  bool enabled;

  CircularTextButton(
      {required this.icon,
      required this.text,
      required this.callback,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: enabled ? () => this.callback() : null,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(16.0),
          ),
          child: Icon(
            this.icon,
            size: 24,
            color: appColor1,
          ),
        ),
        SizedBox(height: 8),
        Text(this.text),
      ],
    );
  }
}
