import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventssytem/utils/constants.dart';

class TransportCard extends StatelessWidget {
  String timestart;
  String timestop;
  String one;
  String two;
  bool like;
  String id;

  TransportCard({super.key, 
    required this.id,
    required this.timestart,
    required this.timestop,
    required this.one,
    required this.two,
    required this.like,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: kDecorationBox,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 9, right: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder<Box>(
                      valueListenable: Hive.box<String>('favoriteTransportList')
                          .listenable(),
                      builder: (context, box, widget) {
                        bool rrr =
                            box.values.toList().cast<String>().contains(id);
                        print(rrr);

                        return rrr
                            ? GestureDetector(
                                onTap: () async {
                                  var box = Hive.box<String>(
                                      "favoriteTransportList");

                                  for (var i = 0;
                                      i <
                                          box.values
                                              .toList()
                                              .cast<String>()
                                              .length;
                                      i++) {
                                    if (box.values.toList().cast<String>()[i] ==
                                        id) {
                                      box.deleteAt(i);
                                      break;
                                    }
                                  }
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/heartplus.svg"))
                            : GestureDetector(
                                onTap: () async {
                                  var box = Hive.box<String>(
                                      "favoriteTransportList");
                                  box.add(id);
                                },
                                child: SvgPicture.asset(
                                    "assets/icons/heartminus.svg"));
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        timestart,
                        style: kTransporgGreyTextStyle,
                      ),
                      SizedBox(height: 20),
                      Text(
                        timestop,
                        style: kTransporgGreyTextStyle,
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SvgPicture.asset("assets/icons/linetrans.svg")],
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: AutoSizeText(
                          one,
                          style: kContentTextStyle,
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: AutoSizeText(
                          two,
                          style: kContentTextStyle,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
