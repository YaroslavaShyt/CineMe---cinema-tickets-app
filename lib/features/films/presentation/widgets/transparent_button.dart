import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class TransparentButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String rout;
  final String text;
  const TransparentButton({Key? key,
    this.onPressed = _defaultFunction,
    this.rout = '',
    required this.text
  }) : super(key: key);

  static void _defaultFunction() {
    print('default function');
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          side: const BorderSide(color: white, width: 1),
          foregroundColor: white,
        ),
        child: Text(text));
  }
}
