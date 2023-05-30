import 'package:flutter/material.dart';

class TopFilmsPageBlock extends StatelessWidget {
  final TextEditingController controller;
  const TopFilmsPageBlock({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          right: -60,
          child: Container(
            width: 280,
            height: 280,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(95, 94, 183, 100),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
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
        ),
        const Positioned(
            left: 30,
            top: 130,
            child: Text(
              'Trending',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
      ],
    );
  }
}