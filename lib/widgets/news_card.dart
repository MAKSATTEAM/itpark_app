import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class NewsCard extends StatelessWidget {
  String date;
  String text;
  String url;

  NewsCard({super.key, required this.date, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UrlLauncher.launch(url);
      },
      child: Container(
        decoration: kDecorationBox,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontWeight: FontWeight.w700,
                    fontSize: 12),
              ),
              SizedBox(
                height: 8,
              ),
              Text(text, style: kContentTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
