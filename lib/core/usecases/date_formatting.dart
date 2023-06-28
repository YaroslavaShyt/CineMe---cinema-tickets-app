import 'dart:ui';

import 'package:intl/intl.dart';

String formatUnixDate(String stringDate) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(stringDate) * 1000);
  String formattedDate = DateFormat('dd.MM.yyyy').format(date);
  return formattedDate;
}

String formatUnixTime(String stringTime) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(int.parse(stringTime) * 1000);
  String formattedTime = DateFormat('hh:mm').format(time);
  return formattedTime;
}


String formatUnixWeekDay(String unixDate, {String locale = 'en'}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(unixDate) * 1000);
  String dayOfWeek = DateFormat.E(locale).format(date);
  return dayOfWeek;
}


