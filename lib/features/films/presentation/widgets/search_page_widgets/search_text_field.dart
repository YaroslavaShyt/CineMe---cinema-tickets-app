import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) function;
  const SearchTextField({Key? key, required this.controller, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
        child: TextField(
          onChanged: function,
          controller: controller,
          style: const TextStyle(
            color: Colors.black38
          ),
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: 'Type something',
            hintStyle: TextStyle(
              color: Color.fromRGBO(168, 167, 199, 100),
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.white),
            ),
              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30)
          ),
        ));
  }
}
