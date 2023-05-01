import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class TransparentButton extends StatelessWidget {
  final String rout;
  final String text;
  const TransparentButton({Key? key,
  this.rout = '',
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: (){
         // print(rout);
          rout.isNotEmpty? Beamer.of(context).beamToNamed(rout): print('rout is empty');
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          side: const BorderSide(color: white, width: 1),
          foregroundColor: white,
        ),
        child: Text(text));
  }
}
