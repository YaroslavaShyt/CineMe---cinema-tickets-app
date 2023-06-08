import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/constants/theme.dart';

class CategoryOptionItem extends StatelessWidget {
  final Icon icon;
  final String text;
  final onPressed;
  const CategoryOptionItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        OutlinedButtonTheme(
            data: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Colors.transparent),
                ),
                backgroundColor: MaterialStateProperty.all<Color?>(
                    Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(236, 237, 246, 100)
                        : const Color.fromRGBO(236, 237, 246, 10)
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                height:
                60,
                child: OutlinedButton(
                  onPressed: onPressed,
                  child: icon,
                ))),
         const SizedBox(height: 10,),
         Text(text, style: TextStyle(
           fontWeight: FontWeight.w600,
           fontSize: 15,
           color: Provider.of<ThemeProvider>(context).getTheme == light
               ? const Color.fromRGBO(73, 71, 167, 100)
               : const Color.fromRGBO(236, 237, 246, 10)),)
      ],
    );
  }
}

