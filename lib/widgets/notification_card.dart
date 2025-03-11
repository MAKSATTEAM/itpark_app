import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  String tema;
  String time;
  String text;
  bool active;

  NotificationCard(
      {super.key, required this.tema,
      required this.time,
      required this.text,
      required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: active
          ? kDecorationBox.copyWith(
              border: Border.all(
              color: Color(0xFF3B8992),
              width: 1,
            ))
          : kDecorationBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  tema,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14),
                ),
              ),
              Expanded(
                child: Text(
                  time,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
