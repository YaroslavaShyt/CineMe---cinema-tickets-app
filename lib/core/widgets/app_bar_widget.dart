import 'package:flutter/material.dart';

class CinemaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CinemaAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text('Hello, Annonymus!', style: TextStyle(color: Theme.of(context).primaryColorDark),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
    );
  }

}
