import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';
import '../../../../../core/usecases/date_formatting.dart';

class SessionDetailsHead extends StatelessWidget {
  final String date;
  final String name;
  final String type;
  const SessionDetailsHead({Key? key,
    required this.date,
    required this.type,
    required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  formatUnixTime(date),
                  style: TextStyle(
                    color: Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(73, 71, 157, 10)
                        : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                  ),),
              Text(
               formatUnixDate(date),
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).getTheme == light
                      ? const Color.fromRGBO(73, 71, 157, 10)
                      : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20),
              child: Text(
                '${"room".tr().toString()} $name\n$type',
                style: TextStyle(
                  color: Provider.of<ThemeProvider>(context).getTheme == light
                      ? const Color.fromRGBO(73, 71, 157, 10)
                      : Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ))
        ]);
  }
}
