// import 'dart:convert';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:circular_profile_avatar/circular_profile_avatar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:eventssytem/cubit/all/cubit.dart';
// import 'package:eventssytem/cubit/all/model.dart';
// import 'package:eventssytem/cubit/all/state.dart';
// import 'package:eventssytem/main.dart';
// import 'package:eventssytem/other/drops.dart';
// import 'package:eventssytem/utils/constants.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:eventssytem/widgets/green_line.dart';

// class ClaimPage extends StatelessWidget {
//   const ClaimPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     RouteSettings settings = ModalRoute.of(context)!.settings;

//     String id = settings.arguments as String;

//  //   context.read<ClaimPageCubit>().fetchClaimPage(id);

//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: kBacColor,
//           iconTheme: IconThemeData(color: kIconColor),
//           elevation: 0,
//           centerTitle: true,
//           title: Text("${AppLocalizations.of(context)?.services}",
//               style: kAppBarTextStyle),
//           actions: [
//             IconButton(
//                 iconSize: 40,
//                 onPressed: () {
//                   drops.selecteddrops = {
//                     "null": Citizenship(id: "null", display: "null")
//                   };
//                   Navigator.pushNamed(context, '/claimeditpage', arguments: id);
//                 },
//                 icon: SvgPicture.asset("assets/icons/editp.svg")),
//          NotificationIcon()
//           ],
//         ),
//         body: BlocBuilder<ClaimPageCubit, ClaimPageState>(
//             builder: (context, state) {
//           print(state);
//           if (state is ClaimPageLoadingState) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (state is ClaimPageLoadedState) {
//             return SingleChildScrollView(
//               //  physics: NeverScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 6),
//                   const Center(
//                     child: Text("eventssytem2022",
//                         style: TextStyle(
//                             color: Color(0xFF3B8992),
//                             fontWeight: FontWeight.w700,
//                             fontSize: MediumTextSize)),
//                   ),
//                   //   Text("${state.loadedClaimPage.values["headOfficeCountry"]}"),
//                   ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: state.loadedClaimPage.groups?.length,
//                       itemBuilder: (context, index) {
//                         int schet = 0;
//                         return Column(
//                           children: [
//                             const SizedBox(height: 16),
//                             GreenLine(
//                                 text: state.loadedClaimPage.groups[index]
//                                         .display ??
//                                     ""),
//                             ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: state.loadedClaimPage.groups[index]
//                                     .fields?.length,
//                                 itemBuilder: (context, index2) {
//                                   String? text = "";
//                                   String? text2 = "";
//                                   String? type = "";
//                                   var items;
//                                   for (var i = 0;
//                                       i < state.loadedClaimPage.fields?.length;
//                                       i++) {
//                                     if (state.loadedClaimPage.groups[index]
//                                             .fields[index2] ==
//                                         state.loadedClaimPage.fields[i].code) {
//                                       text = state
//                                           .loadedClaimPage.fields[i]?.display;

//                                       type =
//                                           state.loadedClaimPage.fields[i]?.type;

//                                       items = state
//                                           .loadedClaimPage.fields[i]?.items;
//                                     }
//                                   }

//                                   if (state.loadedClaimPage.values[
//                                           "${state.loadedClaimPage.groups[index].fields[index2]}"]
//                                       is Map) {
//                                     text2 =
//                                         "${state.loadedClaimPage.values["${state.loadedClaimPage.groups[index].fields[index2]}"]["display"]}";
//                                   } else {
//                                     text2 =
//                                         "${state.loadedClaimPage.values["${state.loadedClaimPage.groups[index].fields[index2]}"]}";
//                                   }

//                                   if (type == "Radio") {
//                                     for (var i2 = 0; i2 < items!.length; i2++) {
//                                       if (text2 == items[i2].id) {
//                                         text2 = items[i2].display;
//                                       }
//                                     }
//                                   }

//                                   if (text2 == "null") {
//                                     schet++;

//                                     if (schet ==
//                                         state.loadedClaimPage.groups[index]
//                                             .fields?.length) {
//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           const SizedBox(height: 16),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 16, right: 16),
//                                             child: Text(
//                                               "${AppLocalizations.of(context)?.noinformation}",
//                                               style:
//                                                   kzayavblackTextStyle.copyWith(
//                                                       color: Color(0xFFBDBDBD)),
//                                             ),
//                                           )
//                                         ],
//                                       );
//                                     }

//                                     return Container();
//                                   }

//                                   if (text == null) {
//                                     return Container();
//                                   }

//                                   print(text);

//                                   if (text2 == "true") {
//                                     text2 = AppLocalizations.of(context)?.yes;
//                                   }

//                                   if (text2 == "false") {
//                                     text2 = AppLocalizations.of(context)?.no;
//                                   }

//                                   return Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 16, right: 16),
//                                     child: Column(children: [
//                                       const SizedBox(height: 16),
//                                       Row(children: [
//                                         Flexible(
//                                           child: RichText(
//                                               text: TextSpan(children: [
//                                             TextSpan(
//                                               text: "${text}: ",
//                                               style: kzayavgreenTextStyle,
//                                             ),
//                                             TextSpan(
//                                               text: "${text2}",
//                                               style: kzayavblackTextStyle,
//                                             ),
//                                           ])),
//                                         ),
//                                         // Flexible(
//                                         //   child: Text(
//                                         //     "${text}:",
//                                         //     style: kzayavgreenTextStyle,
//                                         //   ),
//                                         // ),
//                                         // const SizedBox(width: 5),
//                                         // Flexible(
//                                         //   child: AutoSizeText(
//                                         //     "${text2}",
//                                         //     style: kzayavblackTextStyle,
//                                         //   ),
//                                         // )
//                                       ])
//                                     ]),
//                                   );
//                                 }),
//                           ],
//                         );
//                       }),
//                   const SizedBox(height: 16)
//                 ],
//               ),
//             );
//           }
//           return Text("Error $id");
//         }));
//   }
// }
