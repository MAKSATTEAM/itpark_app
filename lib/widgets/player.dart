import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/utils/constants.dart';

class Player extends StatelessWidget {
  List photolist = [
    "assets/images/livefon1.png",
    "assets/images/livefon2.png",
    "assets/images/livefon3.png"
  ];

  String? zal;
  Player({super.key, this.zal});
  @override
  Widget build(BuildContext context) {
    int randomIndex = Random().nextInt(photolist.length);
    return Container(
      height: MediaQuery.of(context).size.width / 4,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: kDecorationBox.copyWith(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("${photolist[randomIndex]}"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
        ),
      ),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 5),
          child: Container(
            height: 26,
            width: 40,
            decoration: kDecorationBox.copyWith(
                color:
                    const Color.fromARGB(255, 202, 197, 197).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10)),
            child: const Center(
                child: Text(
              "Live",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
        Center(
          child: SvgPicture.asset(
            "assets/icons/player.svg",
            fit: BoxFit.scaleDown,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                zal ?? "",
                style: TextStyle(color: Colors.white),
              )),
        )
      ]),
    );
  }
}
