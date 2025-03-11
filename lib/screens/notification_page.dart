import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventssytem/other/notification_class.dart';
import 'package:eventssytem/screens/notification_page_open.dart';
import 'package:eventssytem/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:eventssytem/widgets/background.dart';
import 'package:eventssytem/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  var box = Hive.box<NotificationClass>("notificationList");

  NotificationPage({super.key});

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
            title: Text("${AppLocalizations.of(context)?.notifications}",
                style: kAppBarTextStyle),
          ),
          body:

              //!Если уведомлений нет
              box.values.toList().cast<NotificationClass>().isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/nonotifications.svg"),
                          SizedBox(height: 16),
                          Text(
                              "${AppLocalizations.of(context)?.nonotifications}",
                              style: kContentTextStyle.copyWith(
                                  color: Color(0xFF828282))),
                          SizedBox(height: 6),
                          Text(
                              "${AppLocalizations.of(context)?.allthisnotifications}",
                              textAlign: TextAlign.center, 
                              style: kContentTextStyle.copyWith(
                                  color: Color(0xFFBDBDBD)))
                        ],
                      ),
                    )
                  :
                  //!Если уведомлений нет

                  SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: [
                            ValueListenableBuilder<Box>(
                              valueListenable: Hive.box<NotificationClass>(
                                      'notificationList')
                                  .listenable(),
                              builder: (context, box, widget) {
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemCount: box.values
                                        .toList()
                                        .cast<NotificationClass>()
                                        .length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotificationPageOpen(
                                                          tema:
                                                              "${box.values.toList().cast<NotificationClass>()[index].title}",
                                                          body:
                                                              "${box.values.toList().cast<NotificationClass>()[index].body}")));

                                          Hive.box<NotificationClass>(
                                                  'notificationList')
                                              .putAt(
                                                  index,
                                                  NotificationClass(
                                                      title: box.values
                                                          .toList()
                                                          .cast<NotificationClass>()[
                                                              index]
                                                          .title,
                                                      body: box.values
                                                          .toList()
                                                          .cast<NotificationClass>()[
                                                              index]
                                                          .body,
                                                      date: box.values
                                                          .toList()
                                                          .cast<NotificationClass>()[
                                                              index]
                                                          .date,
                                                      read: true));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, bottom: 8),
                                          child: NotificationCard(
                                              tema:
                                                  "${box.values.toList().cast<NotificationClass>()[index].title}",
                                              time:
                                                  "${box.values.toList().cast<NotificationClass>()[index].date}",
                                              text:
                                                  "${box.values.toList().cast<NotificationClass>()[index].body}",
                                              active: box.values
                                                      .toList()
                                                      .cast<NotificationClass>()[
                                                          index]
                                                      .read
                                                  ? false
                                                  : true),
                                        ),
                                      );
                                    });
                              },
                            )
                          ],
                        ),
                      ),
                    )),
    );
  }
}
