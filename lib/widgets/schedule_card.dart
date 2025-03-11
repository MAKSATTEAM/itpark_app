import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/personal_sh.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScheduleCard extends StatefulWidget {
  int id;
  String time;
  String title;
  String zal;
  bool trans;
  bool favourites;

  ScheduleCard(
      {super.key, required this.id,
      required this.time,
      required this.title,
      required this.zal,
      required this.trans,
      required this.favourites});

  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  @override
  Widget build(BuildContext context) {
    context.read<PersonalscheduleCubit>().stream.listen((state) {
      if (state is PersonalscheduleLoadedState) {
        setState(() {});
        print("state====dasdddddddddddddddddddddddddddd");
      }
    });
    bool f = Personalschedule.check(widget.id, context);
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
      decoration: kDecorationBox,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (f == true) {
                context.read<PersonalscheduleCubit>().del(widget.id);
              }
              if (f == false) {
                context.read<PersonalscheduleCubit>().add(widget.id);
              }
            },
            child: Container(
                padding: EdgeInsets.only(right: 15),
                alignment: Alignment.topRight,
                child:
                    BlocBuilder<PersonalscheduleCubit, PersonalscheduleState>(
                        builder: (context, state) {
                  print("state==$state");
                  if (state is PersonalscheduleLoadingState) {
                    print("state==Кручу");
                    return CircularProgressIndicator(
                      color: kPrimaryColor,
                    );
                  }

                  return f
                      ? SvgPicture.asset("assets/icons/favouritesplus.svg")
                      : SvgPicture.asset("assets/icons/favouritesminus.svg");
                })),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.time,
                  style: TextStyle(
                      color: kTextGreenColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/icons/location.svg",
                        color: kTextGreenColor),
                    SizedBox(width: 9),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text(
                        widget.zal,
                        style: TextStyle(
                            color: kTextGreenColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                widget.trans
                    ? Container(
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // children: [
                              //   SvgPicture.asset("assets/icons/zoom.svg",
                              //       color: kTextGreenColor),
                              //   SizedBox(width: 9),
                              //   Text(
                              //     "${AppLocalizations.of(context)?.livestream}",
                              //     style: TextStyle(
                              //         color: kTextGreenColor,
                              //         fontWeight: FontWeight.w400,
                              //         fontSize: 16),
                              //   ),
                              // ],
                            ),
                          ],
                        ),
                      )
                    : Container()
              ],
            ),
          )
        ],
      ),
    );
  }
}
