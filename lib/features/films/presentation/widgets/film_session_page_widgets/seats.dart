import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/theme.dart';


class Seats extends StatelessWidget {
  // final List<FilmSessionModel> seats;
  final FilmSessionModel seats;
  final Function(int, int, int) onSeatPressed;
  const Seats({Key? key, required this.seats, required this.onSeatPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var k = 0; k < 1; k++)
        for (var i = 0; i < seats.room['rows'].length; i++)
          Column(
            children: [
              Row(
                children: [
                  Text('${seats.room['rows'][i]['index']}'),
                  for (var j = 0;
                      j < seats.room['rows'][i]['seats'].length;
                      j++)
                    if (seats.room['rows'][i]['seats'][j]['isAvailable'])
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 0),
                        child: SeatActiveButton(
                          type: seats.room['rows'][i]['seats'][j]['type'],
                          text: '${seats.room['rows'][i]['seats'][j]['index']}',
                          onSeatPressed: onSeatPressed,
                          seatId: seats.room['rows'][i]['seats'][j]['id'],
                          price: seats.room['rows'][i]['seats'][j]['price'],
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(left: 0, top: 0),
                        child: SeatInactiveButton(
                          text:
                              '${seats.room['rows'][i]['seats'][j]['index']}',
                        ),
                      ),
                ],
              ),
            ],
          ),
    ]);
  }
}

class SeatActiveButton extends StatefulWidget {
  final String text;
  final int seatId;
  final int price;
  final int type;
  final Function(int, int, int) onSeatPressed;

  const SeatActiveButton({
    Key? key,
    required this.text,
    required this.onSeatPressed,
    required this.seatId,
    required this.price,
    required this.type,
  }) : super(key: key);

  @override
  State<SeatActiveButton> createState() => _SeatActiveButtonState();
}

class _SeatActiveButtonState extends State<SeatActiveButton> {
  bool isActive = true;
  late Color buttonColor;

  @override
  void initState() {
    super.initState();
    isActive = isActive;
    updateButtonColor();
  }

  void updateButtonColor() {
    if (isActive) {
      if (widget.type == 0) {
        buttonColor = Colors.deepPurple;
      } else if (widget.type == 1) {
        buttonColor = Colors.deepPurpleAccent;
      } else {
        buttonColor = lightYellow;
      }
    } else {
      buttonColor = Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(10, 20),
          backgroundColor: buttonColor //Colors.transparent,
          //  side: BorderSide(color:buttonColor, width: 2)
          ),
      onPressed: () {
        setState(() {
          isActive = !isActive;
          updateButtonColor();
          widget.onSeatPressed(
              widget.seatId, int.parse(widget.text), widget.price);
        });
      },
      child: Text(widget.text, style: notoSansDisplayRegularTiny),
    );
  }
}

class SeatInactiveButton extends StatelessWidget {
  final String text;
  const SeatInactiveButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(10, 20),
          backgroundColor: Colors.grey,
        //  side: const BorderSide(color: red, width: 2)
    ),
      onPressed: () {},
      child: Text(text),
    );
  }
}
