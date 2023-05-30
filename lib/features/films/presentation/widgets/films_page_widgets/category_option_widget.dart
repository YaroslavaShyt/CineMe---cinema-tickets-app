import 'package:flutter/material.dart';


class CategoryOptionItem extends StatelessWidget {
  final Icon icon;
  final String text;
  const CategoryOptionItem({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        OutlinedButtonTheme(
            data: OutlinedButtonThemeData(
              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Colors.transparent),
                ),
                backgroundColor: MaterialStateProperty.all<Color?>(const Color.fromRGBO(236, 237, 246, 100)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                height:
                60,
                child: OutlinedButton(
                  onPressed: () {},
                  child: icon,
                ))),
         const SizedBox(height: 10,),
         Text(text, style: const TextStyle(
           fontWeight: FontWeight.w600,
           fontSize: 15,
           color: Color.fromRGBO(73, 71, 167, 100),),)
      ],
    );
  }
}




