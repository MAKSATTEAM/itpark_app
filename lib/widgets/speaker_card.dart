import 'package:flutter/material.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class SpeakerCard extends StatelessWidget {
  Widget image;
  String name;
  String firm;
  String post;

  SpeakerCard(
      {super.key, required this.image,
      required this.name,
      required this.firm,
      required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kDecorationBox,
      child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  // SizedBox(height: 5),
                  // Container(
                  //   width: MediaQuery.of(context).size.width - 200,
                  //   child: AutoSizeText("$post",
                  //       style: const TextStyle(
                  //           color: Color(0xFF828282),
                  //           fontWeight: FontWeight.w300,
                  //           fontSize: 12)),
                  // ),
                ],
              )
            ],
          )),
    );
  }
}
