import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges; 
import 'package:hive_flutter/hive_flutter.dart';
import 'package:eventssytem/other/notification_class.dart';
import 'package:eventssytem/utils/constants.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
        elevation: 4,
        badgeColor: kPrimaryColor,
      ),
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeContent: ValueListenableBuilder<Box>(
        valueListenable: Hive.box<NotificationClass>('notificationList').listenable(),
        builder: (context, box, widget) {
          int icount = 0;

          for (var i = 0; i < box.values.toList().cast<NotificationClass>().length; i++) {
            if (box.values.toList().cast<NotificationClass>()[i].read == false) {
              icount++;
            }
          }

          return Text(
            '$icount',
            style: TextStyle(color: Colors.white),
          );
        },
      ),
      child: IconButton(
        iconSize: 40,
        onPressed: () {
          Navigator.pushNamed(context, '/notificationpage');
        },
        icon: SvgPicture.asset("assets/icons/notification.svg"),
      ),
    );
  }
}
