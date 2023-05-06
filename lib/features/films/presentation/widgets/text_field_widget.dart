import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.controller, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: title,
          labelStyle: notoSansDisplayRegularTiny,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color:white))
      ),
      controller: controller,
    );
  }
}
