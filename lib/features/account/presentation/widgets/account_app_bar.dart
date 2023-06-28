import 'package:flutter/material.dart';

class AccountAppbar extends StatelessWidget{
  final widget;
  const AccountAppbar({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(73, 71, 167, 10),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(width: 10),
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            color: Color.fromRGBO(236, 237, 246, 10),
          ),
        ),
        const SizedBox(width: 20),
        widget
      ]),
    );
  }
}
