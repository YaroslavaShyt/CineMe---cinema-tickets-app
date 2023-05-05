import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String rout;
  final String text;
  const CustomButton({Key? key,
    this.onPressed = _defaultFunction,
    this.rout = '',
    required this.text
  }) : super(key: key);

  static void _defaultFunction(){}

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: red,
          minimumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          foregroundColor: white,
        ),
        child: Text(text));
  }
}
