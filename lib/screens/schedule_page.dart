import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/cubit/all/util.dart';
import 'package:eventssytem/other/filter_sh.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/other/personal_sh.dart';
import 'package:eventssytem/screens/event_page.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/schedule_card.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:eventssytem/widgets/search_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  late TabController _controller;
  late TabController _controller2;
  List<Widget>? cardTab1;
  List<Widget>? cardTab2;
  List<Widget>? cardTab3;
  final List<Tab> topTabs = <Tab>[
    Tab(text: '13/11'),
    Tab(text: '14/11'),
    Tab(text: '15/11'),
  ];

  @override
  void initState() {
    _controller2 = TabController(length: 2, vsync: this);
    _controller = TabController(length: 3, vsync: this);

    context
        .read<EventProgramCubit>()
        .fetchCard(eventTypeIds: [1], eventDateIds: [14]);
    super.initState();
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    update() {
      List<int> eventTypeIds = [_controller2.index + 1];
      List<int> eventDateIds;
      switch (_controller.index) {
        case 0:
          eventDateIds = [13];
          break;
        case 1:
          eventDateIds = [14];
          break;
        case 2:
          eventDateIds = [15];
          break;
        default:
          eventDateIds = [13];
      }

      List<int>? sphereIds;
      List<int>? eventFormat;

      if (FliterInits.listItemsSpheres.isNotEmpty ||
          FliterInits.listItemsSpheres != null) {
        sphereIds =
            FliterInits.listItemsSpheres.map<int>((e) => e.id ?? 0).toList();
      }

      if (FliterInits.listItemsEventFormats.isNotEmpty ||
          FliterInits.listItemsEventFormats != null) {
        eventFormat = FliterInits.listItemsEventFormats
            .map<int>((e) => e.id ?? 0)
            .toList();
      }

      context.read<EventProgramCubit>().fetchCard(
          eventTypeIds: eventTypeIds,
          eventDateIds: eventDateIds,
          sphereIds: sphereIds,
          eventFormat: eventFormat);
    }

    _controller2.addListener(() {
      update();
    });

    _controller.addListener(() {
      update();
    });

    context.read<FilterCubit>().stream.listen((state) {
      if (state is FilterClosedState) {
        update();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBacColor,
        leading: SearchIcon(),
        actions: [
          BlocBuilder<PersonalscheduleCubit, PersonalscheduleState>(
              builder: (context, stateing) {
            if (stateing is PersonalscheduleLoadedState) {
              return badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 0, end: 3),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: kPrimaryColor,
                  ),
                  badgeContent: Text(
                    "${Personalschedule.psList?.length}",
                    style: TextStyle(color: Colors.white),
                  ),
                child: BlocBuilder<CheckPSHtream, bool>(
                    builder: (context, select) {
                  return IconButton(
                    iconSize: 40,
                    onPressed: () {
                      context.read<CheckPSHtream>().select(!select);
                    },
                    icon: select
                        ? SvgPicture.asset("assets/icons/ftrue.svg")
                        : SvgPicture.asset("assets/icons/favourites.svg"),
                  );
                }),
              );
            }
            return Container();
          }),
          BlocBuilder<FilterShCountController, int>(builder: (context, count) {
            return BlocBuilder<Checklivestream, bool>(
                builder: (context, select) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: kPrimaryColor,
                ),
                badgeContent: Text(
                  (count + (select == true ? 1 : 0)).toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                    iconSize: 40,
                    onPressed: () {
                      FilterCubit filterCubit = context.read<FilterCubit>();
                      filterCubit.open();
                    },
                    icon: SvgPicture.asset("assets/icons/filter.svg")),
              );
            });
          })
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              BlocBuilder<EventProgramCategoryCubit, EventProgramCategoryState>(
                  builder: (context, state) {
                if (state is EventProgramCategoryLoadedState) {
                  return DefaultTabController(
                      length: state.loaded.length,
                      child: BlocBuilder<TabShVerhController, int>(
                          builder: (context, select) {
                        _controller2.animateTo(select);

                        return ButtonsTabBar(
                          controller: _controller2,
                          backgroundColor: kButtonColor,
                          unselectedBackgroundColor: kUnSelectProgramColor,
                          labelStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          radius: 9,
                          tabs: List<Tab>.generate(
                              state.loaded.length,
                              (index) => Tab(
                                  text: ConstantsClass.locale == "en"
                                      ? state.loaded[index].nameEng
                                      : state.loaded[index].nameRus)),
                        );
                      }));
                }
                return Center(
                    child: Text("${AppLocalizations.of(context)?.error}"));
              }),
              TabBar(
                indicatorColor: kTextGreenColor,
                unselectedLabelColor: kTextGreyColor,
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                labelColor: kTextGreenColor,
                labelStyle: TextStyle(fontWeight: FontWeight.w700),
                controller: _controller,
                tabs: topTabs,
              ),
            ],
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Background().background),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<PayedCubit, PayedState>(builder: (context, state) {
            if (state is PayedLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PayedBadState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("${AppLocalizations.of(context)?.netpay}"))
                ],
              );
            }

            if (state is PayedGoodState) {
              return TabBarView(controller: _controller, children: [
                Card(),
                Card(),
                Card(),
              //  Card(),
              ]);
            }
            return Center(
                child: Text("${AppLocalizations.of(context)?.error}"));
          })),
    );
  }

  Widget Card() {
    return BlocBuilder<EventProgramCubit, EventProgramState>(
        builder: ((context, state) {
      if (state is CardErrorState) {
        return Center(
          child: Text("Здесь скоро будет программа"),
        );
      }
      if (state is CardLoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is CardLoadedState) {
        return BlocBuilder<Checklivestream, bool>(builder: (context, select) {
          return BlocBuilder<CheckPSHtream, bool>(
              builder: (context, truefalse) {
            return ListView.builder(
                itemCount: state.loadedCard?.length,
                itemBuilder: ((context, index) {
                  if (select == true &&
                      state.loadedCard![index].streamUrl == null) {
                    return Container();
                  }

                  if (truefalse == true &&
                      Personalschedule.check(
                              state.loadedCard![index].id, context) ==
                          false) {
                    return Container();
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventPage(
                              index: "${state.loadedCard?[index].id}",
                            ),
                          ));
                    },
                    child: ScheduleCard(
                      id: state.loadedCard?[index].id,
                      time:
                          "${Util.getFormattedDateInHours(state.loadedCard?[index].dateTimeStart)}-${Util.getFormattedDateInHours(state.loadedCard?[index].dateTimeFinish)}",
                      title: ConstantsClass.locale == 'en'
                          ? "${state.loadedCard?[index].nameEng}"
                          : "${state.loadedCard?[index].nameRus}",
                      zal: ConstantsClass.locale == 'en'
                          ? "${state.loadedCard?[index].placeEng}"
                          : "${state.loadedCard?[index].placeRus}",
                      trans: state.loadedCard![index].streamUrl == null
                          ? false
                          : true,
                      favourites: false,
                    ),
                  );
                }));
          });
        });
      }
      return Text("");
    }));
  }
}
