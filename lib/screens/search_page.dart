import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/other/search_const.dart';
import 'package:eventssytem/screens/event_page.dart';
import 'package:eventssytem/screens/speaker_page_open.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/search_box_widget.dart';

TextEditingController controller = TextEditingController();
bool viseblec = false;

class SarchClass {
  String type;
  String text;
  void Function() function;
  SarchClass({required this.type, required this.text, required this.function});
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SarchClass> listik = [];

  List<SarchClass> listikvivod = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
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
              title: Text("${AppLocalizations.of(context)?.search}",
                  style: kAppBarTextStyle),
            ),
            body: BlocBuilder<SearchInAppCubit, SearchInAppState>(
                builder: (context, state) {
              if (state is SearchInAppErrorState) {
                return Center(
                    child: Text("${AppLocalizations.of(context)?.error}"));
              }

              if (state is SearchInAppLoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is SearchInAppLoadedState) {
                if (listik.isEmpty) {
                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.speakers}",
                      function: () {
                        Navigator.pushNamed(context, '/speakerpage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.news}",
                      function: () {
                        Navigator.pushNamed(context, '/newspage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.partners}",
                      function: () {
                        Navigator.pushNamed(context, '/partnerspage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.eventmap}",
                      function: () {
                        Navigator.pushNamed(context, '/map');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.transport}",
                      function: () {
                        Navigator.pushNamed(context, '/transportpage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.contacts}",
                      function: () {
                        Navigator.pushNamed(context, '/contactpage');
                      }));
                  //! Выще главная страница

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.feedback}",
                      function: () {
                        Navigator.pushNamed(context, '/feedbackpage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.settings}",
                      function: () {
                        Navigator.pushNamed(context, '/settingsPage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.logout}",
                      function: () {
                        Navigator.pushNamed(context, '/settingsPage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.notifications}",
                      function: () {
                        Navigator.pushNamed(context, '/notificationpage');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.voting}",
                      function: () {
                        Navigator.pushNamed(context, '/voiting');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "B2B",
                      function: () {
                        Navigator.pushNamed(context, '/b2b');
                      }));

                  listik.add(SarchClass(
                      type: "${AppLocalizations.of(context)?.section}",
                      text: "${AppLocalizations.of(context)?.usefulmaterials}",
                      function: () {
                        Navigator.pushNamed(context, '/usefulmaterials');
                      }));

                  if (SearchConsts.rasp.isNotEmpty) {
                    for (var item in SearchConsts.rasp) {
                      print(item.nameRus);

                      listik.add(SarchClass(
                          type: "${AppLocalizations.of(context)?.program}",
                          text: ConstantsClass.locale == "en"
                              ? "${item.nameEng}"
                              : "${item.nameRus}",
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EventPage(
                                    index: item.id.toString(),
                                  ),
                                ));
                          }));
                    }
                  }

                  if (SearchConsts.speakers.isNotEmpty) {
                    for (var item in SearchConsts.speakers) {
                      listik.add(SarchClass(
                          type: "${AppLocalizations.of(context)?.speakers}",
                          text: ConstantsClass.locale == "en"
                              ? "${item.firstNameEng} ${item.lastNameEng}"
                              : "${item.firstNameRus} ${item.lastNameRus}",
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpeakerPageOpen(
                                    index2: item.id.toString(),
                                  ),
                                ));
                          }));
                    }
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(children: [
                        AnimatedContainer(
                            duration: Duration(microseconds: 100),
                            child: Flexible(
                              flex: 4,
                              child: TextFormField(
                                  controller: controller,
                                  onChanged: (newValue) {
                                    setState(() {
                                      if (newValue != "") {
                                        viseblec = true;
                                        filterSearchResults(newValue);
                                      } else {
                                        viseblec = false;
                                        filterSearchResults(newValue);
                                      }
                                    });
                                  },
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      hintText:
                                          "${AppLocalizations.of(context)?.enteryourrequest}",
                                      fillColor: controller.text != ""
                                          ? Colors.white
                                          : Color(0xFFF6F6F6),
                                      labelStyle: TextStyle(
                                          color: controller.text != ""
                                              ? Color(0xFF008870)
                                              : Color(0xFFBDBDBD)),
                                      alignLabelWithHint: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1.0,
                                              color: controller.text != ""
                                                  ? Color(0xFF008870)
                                                  : Color(0xFFBDBDBD)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF008870),
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))))),
                            )),
                        Visibility(
                            visible: viseblec,
                            child: Row(
                              children: [
                                SizedBox(width: 12),
                                GestureDetector(
                                    onTap: () {
                                      controller.clear();
                                      setState(() {
                                        viseblec = false;
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        filterSearchResults("");
                                      });
                                    },
                                    child: Text(
                                        "${AppLocalizations.of(context)?.cansel}")),
                              ],
                            ))
                      ]),
                    ),
                    listikvivod.isEmpty
                        ?
                        //! Ничего не нашли

                        controller.text != ""
                            ? Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${AppLocalizations.of(context)?.notfind}",
                                          style: kzayavblackTextStyle),
                                      SizedBox(height: 12),
                                      Text(
                                          "${AppLocalizations.of(context)?.tryenteringanotherquery}",
                                          style: kzayavblackTextStyle)
                                    ]),
                              )
                            : Container()
                        : Expanded(
                            child: Container(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: listikvivod.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: listikvivod[index].function,
                                      child: SearchBoxWidget(
                                          title: listikvivod[index].type,
                                          text: listikvivod[index].text),
                                    );
                                  }),
                            ),
                          )
                  ],
                );
              }

              return Center(
                  child: Text("${AppLocalizations.of(context)?.error}"));
            })),
      ),
    );
  }

  void filterSearchResults(String query) {
    List<SarchClass> dummySearchList = [];
    dummySearchList.addAll(listik);
    if (query.isNotEmpty) {
      List<SarchClass> dummyListData = [];
      for (var item in dummySearchList) {
        print("item.text=${item.text}");
        print("query=$query");
        if (item.text.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
          print(dummyListData);
        }
      }
      setState(() {
        listikvivod.clear();
        listikvivod.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        listikvivod.clear();
        //listikvivod.addAll(listik);
      });
    }
  }
}
