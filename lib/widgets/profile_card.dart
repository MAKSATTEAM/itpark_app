import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileCard extends StatelessWidget {
  String status;
  String statusname;
  String title;
  String type;
  String name;
  String prof;
  String paket;
  bool buttonvisible;
  bool buttonred;

  ProfileCard({super.key, 
    required this.status,
    required this.statusname,
    required this.title,
    required this.type,
    required this.name,
    required this.prof,
    required this.paket,
    required this.buttonvisible,
    required this.buttonred,
  });

  @override
  Widget build(BuildContext context) {
    Color? textverhcolor;
    Color? panelverhcolor;
    String? paneltext;
    Color? buttoncolor;
    Color? buttontextcolor;

    if (buttonred == true) {
      buttoncolor = Color(0xFFB03A35);
      buttontextcolor = Color(0xFFFFFFFF);
    }

    if (buttonred == false) {
      buttoncolor = Color(0xFFEBECEC);
      buttontextcolor = Color(0xFF828282);
    }

    if (status == "Success") {
      textverhcolor = Color(0xFF3B8992);
      panelverhcolor = Color(0xFFE2EAEB);
      paneltext = statusname;
    }

    if (status == "Moderate") {
      textverhcolor = Color(0xFFF8AC1A);
      panelverhcolor = Color(0xFFFFF8E9);
      paneltext = statusname;
    }

    if (status == "Cancel") {
      textverhcolor = Color(0xFFB03A35);
      panelverhcolor = Color(0xFFFFF5F5);
      paneltext = statusname;
    }

    return Container(
      decoration: kDecorationBox,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: panelverhcolor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                width: MediaQuery.of(context).size.width - 24 - 24,
                padding: EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    "$paneltext",
                    style: TextStyle(
                        color: textverhcolor,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  title,
                  style: TextStyle(
                      color: Color(0xFF3B8992),
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  type,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                SizedBox(height: 1),
                Text(
                  prof,
                  style: TextStyle(
                      color: Color(0xFF828282),
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
          Divider(
            height: 7,
            //  color: Color(0xFFE2EAEB),
            color: Colors.black,
          ),
          // SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 17),
                  child: Text(
                    paket,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 2),
                  child: Visibility(
                    visible: buttonvisible,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: buttoncolor,
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 20, right: 20),
                          child: Text(
                            "${AppLocalizations.of(context)?.pay}",
                            style: TextStyle(color: buttontextcolor),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
          //  SizedBox(height: 10),
        ],
      ),
    );
  }
}
