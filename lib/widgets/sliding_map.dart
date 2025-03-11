import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

final PanelController panelController = PanelController();

class SlidingMap extends StatefulWidget {
  const SlidingMap({super.key});

  @override
  State<SlidingMap> createState() => _SlidingMapState();
}

class _SlidingMapState extends State<SlidingMap> {
  String? name;
  String? opisanie;
  String? adress;
  String? site;
  String? tel;
  Color? color;

  @override
  Widget build(BuildContext context) {
    context.read<SlidingMapCubit>().stream.listen((state) {
      if (state is SlidingMapOpenState) {
        setState(() {
          name = state.name;
          opisanie = state.opisanie;
          adress = state.adress;
          site = state.site;
          tel = state.tel;
          color = state.color;
        });
        panelController.open();
      } else if (state is SlidingMapClosedState) {
        panelController.close();
      }
    });

    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.45,
      minHeight: 0,
      controller: panelController,
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      panel: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    SlidingMapCubit slidingMapCubit =
                        context.read<SlidingMapCubit>();
                    slidingMapCubit.hide();
                  },
                  icon: SvgPicture.asset("assets/icons/X.svg",
                      color: Color(0xFF828282))),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(name ?? "",
                        style: TextStyle(
                            color: color ?? Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                opisanie ?? "",
                                style: kSlidingMapBlack,
                              ),
                            ],
                          ),
                          SizedBox(height: 26),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                  "assets/icons/maplocationoutlined.svg",
                                  color: kIconColor),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  adress ?? "",
                                  style: kSlidingMapBlack,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          GestureDetector(
                            onTap: () {
                              UrlLauncher.launch(
                                  site ?? ConstantsClass.url);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/icons/globe.svg",
                                    color: kIconColor),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    site ?? "",
                                    style: kSlidingMapBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 14),
                          GestureDetector(
                            onTap: () {
                              UrlLauncher.launch("tel://$tel");
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset("assets/icons/mapphone.svg",
                                    color: kIconColor),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    tel ?? "",
                                    style: kSlidingMapBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
