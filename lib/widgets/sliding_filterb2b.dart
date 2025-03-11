import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/filter_b2b.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/flushbar_notif.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

final PanelController panelController2 = PanelController();

class SlidingFilterB2b extends StatefulWidget {
  const SlidingFilterB2b({super.key});

  @override
  State<SlidingFilterB2b> createState() => _SlidingFilterB2bState();
}

class _SlidingFilterB2bState extends State<SlidingFilterB2b> {
  @override
  Widget build(BuildContext context) {
    context.read<FilterB2bCubit>().stream.listen((state) {
      if (state is FilterB2bOpenState) {
        print("objectdd");
        panelController2.open();
      } else if (state is FilterB2bClosedState) {
        panelController2.close();
      }
    });

    bool trans = false;
    return SlidingUpPanel(
      maxHeight: MediaQuery.of(context).size.height * 0.8,
      minHeight: 0,
      controller: panelController2,
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
                    FilterB2bCubit filterCubit = context.read<FilterB2bCubit>();
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
                    SizedBox(height: 18),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)?.speaker}",
                            style: kFilterTextStyle,
                          ),
                          BlocBuilder<Checkspekearb2b, bool>(
                              builder: (context, select) => Switch(
                                  activeColor: kButtonColor,
                                  value: select,
                                  onChanged: (bool value) {
                                    context
                                        .read<Checkspekearb2b>()
                                        .select(value);
                                  }))
                        ]),
                    SizedBox(height: 16),
                    BlocBuilder<B2bFilterNapolnitelCubit,
                        B2bFilterNapolnitelState>(builder: (context, state) {
                      if (state is B2bFilterNapolnitelLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is B2bFilterNapolnitelErrorState) {
                        return Center(
                            child:
                                Text("${AppLocalizations.of(context)?.error}"));
                      }
                      if (state is B2bFilterNapolnitelLoadedState) {
                        List<MultiSelectItem<UniversalModel>> headcountry =
                            state.countyid
                                .map<MultiSelectItem<UniversalModel>>(
                                    (animal) => MultiSelectItem<UniversalModel>(
                                        animal,
                                        ConstantsClass.locale == "en"
                                            ? animal.nameEng
                                            : animal.nameRus))
                                .toList();

                        List<MultiSelectItem<UniversalModel>> spheres = state
                            .otrasl
                            .map<MultiSelectItem<UniversalModel>>((animal) =>
                                MultiSelectItem<UniversalModel>(
                                    animal,
                                    ConstantsClass.locale == "en"
                                        ? animal.nameEng
                                        : animal.nameRus))
                            .toList();

                        List<MultiSelectItem<B2BCompanyModel>> companys = state
                            .company
                            .map<MultiSelectItem<B2BCompanyModel>>((animal) =>
                                MultiSelectItem<B2BCompanyModel>(
                                    animal, animal.name))
                            .toList();

                        void showMultiSelectC(BuildContext context) async {
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<UniversalModel>(
                                searchHint:
                                    "${AppLocalizations.of(context)?.search}",
                                title: AutoSizeText(
                                    "${AppLocalizations.of(context)?.headofficecountry}"),
                                items: headcountry,
                                initialValue: FliterB2b.countryId,
                                onSelectionChanged: (values) {
                                  if (values.length > 1) {
                                    FlusBatNotif().show(
                                        "${AppLocalizations.of(context)?.onlyonefieldisallowedtobeselected}",
                                        context);
                                  }
                                },
                                onConfirm: (values) {
                                  if (values.length > 1) {
                                    FlusBatNotif().show(
                                        "${AppLocalizations.of(context)?.onlyonefieldisallowedtobeselected}",
                                        context);
                                  } else {
                                    setState(() {
                                      FliterB2b.countryId = values;
                                    });

                                    context
                                        .read<FilterB2bCountController>()
                                        .count();
                                  }
                                },
                              );
                            },
                          );
                        }

                        void showMultiSelectCompany(
                            BuildContext context) async {
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<B2BCompanyModel>(
                                searchHint:
                                    "${AppLocalizations.of(context)?.search}",
                                title: Text(
                                    "${AppLocalizations.of(context)?.company}"),
                                items: companys,
                                initialValue: FliterB2b.companyName,
                                onSelectionChanged: (values) {
                                  if (values.length > 1) {
                                    FlusBatNotif().show(
                                        "${AppLocalizations.of(context)?.onlyonefieldisallowedtobeselected}",
                                        context);
                                  }
                                },
                                onConfirm: (values) {
                                  if (values.length > 1) {
                                    FlusBatNotif().show(
                                        "${AppLocalizations.of(context)?.onlyonefieldisallowedtobeselected}",
                                        context);
                                  } else {
                                    setState(() {
                                      FliterB2b.companyName = values;
                                    });

                                    context
                                        .read<FilterB2bCountController>()
                                        .count();
                                  }
                                },
                              );
                            },
                          );
                        }

                        void showMultiSelectS(BuildContext context) async {
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return MultiSelectDialog<UniversalModel>(
                                searchHint:
                                    "${AppLocalizations.of(context)?.search}",
                                title: Text(
                                    "${AppLocalizations.of(context)?.sphere}"),
                                items: spheres,
                                initialValue: FliterB2b.sphereName,
                                onSelectionChanged: (values) {
                                  if (values.length > 1) {
                                    FlusBatNotif().show(
                                        "${AppLocalizations.of(context)?.onlyonefieldisallowedtobeselected}",
                                        context);
                                  }
                                },
                                onConfirm: (values) {
                                  if (values.length > 1) {
                                    FlusBatNotif().show(
                                        "${AppLocalizations.of(context)?.onlyonefieldisallowedtobeselected}",
                                        context);
                                  } else {
                                    setState(() {
                                      FliterB2b.sphereName = values;
                                    });

                                    context
                                        .read<FilterB2bCountController>()
                                        .count();
                                  }
                                },
                              );
                            },
                          );
                        }

                        return Column(children: [
                          GestureDetector(
                            onTap: () {
                              showMultiSelectC(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: FliterB2b.countryId.isEmpty
                                          ? Color(0xFFF6F6F6)
                                          : Color(0xFF3B8992),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(9)),
                                      border: Border.all(
                                        color: FliterB2b.countryId.isEmpty
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
                                          "${AppLocalizations.of(context)?.headofficecountry}: ${FliterB2b.countryId.length}",
                                          style: kFilterTextStyle.copyWith(
                                              color:
                                                  FliterB2b.countryId.isEmpty
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
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              showMultiSelectCompany(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: FliterB2b.companyName.isEmpty
                                          ? Color(0xFFF6F6F6)
                                          : Color(0xFF3B8992),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(9)),
                                      border: Border.all(
                                        color: FliterB2b.companyName.isEmpty
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
                                          "${AppLocalizations.of(context)?.company}: ${FliterB2b.companyName.length}",
                                          style: kFilterTextStyle.copyWith(
                                              color: FliterB2b
                                                          .companyName.isEmpty
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
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: () {
                              showMultiSelectS(context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: FliterB2b.sphereName.isEmpty
                                          ? Color(0xFFF6F6F6)
                                          : Color(0xFF3B8992),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(9)),
                                      border: Border.all(
                                        color: FliterB2b.sphereName.isEmpty
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
                                          "${AppLocalizations.of(context)?.sphere}: ${FliterB2b.sphereName.length}",
                                          style: kFilterTextStyle.copyWith(
                                              color:
                                                  FliterB2b.sphereName.isEmpty
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
                          SizedBox(height: 16),
                        ]);
                      }

                      return Center(
                          child:
                              Text("${AppLocalizations.of(context)?.error}"));
                    }),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              FilterB2bCubit filterB2bCubit =
                                  context.read<FilterB2bCubit>();
                              filterB2bCubit.hide();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                "${AppLocalizations.of(context)?.show}",
                                style: TextStyle(fontSize: 16),
                              ),
                            )),
                      ),
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
                            context.read<Checkspekearb2b>().select(false);

                            setState(() {
                              FliterB2b.countryId = [];
                              FliterB2b.companyName = [];
                              FliterB2b.sphereName = [];
                            });

                            context.read<FilterB2bCountController>().count();

                            FilterB2bCubit filterB2bCubit =
                                context.read<FilterB2bCubit>();
                            filterB2bCubit.hide();
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
