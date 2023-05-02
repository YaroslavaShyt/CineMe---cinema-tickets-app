import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';

class BookTicketDialog extends StatelessWidget {
  final String result1;
  final String result2;
  const BookTicketDialog({Key? key,
    required this.result1,
    required this.result2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text(result1),
      content: Text(result2),
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
