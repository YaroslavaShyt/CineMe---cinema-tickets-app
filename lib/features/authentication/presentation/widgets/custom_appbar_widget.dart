import 'package:flutter/material.dart';
import 'gradient.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: appBarGradient
        ),
        child: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children:
          [Text('CineMe',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontFamily: 'Prompt'),),
            Text('Кiнотеатр твого мiста',
              style: TextStyle(fontFamily: 'Prompt', fontWeight: FontWeight.w200, fontSize: 15))]),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // add any other properties you need
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(300);
}
