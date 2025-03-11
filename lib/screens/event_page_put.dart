import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/dropdown_input.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:eventssytem/widgets/text_input.dart';

final textcontroller1 = TextEditingController();
final textcontroller2 = TextEditingController();
final textcontroller3 = TextEditingController();
final textcontroller4 = TextEditingController();
final textcontroller5 = TextEditingController();
final textcontroller6 = TextEditingController();
final textcontroller7 = TextEditingController();
final textcontroller8 = TextEditingController();
final textcontroller9 = TextEditingController();
final textcontroller10 = TextEditingController();

String? selectedvalue1;
String? selectedvalue2;
String? selectedvalue3;
String? selectedvalue4;
String? selectedvalue5;
String? selectedvalue6;
String? selectedvalue7;

class EventPagePut extends StatelessWidget {
  const EventPagePut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBacColor,
        iconTheme: IconThemeData(color: kIconColor),
        elevation: 0,
        centerTitle: true,
        title: Text("${AppLocalizations.of(context)?.application}",
            style: kAppBarTextStyle),
        actions: [NotificationIcon()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 6),
            const Center(
              child: Text("eventssytem2022",
                  style: TextStyle(
                      color: Color(0xFF3B8992),
                      fontWeight: FontWeight.w700,
                      fontSize: MediumTextSize)),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              collapsedBackgroundColor: Color(0xFFE2EAEB),
              backgroundColor: Color(0xFFE2EAEB),
              title:
                  Text("${AppLocalizations.of(context)?.personalinformation}"),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: kBacColor,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      DropdownInput(
                          text:
                              "${AppLocalizations.of(context)?.participationformat}",
                          list: ["one", "two"],
                          selectedvalue: selectedvalue1),
                      const SizedBox(height: 16),
                      DropdownInput(
                          text:
                              "${AppLocalizations.of(context)?.participationpackage}",
                          list: ["one", "two"],
                          selectedvalue: selectedvalue2),
                      const SizedBox(height: 16),
                      DropdownInput(
                          text: "${AppLocalizations.of(context)?.appeal}",
                          list: ["one", "two"],
                          selectedvalue: selectedvalue3),
                      const SizedBox(height: 16),
                      TextInput(
                          text: "${AppLocalizations.of(context)?.fullname}",
                          textFieldControler: textcontroller1),
                      const SizedBox(height: 16),
                      TextInput(
                          text: "${AppLocalizations.of(context)?.fullname}-eng",
                          textFieldControler: textcontroller2),
                      const SizedBox(height: 16),
                      TextInput(
                        text: "${AppLocalizations.of(context)?.dateofbirth}",
                        textFieldControler: textcontroller3,
                        icon2: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(
                            "assets/icons/calendar.svg",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextInput(
                          text:
                              "${AppLocalizations.of(context)?.passportnumber}",
                          textFieldControler: textcontroller4),
                      const SizedBox(height: 16),
                      DropdownInput(
                          text: "${AppLocalizations.of(context)?.citizenship}",
                          list: ["one", "two"],
                          selectedvalue: selectedvalue4),
                      const SizedBox(height: 16),
                      DropdownInput(
                          text:
                              "${AppLocalizations.of(context)?.countryofresidence}",
                          list: ["one", "two"],
                          selectedvalue: selectedvalue5),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (val) {}),
                          Text(
                              "${AppLocalizations.of(context)?.ineedvisasupport}")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            ExpansionTile(
                collapsedBackgroundColor: Color(0xFFE2EAEB),
                backgroundColor: Color(0xFFE2EAEB),
                title: Text("${AppLocalizations.of(context)?.organization}"),
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: kBacColor,
                      padding: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            TextInput(
                                text:
                                    "${AppLocalizations.of(context)?.organization}",
                                textFieldControler: textcontroller5),
                            const SizedBox(height: 16),
                            TextInput(
                                text:
                                    "${AppLocalizations.of(context)?.organization}-eng",
                                textFieldControler: textcontroller6),
                            const SizedBox(height: 16),
                            TextInput(
                                text:
                                    "${AppLocalizations.of(context)?.jobtitle}",
                                textFieldControler: textcontroller7),
                            const SizedBox(height: 16),
                            TextInput(
                                text:
                                    "${AppLocalizations.of(context)?.jobtitle}-eng",
                                textFieldControler: textcontroller8),
                            const SizedBox(height: 16),
                            DropdownInput(
                                text:
                                    "${AppLocalizations.of(context)?.headofficecountry}",
                                list: ["one", "two"],
                                selectedvalue: selectedvalue6),
                            const SizedBox(height: 16),
                            DropdownInput(
                                text: "${AppLocalizations.of(context)?.sphere}",
                                list: ["one", "two"],
                                selectedvalue: selectedvalue7),
                            const SizedBox(height: 16),
                          ]))
                ]),
            const SizedBox(height: 16),
            ExpansionTile(
                collapsedBackgroundColor: Color(0xFFE2EAEB),
                backgroundColor: Color(0xFFE2EAEB),
                title:
                    Text("${AppLocalizations.of(context)?.contactinformation}"),
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: kBacColor,
                      padding: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            TextInput(
                                text: "${AppLocalizations.of(context)?.phone}",
                                textFieldControler: textcontroller9),
                            const SizedBox(height: 16),
                            TextInput(
                                text: "${AppLocalizations.of(context)?.email}",
                                textFieldControler: textcontroller10),
                            const SizedBox(height: 16),
                          ]))
                ]),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        "${AppLocalizations.of(context)?.putzzz}",
                        style: TextStyle(fontSize: 16),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
