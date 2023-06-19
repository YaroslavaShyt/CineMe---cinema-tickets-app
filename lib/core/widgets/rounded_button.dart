import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme.dart';

class RoundedButton extends StatefulWidget {
  final onPressed;
  final onPressedEmpty;
  final String text;
  const RoundedButton({Key? key, required this.onPressed, required this.text, required this.onPressedEmpty}) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  Color buttonColor = const Color.fromRGBO(236, 237, 246, 100);

  void changeButtonColor(){
    setState(() {
      buttonColor == const Color.fromRGBO(236, 237, 246, 100)
          ? buttonColor = Colors.deepOrangeAccent
          : buttonColor = const Color.fromRGBO(236, 237, 246, 100);
    });
  }

  void onPressedButton(){
    buttonColor == const Color.fromRGBO(236, 237, 246, 100)
        ? widget.onPressed()
        : widget.onPressedEmpty();
    changeButtonColor();
  }


  @override
  Widget build(BuildContext context) {
    return OutlinedButtonTheme(
        data: OutlinedButtonThemeData(
          style: ButtonStyle(
            side: MaterialStateProperty.resolveWith<BorderSide>(
                    (Set<MaterialState> states) {
                      if(states.contains(MaterialState.pressed)){
                        return const BorderSide(color: Colors.deepOrangeAccent);
                      }
                  return const BorderSide(color: Colors.transparent);
                }),
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        child: SizedBox(
            height: 30,
            child: OutlinedButton(
                onPressed: onPressedButton,
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ))));
  }
}
