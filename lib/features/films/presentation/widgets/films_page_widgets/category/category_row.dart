import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/theme.dart';


class CategoryRow extends StatelessWidget {
  final onPressedClearFilter;
  const CategoryRow({Key? key, required this.onPressedClearFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text("category".tr().toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Provider.of<ThemeProvider>(context).getTheme == light
                      ? const Color.fromRGBO(73, 71, 167, 100)
                      : const Color.fromRGBO(236, 237, 246, 10)
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: OutlinedButtonTheme(
              data: OutlinedButtonThemeData(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              child: SizedBox(
                child: OutlinedButton(
                    onPressed: onPressedClearFilter,
                    child: Text(
                      "clear".tr().toString(),
                      style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).getTheme == light
                              ?  Colors.grey
                              : const Color.fromRGBO(236, 237, 246, 100),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    )),
              )),
        )
      ],
    );
  }
}