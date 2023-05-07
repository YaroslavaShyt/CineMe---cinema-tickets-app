import 'package:cine_me/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class FilmsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const FilmsAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(75);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
          padding: const EdgeInsets.fromLTRB(5, 30, 0, 20),
          child: Row(children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: const Image(image: AssetImage('assets/images/logo.png'), height: 50,)),
            const SizedBox(width: 10,),
            Text(title, style: notoSansDisplayRegularLarge)])),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: SizedBox(
            height: 4.0,
            child: Container(
              color: red,
          ),
        ),
      ),
      backgroundColor: lightBlack,
      elevation: 0,
    );
  }
}
