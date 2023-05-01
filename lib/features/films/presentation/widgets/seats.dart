import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/presentation/widgets/dialog.dart';
import 'package:flutter/material.dart';

class Seats extends StatelessWidget {
  final List<FilmSessionModel> seats;
  const Seats({Key? key, required this.seats}) : super(key: key);

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
                   SeatButton(
                     text: '${seats[k].room['rows'][i]['seats'][j]['index']}',
                     isActive: seats[k].room['rows'][i]['seats'][j]['isAvailable']
                   ),
                ],
              ),
        ]);
  }
}


class SeatButton extends StatefulWidget {
  final String text;
  late bool isActive;
  SeatButton({Key? key, required this.text, required this.isActive}) : super(key: key);

  @override
  State<SeatButton> createState() => _SeatButtonState();
}

class _SeatButtonState extends State<SeatButton> {
  late Color buttonColor;

  @override
  void initState() {
    super.initState();
    widget.isActive ? buttonColor = green : buttonColor = red;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(30, 40),
          backgroundColor: buttonColor
        ),
        onPressed: (){
          setState(() {
            widget.isActive = !widget.isActive;
            widget.isActive ? buttonColor = red : buttonColor = green;
          });
        },
        child: Text(widget.text));
  }
}
