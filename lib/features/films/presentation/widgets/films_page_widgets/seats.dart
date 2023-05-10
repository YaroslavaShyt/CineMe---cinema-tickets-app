import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:flutter/material.dart';

class SeatTypesRow extends StatelessWidget {
  const SeatTypesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: const [Icon(Icons.square_rounded, color: green,), Text('Звичайне', style: notoSansDisplayRegularTiny,)]),
        Column(children: const [Icon(Icons.square_rounded, color: lightBlue,), Text('Покращене', style: notoSansDisplayRegularTiny,)]),
        Column(children: const [Icon(Icons.square_rounded, color: lightYellow), Text('VIP',  style: notoSansDisplayRegularTiny,)]),
        Column(children: const [Icon(Icons.square_rounded, color: red), Text('Недоступне',  style: notoSansDisplayRegularTiny,)])
      ],
    );
  }
}


class Seats extends StatelessWidget {
  final List<FilmSessionModel> seats;
  final Function(int, int, int) onSeatPressed;
  const Seats({Key? key, required this.seats, required this.onSeatPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          for (var k = 0; k < seats.length; k++)
            for (var i = 0; i < seats[k].room['rows'].length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var j = 0; j < seats[k].room['rows'][i]['seats'].length; j++)
                    if(seats[k].room['rows'][i]['seats'][j]['isAvailable'])
                       Padding(
                           padding: const EdgeInsets.only(left: 5, top: 5),
                           child: SeatActiveButton(
                         type:  seats[k].room['rows'][i]['seats'][j]['type'],
                         text: '${seats[k].room['rows'][i]['index']}${seats[k].room['rows'][i]['seats'][j]['index']}',
                         onSeatPressed: onSeatPressed,
                         seatId: seats[k].room['rows'][i]['seats'][j]['id'],
                         price: seats[k].room['rows'][i]['seats'][j]['price'],
                       ))
                    else
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        child:
                        SeatInactiveButton(text: '${seats[k].room['rows'][i]['index']}${seats[k].room['rows'][i]['seats'][j]['index']}'))
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
        buttonColor = green;
      } else if (widget.type == 1) {
        buttonColor = lightBlue;
      } else {
        buttonColor = lightYellow;
      }
    } else {
      buttonColor = red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(10, 50),
        backgroundColor: Colors.transparent,
        side: BorderSide(color:buttonColor, width: 2)
      ),
      onPressed: () {
        setState(() {
          isActive = !isActive;
          updateButtonColor();
          widget.onSeatPressed(widget.seatId, int.parse(widget.text), widget.price);
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
        minimumSize: const Size(10, 50),
    backgroundColor: Colors.transparent,
          side: const BorderSide(color: red, width: 2)
    ), onPressed: () {},
    child: Text(text),);
  }
}
