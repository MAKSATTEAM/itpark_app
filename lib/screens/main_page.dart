import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/screens/event_page.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/main_event_category_widget.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/player.dart';
import 'package:eventssytem/widgets/search_icon.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // SvgPicture.asset(
                  //   "assets/images/whitebg.svg",
                  //   fit: BoxFit.fitWidth,
                  // ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SearchIcon(),
                            Container(
                              child: Row(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/settingsPage');
                                      },
                                      icon: SvgPicture.asset(
                                          "assets/icons/settings.svg")),
                                  NotificationIcon(),
                                ],
                              ),
                            )
                          ],
                        ),
                        Center(
                          child: SvgPicture.asset(
                            "assets/images/logoen.svg",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(children: [
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //       onPressed: () {
                  //         UrlLauncher.launch(
                  //             "${ConstantsClass.url}/registration/${ConstantsClass.staticEventId}");

                  //         //   Navigator.pushNamed(context, '/evantputpage');
                  //       },
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(14.0),
                  //         child: Text(
                  //           "${AppLocalizations.of(context)?.applynow}",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       )),
                  // ),
                  // SizedBox(height: 16),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "${AppLocalizations.of(context)?.eventprogram}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<EventProgramCategoryCubit,
                      EventProgramCategoryState>(builder: (context, state) {
                    if (state is EventProgramCategoryLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is EventProgramCategoryErrorState) {
                      return Center(
                          child:
                              Text("${AppLocalizations.of(context)?.error}"));
                    }
                    if (state is EventProgramCategoryLoadedState) {
                      return SizedBox(
                        height: 94,
                        width: MediaQuery.of(context).size.width - 30,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.loaded.length,
                                    itemBuilder: (context, index) {
                                      Widget iconc;

                                      switch (state.loaded[index].nameEng) {
                                        case "Business":
                                          iconc = SvgPicture.asset(
                                              "assets/icons/business.svg");
                                          break;
                                        case "Culture":
                                          iconc = SvgPicture.asset(
                                              "assets/icons/cultural.svg");
                                          break;
                                        case "Exhibition":
                                          iconc = SvgPicture.asset(
                                              "assets/icons/exhibition.svg");
                                          break;
                                        default:
                                          iconc = SvgPicture.asset(
                                              "assets/icons/briefcase.svg");
                                      }

                                      return Row(
                                        children: [
                                          MainEventCategoryWidget(
                                              idgo: index,
                                              icon: iconc,
                                              text: ConstantsClass.locale ==
                                                      "en"
                                                  ? state.loaded[index].nameEng
                                                  : state
                                                      .loaded[index].nameRus),
                                          SizedBox(width: 5),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return Center(
                        child: Text("${AppLocalizations.of(context)?.error}"));
                  }),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "${AppLocalizations.of(context)?.livestream}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<BottomNavigationControllerSelect>()
                              .select(1);
                          context.read<Checklivestream>().select(true);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)?.learnmore}",
                                style: TextStyle(
                                    color: Color(0xFFBDBDBD),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset("assets/icons/right.svg")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<EventProgramLiveCubit, EventProgramLiveState>(
                      builder: (context, state) {
                    if (state is EventProgramLiveLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is EventProgramLiveErrorState) {
                      return Center(
                          child:
                              Text("${AppLocalizations.of(context)?.error}"));
                    }
                    if (state is EventProgramLiveLoadedState) {
                      return state.loaded.length != 0
                          ? SizedBox(
                              height: MediaQuery.of(context).size.width / 3.5,
                              width: MediaQuery.of(context).size.width - 32,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.loaded.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EventPage(
                                                  index:
                                                      "${state.loaded?[index].id}",
                                                ),
                                              ));
                                        },
                                        child: Row(children: [
                                          Player(
                                            zal: ConstantsClass.locale == 'en'
                                                ? "${state.loaded?[index].placeEng}"
                                                : "${state.loaded?[index].placeRus}",
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ]),
                                      );
                                    }),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context)?.livebroadcastsrightnow}",
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                    }
                    return Center(
                        child: Text("${AppLocalizations.of(context)?.error}"));
                  }),
                  SizedBox(height: 14),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/speakerpage');
                    },
                    child: Container(
                      decoration: kDecorationBox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.speakers}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "${AppLocalizations.of(context)?.informationaboutspeakers}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 8, bottom: 8),
                            child:
                                SvgPicture.asset("assets/icons/speakers.svg"),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/newspage');
                    },
                    child: Container(
                      decoration: kDecorationBox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.news}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "${AppLocalizations.of(context)?.actualnews}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 8, bottom: 8),
                            child: SvgPicture.asset("assets/icons/news.svg"),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/partnerspage');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "${AppLocalizations.of(context)?.partners}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)?.learnmore}",
                                style: TextStyle(
                                    color: Color(0xFFBDBDBD),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset("assets/icons/right.svg")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/partnerspage');
                    },
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: kDecorationBox.copyWith(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/partners/image2.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: kDecorationBox.copyWith(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/partners/image1.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: kDecorationBox.copyWith(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/partners/image3.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: kDecorationBox.copyWith(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/partners/image9.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: kDecorationBox.copyWith(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/partners/image8.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        )),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "${AppLocalizations.of(context)?.eventmap}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/map');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.asset(
                        "assets/images/map.png",
                        height: 160,
                        width: MediaQuery.of(context).size.width - 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/transportpage');
                    },
                    child: Container(
                      decoration: kDecorationBox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.transport}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "${AppLocalizations.of(context)?.transportschedule}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 8, bottom: 8),
                            child:
                                SvgPicture.asset("assets/icons/schedule.svg"),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/contactpage');
                    },
                    child: Container(
                      decoration: kDecorationBox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8, left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.contacts}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "${AppLocalizations.of(context)?.helpfulinformation}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, top: 8, bottom: 8),
                            child:
                                SvgPicture.asset("assets/icons/contacts.svg"),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
