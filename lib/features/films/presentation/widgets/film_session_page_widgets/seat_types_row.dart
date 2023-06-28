import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/theme.dart';

class SeatTypesRow extends StatelessWidget {
  const SeatTypesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: [
          const Icon(
            Icons.square_rounded,
            color: Colors.deepPurple,
          ),
          Text(
            "usual".tr().toString(),
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).getTheme == light
                  ? Colors.black38
                  : Colors.white,
            ),
          )
        ]),
        Column(children: [
          const Icon(Icons.square_rounded, color: Colors.deepPurpleAccent),
          Text(
            "better".tr().toString(),
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).getTheme == light
                  ? Colors.black38
                  : Colors.white,
            ),
          )
        ]),
        Column(children: [
          const Icon(Icons.square_rounded, color: lightYellow),
          Text(
            "vip".tr().toString(),
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).getTheme == light
                  ? Colors.black38
                  : Colors.white,
            ),
          )
        ]),
        Column(children: [
          const Icon(Icons.square_rounded, color: Colors.grey),
          Text(
            "bought".tr().toString(),
            style: TextStyle(
              color: Provider.of<ThemeProvider>(context).getTheme == light
                  ? Colors.black38
                  : Colors.white,
            ),
          )
        ])
      ],
    );
  }
}
