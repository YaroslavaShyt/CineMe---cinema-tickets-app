import 'package:flutter/material.dart';

import '../../../data/models/time_model.dart';

class HourMinuteText extends StatelessWidget {
  final int duration;
  const HourMinuteText({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(HourMinute(time: duration).hourMinute,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color.fromRGBO(255, 255, 255, 100)),);
  }
}
