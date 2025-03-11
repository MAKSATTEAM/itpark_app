import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/all/util.dart';
import 'package:eventssytem/other/transport_list.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/dropdown_input_tr.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/transport_card.dart';

class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  _TransportPageState createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  List<String> fromlist = [];
  List<String> tolist = [];

  String? selectetfrom;
  String? selectetto;

  final List<Tab> topTabs = <Tab>[
    Tab(text: '13/11'),
    Tab(text: '14/11'),
    Tab(text: '15/11')
  ];

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    context.read<TransportCubit>().feth();
    context.read<TransportCubit>().stream.listen((state) {
      if (state is TransportLoadedState) {
        context.read<TransportTwoCubit>().feth();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {
      context.read<TransportTwoCubit>().feth();
    });

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Background().background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: kIconColor),
          elevation: 0,
          centerTitle: true,
          title: Text("${AppLocalizations.of(context)?.transport}",
              style: kAppBarTextStyle),
          actions: [
            badges.Badge(
              badgeStyle: badges.BadgeStyle(
                badgeColor: kPrimaryColor,
                elevation: 4,
              ),
              position: badges.BadgePosition.topEnd(top: 0, end: 3),
              badgeContent: ValueListenableBuilder<Box>(
                valueListenable:
                    Hive.box<String>('favoriteTransportList').listenable(),
                builder: (context, box, widget) {
                  return Text(
                    box.values.toList().cast<String>().length.toString(),
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
              child: BlocBuilder<CheckTr, bool>(builder: (context, select) {
                return IconButton(
                    iconSize: 40,
                    onPressed: () {
                      context.read<CheckTr>().select(!select);
                    },
                    icon: select
                        ? SvgPicture.asset("assets/icons/trfl.svg")
                        : SvgPicture.asset("assets/icons/likes.svg"));
              }),
            ),
            NotificationIcon()
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: kDecorationBox,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<TransportCubit, TransportState>(
                          builder: ((context, state) {
                        print("state $state");
                        if (state is TransportLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is TransportLoadedState) {
                          fromlist = state.loaded
                              .map<String>((e) =>
                                  e.facilityHotelShowPlaceFrom.name.toString())
                              .toSet()
                              .toList();
                          tolist = state.loaded
                              .map<String>((e) =>
                                  e.facilityHotelShowPlaceTo.name.toString())
                              .toSet()
                              .toList();

                          return Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/ellipse.svg"),
                                      SizedBox(width: 10),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                          child: Form(
                                              onChanged: () {
                                                print("dddd");
                                                context
                                                    .read<TransportTwoCubit>()
                                                    .feth();
                                              },
                                              child: DropdownInputTr(
                                                  fromto: true,
                                                  text:
                                                      "${AppLocalizations.of(context)?.from}",
                                                  list: fromlist,
                                                  selectedvalue:
                                                      selectetfrom))),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/ellipse.svg",
                                        color: Color(0xFFF8AC1A),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                140,
                                        child: Form(
                                            onChanged: () {
                                              context
                                                  .read<TransportTwoCubit>()
                                                  .feth();
                                            },
                                            child: DropdownInputTr(
                                                fromto: false,
                                                text:
                                                    "${AppLocalizations.of(context)?.to}",
                                                list: tolist,
                                                selectedvalue: selectetto)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(width: 4),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("clear");
                                      TransportList.listik = [];
                                      TransportList.selectedform = "";
                                      TransportList.selectedto = "";

                                      context.read<TransportCubit>().feth();
                                      context
                                          .read<TransportCubit>()
                                          .stream
                                          .listen((state) {
                                        if (state is TransportLoadedState) {
                                          context
                                              .read<TransportTwoCubit>()
                                              .feth();
                                        }
                                      });

                                      // setState(() {
                                      //   selectetfrom = null;
                                      //   selectetto = null;
                                      // });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: kIconColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: IconButton(
                                          color: kIconColor,
                                          onPressed: () {
                                            print("clear");
                                            TransportList.listik = [];
                                            TransportList.selectedform = "";
                                            TransportList.selectedto = "";

                                            context
                                                .read<TransportCubit>()
                                                .feth();
                                            context
                                                .read<TransportCubit>()
                                                .stream
                                                .listen((state) {
                                              if (state
                                                  is TransportLoadedState) {
                                                context
                                                    .read<TransportTwoCubit>()
                                                    .feth();
                                              }
                                            });

                                            // setState(() {
                                            //   selectetfrom = "";
                                            //   selectetto = "";
                                            // });
                                          },
                                          icon: SvgPicture.asset(
                                            "assets/icons/X.svg",
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                        return Center(
                            child:
                                Text("${AppLocalizations.of(context)?.error}"));
                      })),
                      SizedBox(width: 12),
                    ],
                  )),
            ),
            TabBar(
              indicatorColor: kTextGreenColor,
              unselectedLabelColor: kTextGreyColor,
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
              labelColor: kTextGreenColor,
              labelStyle: TextStyle(fontWeight: FontWeight.w700),
              controller: _controller,
              tabs: topTabs,
            ),
            SizedBox(height: 12),
            Expanded(
              child: TabBarView(controller: _controller, children: [
                Card(),
                Card(),
                Card(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget Card() {
    return BlocBuilder<TransportTwoCubit, TransportTwoState>(
        builder: ((context, state) {
      if (state is TransportTwoErrorState) {
        return Center(child: Text("${AppLocalizations.of(context)?.error}"));
      }
      if (state is TransportTwoLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is TransportTwoLoadedState) {
        print("dddddddddddddddd");

        return BlocBuilder<CheckTr, bool>(builder: (context, select) {
          return ValueListenableBuilder<Box>(
              valueListenable:
                  Hive.box<String>('favoriteTransportList').listenable(),
              builder: (context, box, widget) {
                state.loaded?.sort((a, b) {
                  return DateTime.parse(a.dateTimeDeparture.toString())
                      .compareTo(
                          DateTime.parse(b.dateTimeDeparture.toString()));
                });

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.loaded?.length,
                    itemBuilder: ((context, index) {
                      String date = "";

                      if (_controller.index == 0) {
                        date = '13';
                      }
                      if (_controller.index == 1) {
                        date = '14';
                      }
                      if (_controller.index == 2) {
                        date = '15';
                      }

                      if (Util.getFormattedDay(
                              state.loaded[index].dateTimeDeparture) !=
                          date) {
                        return Container();
                      }

                      print("ssss1=${state.from}");
                      print(
                          "ssss2=${state.loaded[index].facilityHotelShowPlaceFrom.name}");

                      print("ssss3=${state.to}");
                      print(
                          "ssss4=${state.loaded[index].facilityHotelShowPlaceTo.name}");

                      if (TransportList.selectedform != "" &&
                          TransportList.selectedto != "") {
                        if (TransportList.selectedform.hashCode !=
                                state.loaded[index].facilityHotelShowPlaceFrom
                                    .name.hashCode ||
                            TransportList.selectedto.hashCode !=
                                state.loaded[index].facilityHotelShowPlaceTo
                                    .name.hashCode) {
                          return Container();
                        }
                      }

                      if (select == true) {
                        var box = Hive.box<String>("favoriteTransportList");
                        bool kk = false;
                        for (var i = 0;
                            i < box.values.toList().cast<String>().length;
                            i++) {
                          if (box.values.toList().cast<String>()[i] ==
                              state.loaded[index].id.toString()) {
                            kk = true;
                            break;
                          }
                        }
                        if (!kk) {
                          return Container();
                        }
                      }

                      return Column(
                        children: [
                          SizedBox(height: 4),
                          TransportCard(
                              id: state.loaded[index].id.toString(),
                              timestart:
                                  Util.getFormattedDateInHours(state.loaded[index].dateTimeDeparture),
                              timestop:
                                  Util.getFormattedDateInHours(state.loaded[index].dateTimeArrival),
                              one: state.loaded[index]
                                  .facilityHotelShowPlaceFrom.name,
                              two: state
                                  .loaded[index].facilityHotelShowPlaceTo.name,
                              like: false),
                          SizedBox(height: 4),
                        ],
                      );
                    }));
              });
        });
      }
      return Center(child: Text("${AppLocalizations.of(context)?.error}"));
    }));
  }
}
