import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';

class BookTicketDialog extends StatelessWidget {
  final String totalToPay;
  final String detailsPath;
  final String seats;
  final String sessionId;
  final String result;
  const BookTicketDialog({Key? key,
    required this.totalToPay,
    required this.sessionId,
    required this.seats,
    required this.result,
    required this.detailsPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text('Обрані місця: $seats'),
      content: Text(result),
      actions: [
        TextButton(
          child: const Text("До оплати:"),
          onPressed: () {
            Beamer.of(context).beamToNamed('$detailsPath?sessionId=$sessionId&seats=$seats&totalToPay=$totalToPay');
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
