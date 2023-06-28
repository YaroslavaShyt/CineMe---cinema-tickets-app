import 'package:flutter/material.dart';

class SliderElement extends StatelessWidget {
  final String date;
  final String day;
  final String time;
  const SliderElement({
    super.key,
    required this.date,
    required this.time,
    required this.day
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            width: 1.0,
        ),
        color: const Color.fromRGBO(73, 71, 167, 100)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${day.toUpperCase()}, $date',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500
              ),
            ),
            Text(
                time,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w500
              ),
            )
          ],
        ),
      ),
    );
  }
}
