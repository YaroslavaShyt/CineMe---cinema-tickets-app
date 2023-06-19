import 'package:easy_localization/easy_localization.dart';

class HourMinute{
  final int time;
  HourMinute({required this.time});

  get hourMinute{
    return '${time ~/60}${"h".tr().toString()} ${time % 60}${"min".tr().toString()}';
  }
}