import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';

class BookTicketDialog extends StatelessWidget {
  final String sessionId;
  final List<String> seats;
  const BookTicketDialog({Key? key,
    required this.sessionId,
    required this.seats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text(sessionId),
      content: Text(seats.toString()),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
