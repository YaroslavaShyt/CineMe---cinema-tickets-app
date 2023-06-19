import 'package:flutter/material.dart';

class TitleYear extends StatelessWidget {
  final String year;
  final String title;
  const TitleYear({Key? key, required this.year, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      children: [
        Text(title,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white),),
        Text('(${year.toString()})',
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(255, 255, 255, 100)),),
      ],
    );
  }
}
