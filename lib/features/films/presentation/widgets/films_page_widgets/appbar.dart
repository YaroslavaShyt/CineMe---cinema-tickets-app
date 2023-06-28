import 'package:flutter/material.dart';

class FilmAppBar extends StatelessWidget {
  final Function onPressed;
  final double scrollOffset;
  final widget;
  const FilmAppBar(
      {Key? key, required this.onPressed, required this.scrollOffset, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 100,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(73, 71, 167, 10)
                  .withOpacity((scrollOffset / 150).clamp(0, 1).toDouble()),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                onPressed();
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



