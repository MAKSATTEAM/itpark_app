import 'package:intl/intl.dart';
import 'package:eventssytem/other/other.dart';

class Util {
  static String getFormattedDate(DateTime dateTime) {
    String languageCode = ConstantsClass.locale == 'en' ? 'en_US' : 'ru';
    return DateFormat.yMMMMd(languageCode).format(dateTime);
  }

  static String getFormattedDateInDay(DateTime dateTime) {
    return DateFormat("Md").format(dateTime);
  }

  static String getFormattedDateInHours(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String getFormattedDay(DateTime dateTime) {
    return DateFormat("d").format(dateTime);
  }
}
