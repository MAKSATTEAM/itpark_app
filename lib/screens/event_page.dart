import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/all/util.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/other/personal_sh.dart';
import 'package:eventssytem/screens/speaker_page_open.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/speaker_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventPage extends StatefulWidget {
  EventPage({super.key, required this.index});
  String index;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  late TabController _controller;
  late Animation<double> animation;
  late AnimationController controllerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
    controllerAnimation = AnimationController(
        vsync: this, duration: Duration(milliseconds: 950));
  }

  @override
  void dispose() {
    _controller.dispose();
    controllerAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<EventProgramByIdCubit>().fetchEvent(widget.index);
    print("disids ${widget.index}");
    List<Tab> topTabs = <Tab>[
      Tab(text: '${AppLocalizations.of(context)?.description}'),
      Tab(text: '${AppLocalizations.of(context)?.speakers}')
    ];
    bool trans = false;
    animation = Tween(begin: 0.0, end: 20.0).animate(controllerAnimation);

    controllerAnimation.repeat();

    Size textSize(String text, TextStyle style) {
      final TextPainter textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 6,
          textDirection: TextDirection.ltr)
        ..layout(minWidth: 0, maxWidth: MediaQuery.of(context).size.width - 32);
      return textPainter.size;
    }

    return BlocBuilder<EventProgramByIdCubit, EventProgramByIdState>(
        builder: ((context, state) {
      if (state is EventProgramByIdErrorState) {
        return Scaffold(
            body:
                Center(child: Text("${AppLocalizations.of(context)?.error}")));
      }
      if (state is EventProgramByIdLoadingState) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (state is EventProgramByIdLoadedState) {
        bool f = Personalschedule.check(state.loaded.id, context);
        bool nn = state.loaded.subscribe;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Background().background2),
                fit: BoxFit.fill,
              ),
            )),
            automaticallyImplyLeading: false,
            backgroundColor: kBacColor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(textSize(
                          "${(ConstantsClass.locale == "en" ? state.loaded.nameEng : state.loaded.nameRus) ?? ""}",
                          TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.black))
                      .height +
                  40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child:
                                    SvgPicture.asset("assets/icons/left.svg")),
                          ],
                        )),
                        Expanded(
                          flex: 3,
                          child: AutoSizeText(
                            "${(ConstantsClass.locale == "en" ? state.loaded.nameEng : state.loaded.nameRus) ?? ""}",
                            maxLines: 6,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (f == true) {
                                  context
                                      .read<PersonalscheduleCubit>()
                                      .del(state.loaded.id);
                                }
                                if (f == false) {
                                  context
                                      .read<PersonalscheduleCubit>()
                                      .add(state.loaded.id);
                                }
                                context
                                    .read<PersonalscheduleCubit>()
                                    .stream
                                    .listen((state) {
                                  if (state is PersonalscheduleLoadedState) {
                                    setState(() {});
                                    print(
                                        "state====dasdddddddddddddddddddddddddddd");
                                  }
                                });
                              },
                              child: Container(
                                child: BlocBuilder<PersonalscheduleCubit,
                                        PersonalscheduleState>(
                                    builder: (context, stated) {
                                  if (stated is PersonalscheduleLoadingState) {
                                    return SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    );
                                  }

                                  f = Personalschedule.check(
                                      state.loaded.id, context);

                                  return f
                                      ? SvgPicture.asset(
                                          "assets/icons/favouritesplus.svg")
                                      : SvgPicture.asset(
                                          "assets/icons/favouritesminus.svg");
                                }),
                              ),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                  TabBar(
                    indicatorColor: kTextGreenColor,
                    unselectedLabelColor: kTextGreyColor,
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.w400),
                    labelColor: kTextGreenColor,
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    controller: _controller,
                    tabs: topTabs,
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 24, bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/calendar.svg",
                              color: kIconColor),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  Util.getFormattedDate(state.loaded.dateTimeStart),
                                  style: kContentTextStyle),
                              SizedBox(height: 2),
                              Text(
                                  "${Util.getFormattedDateInHours(state.loaded.dateTimeStart)}-${Util.getFormattedDateInHours(state.loaded.dateTimeFinish)}",
                                  style: kContentTextStyle.copyWith(
                                      color: Color(0xFF828282)))
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SvgPicture.asset("assets/icons/notifplus.svg",
                              color: kIconColor),
                          SizedBox(width: 20),
                          Text("${AppLocalizations.of(context)?.notifym}",
                              style: kContentTextStyle),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BlocBuilder<PersonalscheduleCubit,
                                        PersonalscheduleState>(
                                    builder: (context, dsadsa) {
                                  if (dsadsa is PersonalscheduleLoadingState) {
                                    return SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      ),
                                    );
                                  }

                                  f = Personalschedule.check(
                                      state.loaded.id, context);

                                  return Switch(
                                      activeColor: kButtonColor,
                                      value: f,
                                      onChanged: (bool value) {
                                        if (f == true) {
                                          context
                                              .read<PersonalscheduleCubit>()
                                              .del(state.loaded.id);
                                        }

                                        if (f == false) {
                                          context
                                              .read<PersonalscheduleCubit>()
                                              .add(state.loaded.id);
                                        }

                                        print("ffff - $nn");
                                      });
                                })
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/location.svg",
                              color: kIconColor),
                          SizedBox(width: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 110,
                            child: Text(
                                ConstantsClass.locale == "en"
                                    ? "${state.loaded.placeEng}"
                                    : "${state.loaded.placeRus}",
                                style: kContentTextStyle),
                          ),
                        ],
                      ),
                      state.loaded.streamUrl == null
                          ? Container()
                          : Column(
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  // // children: [
                                  //   SvgPicture.asset("assets/icons/zoom.svg",
                                  //       color: kIconColor),
                                  //   SizedBox(width: 20),
                                  //   GestureDetector(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) => VideoPage(
                                  //               url:
                                  //                   "${state.loaded.streamUrl}",
                                  //             ),
                                  //           ));

                                  //       UrlLauncher.launch(
                                  //           "${state.loaded.streamUrl}");
                                  //     },
                                  //     child: Container(
                                  //         padding: EdgeInsets.all(9),
                                  //         decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.all(
                                  //                 Radius.circular(9)),
                                  //             color: Color.fromARGB(255, 119, 134, 214)),
                                  //         child: Row(
                                  //           children: [
                                  //             Text(
                                  //                 "${AppLocalizations.of(context)?.watchbroadcast}",
                                  //                 style: kContentTextStyle
                                  //                     .copyWith(
                                  //                         color: Color(
                                  //                             0xFFFFFFFF))),
                                  //             SizedBox(width: 10),
                                  //             AnimatedBuilder(
                                  //               animation: controllerAnimation,
                                  //               builder: (context, child) {
                                  //                 return Transform.scale(
                                  //                   scale: controllerAnimation
                                  //                       .value,
                                  //                   child: SvgPicture.asset(
                                  //                       "assets/icons/trans.svg"),
                                  //                 );
                                  //               },
                                  //             ),
                                  //           ],
                                  //         )),
                                  //   ),
                                  // ],
                                ),
                              ],
                            ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/icons/alignleft.svg",
                              color: kIconColor),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 110,
                                child: AutoSizeText(
                                  ConstantsClass.locale == "en"
                                      ? "${state.loaded.descriptionEng}"
                                      : "${state.loaded.descriptionRus}",
                                  style: kContentTextStyle.copyWith(
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //! Вторая страница
              Container(
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 20),
                  child: ListView.builder(
                      itemCount: state.loaded.speakers.length,
                      itemBuilder: ((context, index) => Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SpeakerPageOpen(
                                        index2:
                                            "${state.loaded.speakers[index].id}",
                                      ),
                                    ));
                              },
                              child: SpeakerCard(
                                firm: ConstantsClass.locale == "en"
                                    ? "${state.loaded.speakers[index].companyEng}"
                                    : "${state.loaded.speakers[index].companyRus}",
                                image: state.loaded.speakers[index].photo ==
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
                                            "${ConstantsClass.url}${state.loaded.speakers[index].photo}",
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            SvgPicture.asset(
                                          "assets/icons/noimg.svg",
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                name: ConstantsClass.locale == "en"
                                    ? "${state.loaded.speakers[index].firstNameEng}"
                                    : "${state.loaded.speakers[index].firstNameRus}",
                                post: ConstantsClass.locale == "en"
                                    ? "${state.loaded.speakers[index].positionEng}"
                                    : "${state.loaded.speakers[index].positionRus}",
                              ),
                            ),
                          )))),
            ],
          ),
        );
      }

      return Scaffold(
        body: Text("error"),
      );
    }));
  }
}
