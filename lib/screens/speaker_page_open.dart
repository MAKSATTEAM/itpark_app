import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/all/util.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/screens/event_page.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/schedule_card.dart';

class DatePole {
  String date;
  String one;
  String two;
  DatePole({required this.date, required this.one, required this.two});
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: kBacColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class SpeakerPageOpen extends StatefulWidget {
  String index2;
  SpeakerPageOpen({super.key, required this.index2});

  @override
  State<SpeakerPageOpen> createState() => _SpeakerPageOpenState();
}

class _SpeakerPageOpenState extends State<SpeakerPageOpen> {
  String count = "-1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 2,
            child: BlocBuilder<SpeakersCubit, SpeakersState>(
              builder: (context, state) {
                if (state is CardErrorState3) {
                  return Center(
                    child: Text("Ошибка"),
                  );
                }
                if (state is CardLoadingState3) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CardLoadedState3) {
                  int indexglobal = 0;

                  for (var i = 0; i < state.loadedCard3!.length; i++) {
                    if (state.loadedCard3![i].id.toString().trim() ==
                        widget.index2.trim()) {
                      indexglobal = i;
                      break;
                    }
                  }

                  if (count == "-1") {
                    if (state.loadedCard3![indexglobal].eventProgram.length !=
                        0) {
                      count = state
                          .loadedCard3![indexglobal].eventProgram.length
                          .toString();
                    } else {
                      count = "0";
                    }
                  }

                  List<Tab> topTabs = <Tab>[
                    Tab(text: '${AppLocalizations.of(context)?.information}'),
                    Tab(
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: kPrimaryColor,
                          elevation: 4,
                        ),
                        position: badges.BadgePosition.topEnd(top: -12, end: -18),
                        badgeContent: Text(
                          count,
                          style: TextStyle(color: Colors.white),
                        ),
                        child: Text("${AppLocalizations.of(context)?.reports}"),
                      ),
                    ),
                  ];

                  List<dynamic> only = [];
                  List<DatePole> dates = [];
                  List<String> dates2 = [];
                  String languageCode =
                      ConstantsClass.locale == 'en' ? 'en_US' : 'ru';

                  for (var i = 0;
                      i < state.loadedCard3?[indexglobal].eventProgram.length;
                      i++) {
                    if (!dates2.contains(DateFormat('yyyy-MM-dd').format(state
                        .loadedCard3?[indexglobal]
                        .eventProgram[i]
                        .dateTimeStart))) {
                      dates2.add(DateFormat('yyyy-MM-dd').format(state
                          .loadedCard3?[indexglobal]
                          .eventProgram[i]
                          .dateTimeStart));

                      dates.add(DatePole(
                          date: DateFormat('yyyy-MM-dd').format(state
                              .loadedCard3?[indexglobal]
                              .eventProgram[i]
                              .dateTimeStart),
                          one: DateFormat('d MMM', languageCode).format(state
                              .loadedCard3?[indexglobal]
                              .eventProgram[i]
                              .dateTimeStart),
                          two: DateFormat('E', languageCode).format(state
                              .loadedCard3?[indexglobal]
                              .eventProgram[i]
                              .dateTimeStart)));
                    }
                  }

                  dates.sort((a, b) {
                    //sorting in ascending order
                    return DateTime.parse(a.date)
                        .compareTo(DateTime.parse(b.date));
                  });

                  state.loadedCard3?[indexglobal].eventProgram.sort((a, b) {
                    return DateTime.parse(a.dateTimeStart.toString())
                        .compareTo(DateTime.parse(b.dateTimeStart.toString()));
                  });

                  //      dates.sort((a, b) => a.hashCode.compareTo(b.hashCode));

                  for (var i1 = 0; i1 < dates.length; i1++) {
                    only.add(dates[i1]);
                    for (var i = 0;
                        i < state.loadedCard3?[indexglobal].eventProgram.length;
                        i++) {
                      if (DateFormat('yyyy-MM-dd').format(state
                              .loadedCard3?[indexglobal]
                              .eventProgram[i]
                              .dateTimeStart) ==
                          dates[i1].date) {
                        only.add(
                            state.loadedCard3?[indexglobal].eventProgram[i]);
                      }
                    }
                  }

                  Widget widgetik() {
                    return ListView.builder(
                        padding: EdgeInsets.only(top: 0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: only.length,
                        itemBuilder: (context, index) {
                          if (only[index] is EventProgram) {
                            return Column(
                              children: [
                                SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EventPage(
                                            index: "${only[index].id}",
                                          ),
                                        ));
                                  },
                                  child: ScheduleCard(
                                      id: only[index].id,
                                      time: "${Util.getFormattedDateInHours(
                                              only[index].dateTimeStart)} - ${Util.getFormattedDateInHours(
                                              only[index].dateTimeFinish)}",
                                      title: ConstantsClass.locale == 'en'
                                          ? "${only[index].nameEng}"
                                          : "${only[index].nameRus}",
                                      zal: ConstantsClass.locale == 'en'
                                          ? "${only[index].placeEng}"
                                          : "${only[index].placeRus}",
                                      trans: only[index].streamUrl != null
                                          ? true
                                          : false,
                                      favourites: false),
                                ),
                                SizedBox(height: 8),
                              ],
                            );
                          } else {
                            return line(only[index].one.toUpperCase(),
                                only[index].two.toUpperCase());
                          }
                        });
                  }

                  return NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          elevation: 0,
                          iconTheme: IconThemeData(color: kIconColor),
                          backgroundColor: Colors.white,
                          pinned: true,
                          snap: true,
                          floating: true,
                          expandedHeight: 190.0,
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Background().background2),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: FlexibleSpaceBar(
                              centerTitle: true,
                              title: Text(
                                  ConstantsClass.locale == "en"
                                      ? "${state.loadedCard3?[indexglobal].firstNameEng} ${state.loadedCard3?[indexglobal].lastNameEng}"
                                      : "${state.loadedCard3?[indexglobal].firstNameRus} ${state.loadedCard3?[indexglobal].lastNameRus}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                  textAlign: TextAlign.center),
                              background: Padding(
                                padding: EdgeInsets.only(bottom: 30.0),
                                child: SafeArea(
                                  child: CircularProfileAvatar(
                                    '',
                                    borderColor: Colors.transparent,
                                    radius: 65,
                                    child: state.loadedCard3?[indexglobal]
                                                .photo ==
                                            null
                                        ? SvgPicture.asset(
                                            "assets/icons/noimg.svg",
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            color: kPrimaryColor,
                                          )
                                        : CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            imageUrl:
                                                "${ConstantsClass.url}${state.loadedCard3?[indexglobal].photo}",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget:
                                                (context, url, error) =>
                                                    SvgPicture.asset(
                                              "assets/icons/noimg.svg",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              indicatorColor: kTextGreenColor,
                              unselectedLabelColor: kTextGreyColor,
                              unselectedLabelStyle:
                                  TextStyle(fontWeight: FontWeight.w400),
                              labelColor: kTextGreenColor,
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.w700),
                              tabs: topTabs,
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: 16),
                                  Container(),
                                  // RichText(
                                  //     text: TextSpan(children: [
                                  //   TextSpan(
                                  //     text:
                                  //         "${AppLocalizations.of(context)?.jobtitle}:",
                                  //     style: kSpeckerTextStyle,
                                  //   ),
                                  //   TextSpan(text: '  '),
                                  //   TextSpan(
                                  //     text: ConstantsClass.locale == "en"
                                  //         ? "${state.loadedCard3?[indexglobal].positionEng}"
                                  //         : "${state.loadedCard3?[indexglobal].positionRus}",
                                  //     style: kContentTextStyle,
                                  //   ),
                                  // ])),

                                  // SizedBox(height: 16),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text:
                                          "${AppLocalizations.of(context)?.organization}:",
                                      style: kSpeckerTextStyle,
                                    ),
                                    TextSpan(text: '  '),
                                    TextSpan(
                                      text: ConstantsClass.locale == "en"
                                          ? "${state.loadedCard3?[indexglobal].companyEng}"
                                          : "${state.loadedCard3?[indexglobal].companyRus}",
                                      style: kContentTextStyle,
                                    )
                                  ])),
                                  SizedBox(height: 16),
                                  // Row(
                                  //   crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       "${AppLocalizations.of(context)?.description}:",
                                  //       style: kSpeckerTextStyle,
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(height: 8),
                                  // Row(
                                  //   children: [
                                  //     Container(
                                  //       width: MediaQuery.of(context).size.width -
                                  //           32,
                                  //       child: Text(
                                  //         "МенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджерМенеджер",
                                  //         style: kContentTextStyle,
                                  //       ),
                                  //     )
                                  //   ],
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Container(
                              child: Column(
                                children: [SizedBox(height: 10), widgetik()],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Text("");
              },
            )));
  }
}

Widget line(String date1, date2) {
  return Container(
    color: Color(0xFFE2EAEB),
    padding: EdgeInsets.only(top: 5, bottom: 5, left: 16, right: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          date1,
          style: kContentTextStyle.copyWith(color: Color(0xFF3B8992)),
        ),
        SizedBox(width: 3),
        Text(
          date2,
          style: kContentTextStyle.copyWith(
              fontSize: 12, color: Color(0xFF828282)),
        )
      ],
    ),
  );
}
