import 'package:flutter/material.dart';
import 'package:qhawaq_atoq/configs/constants.dart';

class CircularTextButton extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback callback;

  CircularTextButton({
    required this.icon,
    required this.text,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: this.callback,
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
