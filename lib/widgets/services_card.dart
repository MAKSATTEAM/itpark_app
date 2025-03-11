import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/utils/constants.dart';

class ServicesCard extends StatelessWidget {
  final String text;
  final String? text2;
  final Widget icon;

  ServicesCard({
    Key? key,
    required this.text,
    this.text2 = "",
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: kDecorationBox,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded( // Allows the text area to take up remaining space without pushing the icon out
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: MediumTextSize,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "$text2",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: BodyTextSize,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10), // Space between text and icon
          Container(
            width: 40,  // Fixed width for the icon
            height: 40, // Fixed height for the icon
            child: icon,
          ),
        ],
      ),
    );
  }
}
