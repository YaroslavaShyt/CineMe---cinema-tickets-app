import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/font_styling.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Icon(
            Icons.error_rounded,
            color: white,
            size: 130,
          ),
          SizedBox(height: 30),
          Text(
            'Йой! Кіна не буде(',
            style: notoSansDisplayRegularMedium,
          ),
          Text(
            'Виникла помилка!',
            style: notoSansDisplayRegularSmall,
          ),
        ]));
  }
}
