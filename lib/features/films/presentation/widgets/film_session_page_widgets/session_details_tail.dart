import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';

class SessionDetailsTail extends StatelessWidget {
  final List<int> seatsNumbers;
  final int totalToPay;

  const SessionDetailsTail(
      {super.key, required this.totalToPay, required this.seatsNumbers});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '${"chosen".tr().toString()}: ${seatsNumbers.join(', ')}',
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).getTheme == light
                    ? Colors.black38
                    : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          Text(
            '${"to pay".tr().toString()}: $totalToPay ${"money".tr().toString()}',
            style: TextStyle(
                color: Provider.of<ThemeProvider>(context).getTheme == light
                    ? Colors.black38
                    : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
        ]));
  }
}
