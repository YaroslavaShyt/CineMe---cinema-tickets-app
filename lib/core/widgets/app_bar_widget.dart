import 'package:flutter/material.dart';

class CinemaAppBar extends StatelessWidget{
  final TextEditingController controller;
  final double scrollOffset;
  final Function onPressed;
  const CinemaAppBar({Key? key, required this.controller, required this.scrollOffset, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color:  const Color.fromRGBO(143, 141, 207, 100).withOpacity((scrollOffset / 150).clamp(0, 1).toDouble()),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                onPressed();
              },
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Type something',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(168, 167, 199, 100),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
    );
  }
}


