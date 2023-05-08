import 'package:cine_me/core/constants/colors.dart';
import 'package:flutter/material.dart';

class BoldFont extends StatelessWidget {
  final String title;
  const BoldFont({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontFamily: 'Prompt',
            fontWeight: FontWeight.w500,
            fontSize: 35)
    );
  }
}

const notoSansDisplayRegularLarge = TextStyle(
  fontFamily: 'NotoSansDisplay',
  fontSize: 30,
  color: white
);

const notoSansDisplayRegularMedium = TextStyle(
    fontFamily: 'NotoSansDisplay',
    fontSize: 25,
    color: white
);

const notoSansDisplayRegularSmall = TextStyle(
    fontFamily: 'NotoSansDisplay',
    fontSize: 20,
    color: white
);

const notoSansDisplayRegularTiny = TextStyle(
    fontFamily: 'NotoSansDisplay',
    fontSize: 15,
    color: white
);

const notoSansDisplayBoldLarge = TextStyle(
  fontFamily: 'NotoSansDisplay',
  fontWeight: FontWeight.w600,
  fontSize: 27,
  color: white
);

const notoSansDisplayBoldMedium = TextStyle(
    fontFamily: 'NotoSansDisplay',
    fontWeight: FontWeight.w600,
    fontSize: 25,
    color: white
);

const notoSansDisplayBoldSmall = TextStyle(
    fontFamily: 'NotoSansDisplay',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: white
);

const notoSansDisplayBoldTiny = TextStyle(
    fontFamily: 'NotoSansDisplay',
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: white
);