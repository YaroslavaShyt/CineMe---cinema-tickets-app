import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class ErrorPage extends StatelessWidget {
  final String error;
  const ErrorPage({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          const Icon(
            Icons.error_rounded,
            color: white,
            size: 130,
          ),
          const SizedBox(height: 30),
          const Text(
            'Йой! Кіна не буде(',
            style: notoSansDisplayRegularMedium,
          ),
          Text(
            'Виникла помилка: $error',
            style: notoSansDisplayRegularSmall,
          ),
        ]));
  }
}
