import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';

class TextLine extends StatelessWidget {
  String title;
  String text;
  TextLine({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(children: [
          const SizedBox(height: 16),
          Row(children: [
            Flexible(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: title,
                  style: kzayavgreenTextStyle,
                ),
                TextSpan(text: " "),
                TextSpan(
                  text: text,
                  style: kzayavblackTextStyle,
                ),
              ])),
            )
          ])
        ]));
  }
}
