import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';

class MapInfoPage extends StatelessWidget {
  const MapInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            title: Text("${AppLocalizations.of(context)?.information}",
                style: kAppBarTextStyle),
          ),
          body:
              BlocBuilder<MapCubit, MapTochkiState>(builder: (context, state) {
            print(state);
            if (state is MapTochkiLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MapTochkiErrorState) {
              return Center(
                  child: Text("${AppLocalizations.of(context)?.error}"));
            }
            if (state is MapTochkiLoadedState) {
              return SingleChildScrollView(
                  child: Column(
                children: [
                  razvertka(
                      "${AppLocalizations.of(context)?.facilities}",
                      maplocationf,
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.facilities!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/map');

                                        context
                                            .read<MapVisibleCubit>()
                                            .fetchTochki(
                                                s: state.facilities![index],
                                                v: true);
                                      },
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          "assets/icons/maplocationoutlined.svg",
                                          color: maplocationf,
                                        ),
                                        SizedBox(width: 14),
                                        Text(state.facilities![index].name,
                                            style: kMapInfoBlack),
                                      ]),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }),
                        )
                      ],
                      context),
                  SizedBox(height: 12),
                  razvertka(
                      "${AppLocalizations.of(context)?.showplaces}",
                      maplocations,
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.showplaces!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/map');

                                        context
                                            .read<MapVisibleCubit>()
                                            .fetchTochki(
                                                s: state.showplaces![index],
                                                v: true);
                                      },
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          "assets/icons/maplocationoutlined.svg",
                                          color: maplocations,
                                        ),
                                        SizedBox(width: 14),
                                        Text(state.showplaces![index].name,
                                            style: kMapInfoBlack),
                                      ]),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }),
                        )
                      ],
                      context),
                  SizedBox(height: 12),
                  razvertka(
                      "${AppLocalizations.of(context)?.hotels}",
                      maplocationh,
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.hotels!.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context, '/map');

                                        context
                                            .read<MapVisibleCubit>()
                                            .fetchTochki(
                                                s: state.hotels![index],
                                                v: true);
                                      },
                                      child: Row(children: [
                                        SvgPicture.asset(
                                          "assets/icons/maplocationoutlined.svg",
                                          color: maplocationh,
                                        ),
                                        SizedBox(width: 14),
                                        Text(state.hotels![index].name,
                                            style: kMapInfoBlack),
                                      ]),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              }),
                        )
                      ],
                      context),
                ],
              ));
            }

            return Center(
                child: Text("${AppLocalizations.of(context)?.error}"));
          })),
    );
  }
}

Widget razvertka(
    String text, Color color, List<Widget> widgets, BuildContext context) {
  return ExpansionTile(
      textColor: Colors.black,
      collapsedTextColor: Colors.black,
      collapsedBackgroundColor: Color(0xFFE2EAEB),
      backgroundColor: Color(0xFFE2EAEB),
      title: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/maplocation.svg",
            color: color,
          ),
          SizedBox(width: 14),
          Text(text),
        ],
      ),
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            color: kBacColor,
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets))
      ]);
}
