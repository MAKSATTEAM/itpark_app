import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPageOpen extends StatelessWidget {
  String tema;
  String body;
  NotificationPageOpen({super.key, required this.tema, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBacColor,
        iconTheme: IconThemeData(color: kIconColor),
        elevation: 0,
        centerTitle: true,
        title: Text("${AppLocalizations.of(context)?.notifications}",
            style: kAppBarTextStyle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Container(
              color: Color(0xFFE2EAEB),
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              child: Text(
                tema,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFF3B8992),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              body,
              style: kContentTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
