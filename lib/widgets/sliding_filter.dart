import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/filter_sh.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

final PanelController panelController = PanelController();

class SlidingFilter extends StatefulWidget {
  const SlidingFilter({super.key});

  @override
  State<SlidingFilter> createState() => _SlidingFilterState();
}

class _SlidingFilterState extends State<SlidingFilter> {
  @override
  Widget build(BuildContext context) {
    context.read<FilterCubit>().stream.listen((state) {
      if (state is FilterOpenState) {
        panelController.open();
      } else if (state is FilterClosedState) {
        panelController.close();
      }
    });

    bool trans = false;
    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
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
                    FilterCubit filterCubit = context.read<FilterCubit>();
                    filterCubit.hide();
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
                    Text("${AppLocalizations.of(context)?.filter}",
                        style: kAppBarTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)?.livestream}",
                            style: kFilterTextStyle,
                          ),
                          BlocBuilder<Checklivestream, bool>(
                              builder: (context, select) => Switch(
                                  activeColor: kButtonColor,
                                  value: select,
                                  onChanged: (bool value) {
                                    context
                                        .read<Checklivestream>()
                                        .select(value);
                                  }))
                        ]),
                    SizedBox(height: 25),
                    BlocBuilder<ShFilterNapolnitelCubit,
                        ShFilterNapolnitelState>(builder: (context, state) {
                      if (state is ShFilterNapolnitelLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is ShFilterNapolnitelErrorState) {
                        return Center(
                            child:
                                Text("${AppLocalizations.of(context)?.error}"));
                      }
                      if (state is ShFilterNapolnitelLoadedState) {
                        List<MultiSelectItem<UniversalModel>> itemsSpheres =
                            state.spheres
                                .map<MultiSelectItem<UniversalModel>>(
                                    (animal) => MultiSelectItem<UniversalModel>(
                                        animal,
                                        ConstantsClass.locale == "en"
                                            ? animal.nameEng
                                            : animal.nameRus))
                                .toList();

                        List<MultiSelectItem<UniversalModel>>
                            itemsEventFormats = state.eventFormats
                                .map<MultiSelectItem<UniversalModel>>(
                                    (animal) => MultiSelectItem<UniversalModel>(
                                        animal,
                                        ConstantsClass.locale == "en"
                                            ? animal.nameEng
                                            : animal.nameRus))
                                .toList();

                        void showMultiSelectS(BuildContext context) async {
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<UniversalModel>(
                                searchHint:
                                    "${AppLocalizations.of(context)?.search}",
                                title: Text(
                                    "${AppLocalizations.of(context)?.sphere}"),
                                items: itemsSpheres,
                                initialValue: FliterInits.listItemsSpheres,
                                onConfirm: (values) {
                                  setState(() {
                                    FliterInits.listItemsSpheres = values;
                                  });

                                  context
                                      .read<FilterShCountController>()
                                      .count();
                                },
                              );
                            },
                          );
                        }

                        void showMultiSelectE(BuildContext context) async {
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<UniversalModel>(
                                searchHint:
                                    "${AppLocalizations.of(context)?.search}",
                                title: Text(
                                    "${AppLocalizations.of(context)?.formats}"),
                                items: itemsEventFormats,
                                initialValue: FliterInits.listItemsEventFormats,
                                onConfirm: (values) {
                                  setState(() {
                                    FliterInits.listItemsEventFormats = values;
                                  });

                                  context
                                      .read<FilterShCountController>()
                                      .count();
                                },
                              );
                            },
                          );
                        }

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showMultiSelectS(context);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: FliterInits
                                                    .listItemsSpheres.isEmpty
                                            ? Color(0xFFF6F6F6)
                                            : Color(0xFF3B8992),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(9)),
                                        border: Border.all(
                                          color: FliterInits.listItemsSpheres.isEmpty
                                              ? Color(0xFFBDBDBD)
                                              : Color(0xFF3B8992),
                                          width: 1.5,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${AppLocalizations.of(context)?.sphere}: ${FliterInits.listItemsSpheres.length}",
                                            style: kFilterTextStyle.copyWith(
                                                color: FliterInits
                                                            .listItemsSpheres.isEmpty
                                                    ? Color(0xFF828282)
                                                    : Color(0xFFFFFFFF)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/vniz.svg"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {
                                showMultiSelectE(context);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: FliterInits.listItemsEventFormats.isEmpty
                                            ? Color(0xFFF6F6F6)
                                            : Color(0xFF3B8992),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(9)),
                                        border: Border.all(
                                          color: FliterInits
                                                      .listItemsEventFormats.isEmpty
                                              ? Color(0xFFBDBDBD)
                                              : Color(0xFF3B8992),
                                          width: 1.5,
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${AppLocalizations.of(context)?.formats}: ${FliterInits.listItemsEventFormats.length}",
                                            style: kFilterTextStyle.copyWith(
                                                color: FliterInits
                                                            .listItemsEventFormats.isEmpty
                                                    ? Color(0xFF828282)
                                                    : Color(0xFFFFFFFF)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                              "assets/icons/vniz.svg"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                          child:
                              Text("${AppLocalizations.of(context)?.error}"));
                    }),
                    SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            FilterCubit filterCubit =
                                context.read<FilterCubit>();
                            filterCubit.hide();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "${AppLocalizations.of(context)?.show}",
                              style: TextStyle(fontSize: 16),
                            ),
                          )),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: Color(0xFFFFFFFF),
                          ),
                          onPressed: () {
                            context.read<Checklivestream>().select(false);
                            setState(() {
                              FliterInits.listItemsSpheres = [];
                              FliterInits.listItemsEventFormats = [];
                            });

                            context.read<FilterShCountController>().count();

                            FilterCubit filterCubit =
                                context.read<FilterCubit>();
                            filterCubit.hide();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "${AppLocalizations.of(context)?.resetfilters}",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xFFBDBDBD)),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
