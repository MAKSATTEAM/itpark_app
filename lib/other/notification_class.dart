import 'package:hive/hive.dart';
part 'notification_class.g.dart';

@HiveType(typeId: 0)
class NotificationClass {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? body;
  @HiveField(2)
  String? date;
  @HiveField(3)
  bool read;
  NotificationClass(
      {required this.title,
      required this.body,
      required this.date,
      required this.read});
}
