import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorName;
  const CustomErrorWidget({Key? key, required this.errorName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(errorName);
  }
}
