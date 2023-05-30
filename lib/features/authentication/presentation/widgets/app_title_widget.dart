import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              height: 210,
              child: Stack(
                alignment: Alignment.center,
                children: const [Positioned(
                  top: 0,
                  child: Text(
                    'Cine',
                    style: TextStyle(color: white, fontSize: 96, fontFamily: 'Prompt', fontWeight: FontWeight.w600),
                  ),
                ),
                  Positioned(
                    top: 90,
                    child: Text(
                      'Me',
                      style: TextStyle(color: white, fontSize: 96, fontFamily: 'Prompt', fontWeight: FontWeight.w600),
                    ),
                  ),],)),
          const SizedBox(height: 40,),
          const Text(
            'Кінотеатр твого міста',
            style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.w300),
          )
        ]);
  }
}
