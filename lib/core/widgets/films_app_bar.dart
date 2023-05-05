import 'package:cine_me/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class FilmsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilmsAppBar({Key? key}) : super(key: key);

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
            const Text('Афiша', style: notoSansDisplayRegularLarge)])),
   /*   actions: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 15, 20),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                )))
      ],*/
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
