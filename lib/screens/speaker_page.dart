import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/model.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/screens/speaker_page_open.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/speaker_card.dart';
import 'package:eventssytem/widgets/text_input.dart';

final searchTextFieldControler = TextEditingController();

class SpeakerPage extends StatefulWidget {
  const SpeakerPage({super.key});

  @override
  State<SpeakerPage> createState() => _SpeakerPageState();
}

class SpeakerSearch {
  String name;
  SpeakerSearch({required this.name});
}

class _SpeakerPageState extends State<SpeakerPage> {
  List<SpeakersModel>? _list;
  bool _firstSearch = true;
  String _query = "";
  List<SpeakersModel>? _filterList;
  SpeakersCubit? speakersCubit;
// var items = [];
// final duplicateItems = [];
  @override
  void initState() {
    _list = [];
    _list?.sort();
  }

  _SpeakerPageState() {
    //Register a closure to be called when the object changes.
    searchTextFieldControler.addListener(() {
      if (searchTextFieldControler.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        if (mounted) {
          setState(() {
            _firstSearch = true;
            _query = "";
          });
        }
      } else if (mounted) {
        setState(() {
          _firstSearch = false;
          _query = searchTextFieldControler.text;
        });
      }
    });
  }
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
            title: Text("${AppLocalizations.of(context)?.speakers}",
                style: kAppBarTextStyle),
            actions: [NotificationIcon()],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 6),
                  child: TextInput(
                    text: "${AppLocalizations.of(context)?.search}",
                    textFieldControler: searchTextFieldControler,
                    icon: Icon(
                      Icons.search,
                    ),
                  )),
            ),
          ),
          body: SafeArea(
              child: _firstSearch ? _createListView() : _performSearch())),
    );
  }

  Widget _createListView() {
    return BlocBuilder<SpeakersCubit, SpeakersState>(
      builder: (context, state) {
        print("state is $state");
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
          _list = state.loadedCard3!.cast<SpeakersModel>();
          return ListView.builder(
              itemCount: _list!.length,
              itemBuilder: (context, index) {
                // duplicateItems.add(ConstantsClass.locale == "en"
                //             ? "${_list?[index].firstNameEng} ${_list?[index].lastNameEng}"
                //             : "${_list?[index].firstNameRus} ${_list?[index].lastNameRus}") ;

                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpeakerPageOpen(
                              index2: "${_list?[index].id}",
                            ),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 6),
                      child: SpeakerCard(
                        image: _list?[index].photo == null
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
                                    "${ConstantsClass.url}${_list?[index].photo}",
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    SvgPicture.asset(
                                  "assets/icons/noimg.svg",
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  color: kPrimaryColor,
                                ),
                              ),
                        name: ConstantsClass.locale == "en"
                            ? "${_list?[index].firstNameEng} ${_list?[index].lastNameEng}"
                            : "${_list?[index].firstNameRus} ${_list?[index].lastNameRus}",
                        firm: ConstantsClass.locale == "en"
                            ? "${_list?[index].companyEng}"
                            : "${_list?[index].companyRus}",
                        post: ConstantsClass.locale == "en"
                            ? "${_list?[index].positionEng}"
                            : "${_list?[index].positionRus}",
                      ),
                    ));
              });
        }

        return Text("dada");
      },
    );
  }

// void filterSearchResults(String query, List list) {
//   List<dynamic> dummySearchList = list;
//   dummySearchList.addAll(duplicateItems);
//   if(query.isNotEmpty) {
//     List<String> dummyListData = [];
//     dummySearchList.forEach((item) {
//       if(item.contains(query)) {
//         dummyListData.add(item);
//       }
//     });
//     setState(() {
//       items.clear();
//       items.addAll(dummyListData);
//     });
//     return;
//   } else {
//     setState(() {
//       items.clear();
//       items.addAll(duplicateItems);
//     });
//   }
// }
  Widget _performSearch() {
    _filterList = [];
    for (int i = 0; i < _list!.length; i++) {
      var item = _list![i];

      if (item.firstNameRus!.toLowerCase().contains(_query.toLowerCase()) ||
          item.lastNameRus!.toLowerCase().contains(_query.toLowerCase()) ||
          item.firstNameEng!.toLowerCase().contains(_query.toLowerCase()) ||
          item.lastNameEng!.toLowerCase().contains(_query.toLowerCase())) {
        _filterList!.add(item);
        print("filter list $_filterList");
      }
    }
    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    return BlocBuilder<SpeakersCubit, SpeakersState>(
      builder: (context, state) {
        print("state is $state");
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
          print(_filterList!.length);
          int cards = state.loadedCard3!.length;

          print(_list);
          return ListView.builder(
              itemCount: _filterList!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpeakerPageOpen(
                              index2: "${_filterList?[index].id}",
                            ),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 6),
                      child: SpeakerCard(
                        image: _filterList![index].photo == null
                            ? SvgPicture.asset(
                                "assets/icons/noimg.svg",
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                color: kPrimaryColor,
                              )
                            : Image.network(
                                "${ConstantsClass.url}${_filterList![index].photo}",
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                        name: ConstantsClass.locale == "en"
                            ? "${_filterList![index].firstNameEng} ${_filterList![index].lastNameEng}"
                            : "${_filterList![index].firstNameRus} ${_filterList![index].lastNameRus}",
                        firm: ConstantsClass.locale == "en"
                            ? "${_filterList![index].companyEng}"
                            : "${_filterList![index].companyRus}",
                        post: ConstantsClass.locale == "en"
                            ? "${_filterList![index].positionEng}"
                            : "${_filterList![index].positionRus}",
                      ),
                    ));
              });
        }
        return Text("dada");
      },
    );
  }
}
