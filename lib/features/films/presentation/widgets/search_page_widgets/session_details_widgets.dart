import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class SessionDetailsHead extends StatelessWidget {
  final String date;
  final String name;
  final String type;
  const SessionDetailsHead({Key? key,
    required this.date,
    required this.type,
    required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  DateFormat('HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(date) *
                              1000)),
                  style: notoSansDisplayRegularTiny),
              Text(
                DateFormat('dd.MM').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(date) *
                            1000)),
                style: notoSansDisplayBoldLarge,
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 20),
              child: Text(
                'Зала $name\n$type',
                style: notoSansDisplayBoldSmall,
              ))
        ]);
  }
}

class SessionDetailsTail extends StatelessWidget {
  final List<int> seatsNumbers;
  final int totalToPay;

  const SessionDetailsTail({super.key, required this.totalToPay, required this.seatsNumbers});

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Обрано: ${seatsNumbers.join(', ')}',
                style: notoSansDisplayBoldSmall,
              ),
              Text(
                'До сплати: $totalToPay грн',
                style: notoSansDisplayBoldSmall,
              ),
            ]));
  }
}