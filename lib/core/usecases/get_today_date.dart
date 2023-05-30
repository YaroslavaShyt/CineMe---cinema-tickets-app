import 'package:intl/intl.dart';

@override
String getDateTimeNow() {
  DateTime now = DateTime.now();
  return DateFormat('yyyy-MM-dd').format(now);
}