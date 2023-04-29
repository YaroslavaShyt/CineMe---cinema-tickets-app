import 'package:flutter/material.dart';

class BoldFont extends StatelessWidget {
  final String title;
  const BoldFont({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontFamily: 'Prompt',
            fontWeight: FontWeight.w500,
            fontSize: 35)
    );
  }
}
