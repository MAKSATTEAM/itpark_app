import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class SpeakerCardB2B extends StatelessWidget {
  Widget image;
  String name;
  String firm;
  String post;
  String text;
  bool write;

  SpeakerCardB2B(
      {super.key, required this.image,
      required this.name,
      required this.firm,
      required this.post,
      required this.text,
      required this.write});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kDecorationBox,
      child: Stack(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: write
                  ? SvgPicture.asset("assets/icons/bbdone.svg")
                  : Container(),
            )
          ]),
          Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProfileAvatar(
                    '',
                    radius: 32,
                    backgroundColor: Colors.transparent,
                    child: image,
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 140,
                          child: Text(name, style: kContentTextStyle)),
                      SizedBox(height: 8),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: Text(firm,
                            style: const TextStyle(
                                color: Color(0xFF828282),
                                fontWeight: FontWeight.w300,
                                fontSize: 12)),
                      ),
                      SizedBox(height: 9),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: AutoSizeText(post,
                            style: const TextStyle(
                                color: Color(0xFF828282),
                                fontWeight: FontWeight.w300,
                                fontSize: 12)),
                      ),
                      SizedBox(height: 7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 200,
                        child: AutoSizeText(text,
                            style: const TextStyle(
                                color: Color(0xFF828282),
                                fontWeight: FontWeight.w400,
                                fontSize: 12)),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
