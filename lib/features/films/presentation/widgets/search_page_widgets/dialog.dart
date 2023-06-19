import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BookTicketDialog extends StatelessWidget {
  final String totalToPay;
  final String detailsPath;
  final String seatsNumbers;
  final String seats;
  final String sessionId;
  final String result;
  const BookTicketDialog({Key? key,
    required this.totalToPay,
    required this.sessionId,
    required this.seatsNumbers,
    required this.seats,
    required this.result,
    required this.detailsPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Text('Обрані місця: $seatsNumbers', style: notoSansDisplayBoldSmall),
      backgroundColor: lightBlack,
      actions: [
        Center(child:
        CustomButton(
          text: "До оплати",
          onPressed: () {
            Beamer.of(context).beamToNamed('$detailsPath&sessionId=$sessionId&seats=$seats&totalToPay=$totalToPay');
            Navigator.of(context).pop();
          },
        )),
      ],
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String success;
  final String body;
  final String buttonText;
  final VoidCallback onPressed;
  const CustomAlertDialog({Key? key, required this.onPressed,
    required this.body,
    required this.success,
    required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: lightBlack,
        title: Text(success, style: notoSansDisplayBoldSmall,),
        content: Text(body, style: notoSansDisplayRegularTiny,),
        actions: [
          TextButton(
              onPressed: onPressed,
              child: Center(child: Text(buttonText, style: notoSansDisplayRegularTiny,)))
        ]);
  }
}

