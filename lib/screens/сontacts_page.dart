import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/notification_icon.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:auto_size_text/auto_size_text.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

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
          title: Text("${AppLocalizations.of(context)?.contacts}",
              style: kAppBarTextStyle),
          actions: [NotificationIcon()],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 4),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/phone.svg",
                        color: kIconColor),
                    SizedBox(width: 12),
                    TextButton(
                        onPressed: () {
                          UrlLauncher.launch("tel://88435704001");
                        },
                        child: Text("+7 (843) 570-40-01",
                            style: kContentTextStyle))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/printer.svg",
                          color: kIconColor),
                      SizedBox(width: 12),
                      TextButton(
                          onPressed: () {
                            UrlLauncher.launch("tel://88435704001");
                          },
                          child: Text("+7 (843) 570-40-01",
                              style: kContentTextStyle))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/mail.svg",
                          color: kIconColor),
                      SizedBox(width: 12),
                      TextButton(
                          onPressed: () {
                            UrlLauncher.launch("mailto:forumrostki@mail.ru");
                          },
                          child: Text("forumrostki@mail.ru",
                              style: kContentTextStyle))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/icons/location.svg",
                          color: kIconColor),
                      SizedBox(width: 12),
                      Expanded(
                        child: AutoSizeText(
                            "${AppLocalizations.of(context)?.address}",
                            style: kContentTextStyle,
                            maxLines: 2),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 38),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/map');
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.asset(
                        "assets/images/map.png",
                        height: 160,
                        width: MediaQuery.of(context).size.width - 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/feedbackpage');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          "${AppLocalizations.of(context)?.feedback}",
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kIconColor,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: IconButton(
                          color: kIconColor,
                          onPressed: () {
                            UrlLauncher.launch(
                                "https://twitter.com/InvestTatarstan");
                          },
                          icon: SvgPicture.asset("assets/icons/tw.svg")),
                    ),
                    // SizedBox(width: 29),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: kIconColor,
                    //       borderRadius: BorderRadius.all(Radius.circular(5))),
                    //   child: IconButton(
                    //       color: kIconColor,
                    //       onPressed: () {
                    //         UrlLauncher.launch(
                    //             "https://www.instagram.com/eventssytem/");
                    //       },
                    //       icon: SvgPicture.asset(
                    //         "assets/icons/instagram.svg",
                    //         color: Colors.white,
                    //       )),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
