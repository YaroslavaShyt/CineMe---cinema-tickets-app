import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';

class Storyline extends StatelessWidget {
  final String storyline;
  const Storyline({Key? key, required this.storyline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "storyline".tr().toString(),
            style: TextStyle(fontSize: 25,
              fontWeight: FontWeight.w600,
              color:  Provider.of<ThemeProvider>(context).getTheme == light
                  ? const Color.fromRGBO(73, 71, 157, 10)
                  : const Color.fromRGBO(236, 237, 246, 10),)
        ),
        const SizedBox(height: 15,),
        Wrap(
          children: [
            Text(storyline,
                style: TextStyle(fontSize: 15,
                  color:  Provider.of<ThemeProvider>(context).getTheme == light
                      ? Colors.grey
                      : const Color.fromRGBO(236, 237, 246, 10),)
            )
          ],
        )
      ],
    );
  }
}
