import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/cubit/all/cubit.dart';
import 'package:eventssytem/cubit/all/state.dart';
import 'package:eventssytem/other/filter_b2b.dart';
import 'package:eventssytem/other/other.dart';
import 'package:eventssytem/screens/b2b_page_open.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/b2b_card_notif.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/sliding_filterb2b.dart';
import 'package:eventssytem/widgets/speaker_card_b2b.dart';

class B2bPage extends StatelessWidget {
  const B2bPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextFieldControler = TextEditingController();

    update() {
      int? countryId;
      String? companyName = "";
      String? sphereName;

      if (FliterB2b.countryId.isNotEmpty) {
        countryId = FliterB2b.countryId.map<int?>((e) => e.id).toList()[0];
        print("FliterB2b $countryId");
      }

      if (FliterB2b.companyName.isNotEmpty) {
        companyName =
            FliterB2b.companyName.map<String?>((e) => e.name).toList()[0];
        print("FliterB2b $companyName");
      }

      if (FliterB2b.sphereName.isNotEmpty) {
        sphereName = FliterB2b.sphereName.map((e) => e.nameRus).toList()[0];
        print("FliterB2b $sphereName");
      }

      context.read<B2bListCubit>().fethb2b(
          name: searchTextFieldControler.text,
          countryId: countryId,
          companyName: companyName,
          sphereName: sphereName);
    }


    context.read<FilterB2bCubit>().stream.listen((state) {
      if (state is FilterB2bClosedState) {
        update();
      }
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Background().background),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Scaffold(
                appBar: AppBar(
                  backgroundColor: kBacColor,
                  iconTheme: IconThemeData(color: kIconColor),
                  elevation: 0,
                  centerTitle: true,
                  title: Text("B2B", style: kAppBarTextStyle),
                  actions: [NotificationIcon()],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(140),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 11.0, bottom: 6),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: TextFormField(
                                        style: TextStyle(color: Colors.black),
                                        onChanged: (newValue) {
                                          update();
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: searchTextFieldControler,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            filled: true,
                                            labelText:
                                                "${AppLocalizations.of(context)?.search}",
                                            fillColor:
                                                searchTextFieldControler.text != ""
                                                    ? Colors.white
                                                    : Color(0xFFF6F6F6),
                                            labelStyle: TextStyle(
                                                color: searchTextFieldControler.text != ""
                                                    ? Color(0xFF008870)
                                                    : Color(0xFFBDBDBD)),
                                            alignLabelWithHint: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1.0,
                                                    color: searchTextFieldControler.text != ""
                                                        ? Color(0xFF008870)
                                                        : Color(0xFFBDBDBD)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFF008870),
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(8)))))),
                                SizedBox(width: 12),
                                IconButton(
                                    alignment: Alignment.centerRight,
                                    padding: EdgeInsets.zero,
                                    iconSize: 40,
                                    onPressed: () {
                                      FilterB2bCubit filterB2bCubit =
                                          context.read<FilterB2bCubit>();
                                      filterB2bCubit.open();
                                    },
                                    icon: BlocBuilder<FilterB2bCountController,
                                        int>(builder: (context, count) {
                                      return BlocBuilder<Checkspekearb2b, bool>(
                                          builder: (context, select) {
                                        return badges.Badge(
                                          position: badges.BadgePosition.topEnd(top: -10, end: -8),
                                          badgeStyle: badges.BadgeStyle(
                                            badgeColor: kPrimaryColor,
                                          ),
                                          badgeContent: Text(
                                            (count + (select == true ? 1 : 0)).toString(),
                                            style: TextStyle(color: Colors.white),
                                          ),
                                            child: SvgPicture.asset(
                                                "assets/icons/filter.svg"));
                                      });
                                    })),
                              ],
                            ),
                            B2bCard()
                          ],
                        )),
                  ),
                ),
                body: BlocBuilder<B2bListCubit, B2bListState>(
                    builder: (context, state) {
                  if (state is B2bListLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is B2bListErrorState) {
                    return Center(
                        child: Text("${AppLocalizations.of(context)?.error}"));
                  }
                  if (state is B2bListLoadedState) {
                    return BlocBuilder<Checkspekearb2b, bool>(
                        builder: (context, select) {
                      return ListView.builder(
                          itemCount: state.loaded.items.length,
                          itemBuilder: (context, index) {
                            if (select == true &&
                                state.loaded.items[index].isSpeaker == false) {
                              return Container();
                            }

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => B2bPageOpen(
                                            photo:
                                                state.loaded.items[index].photo,
                                            id:
                                                "${state.loaded.items[index].id}",
                                            name: ConstantsClass.locale == "en"
                                                ? "${state.loaded.items[index].lastNameEng} ${state.loaded.items[index].firstNameEng}"
                                                : "${state.loaded.items[index].firstNameRus} ${state.loaded.items[index].lastNameRus}")));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 6),
                                child: SpeakerCardB2B(
                                  image: state.loaded.items[index].photo == null
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
                                              "${ConstantsClass.url}${state.loaded.items[index].photo}",
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                            "assets/icons/noimg.svg",
                                            fit: BoxFit.cover,
                                            alignment: Alignment.center,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                  name: ConstantsClass.locale == "en"
                                      ? "${state.loaded.items[index].lastNameEng} ${state.loaded.items[index].firstNameEng}"
                                      : "${state.loaded.items[index].firstNameRus} ${state.loaded.items[index].lastNameRus}",
                                  firm: ConstantsClass.locale == "en"
                                      ? "${state.loaded.items[index].organizationEng}"
                                      : "${state.loaded.items[index].organizationRus}",
                                  post: ConstantsClass.locale == "en"
                                      ? "${state.loaded.items[index].positionEng}"
                                      : "${state.loaded.items[index].positionRus}",
                                  text: "",
                                  write: state.loaded.items[index].sended,
                                ),
                              ),
                            );
                          });
                    });
                  }
                  return Center(
                      child: Text("${AppLocalizations.of(context)?.error}"));
                })),
            SlidingFilterB2b(),
          ],
        ),
      ),
    );
  }
}
