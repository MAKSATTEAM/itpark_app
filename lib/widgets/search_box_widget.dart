import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';

class SearchBoxWidget extends StatelessWidget {
  String title;
  String text;

  SearchBoxWidget({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
      decoration: kDecorationBox,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: kSearchTextStylegreen),
              SizedBox(height: 7),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: AutoSizeText(text, style: kSearchTextStyleblack)),
            ],
          ),
        ],
      ),
    );
  }
}
