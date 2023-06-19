import 'package:flutter/material.dart';

class StackImage extends StatelessWidget {
  final String image;
  const StackImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: Image(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          width: double.infinity,
        ));
  }
}


class GradientContainer extends StatelessWidget {
  const GradientContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 270,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black],
        ),
      ),
    );
  }
}


class TrailerButton extends StatelessWidget {
  final onPressed;
  const TrailerButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.deepOrangeAccent,
        child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 40,)
    );
  }
}
