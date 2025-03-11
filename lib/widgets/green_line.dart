import 'package:flutter/material.dart';

class GreenLine extends StatelessWidget {
  String text;
  GreenLine({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFE2EAEB),
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF3B8992),
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ));
  }
}
