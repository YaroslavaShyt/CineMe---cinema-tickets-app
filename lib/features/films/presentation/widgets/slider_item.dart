import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter/material.dart';

class MySliderItem extends StatelessWidget {
  final FilmModel filmModel;
  final String detailsPath;
  const MySliderItem({
    Key? key,
    required this.filmModel,
    required this.detailsPath
 //   required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(filmModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          filmModel.name,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: white),
        ),
        const SizedBox(height: 30.0),
        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 10), child:
        OutlinedButton(
          onPressed: () => Beamer.of(context).beamToNamed(detailsPath),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
              side: const BorderSide(color: white, width: 1),
            foregroundColor: white,
          ),
          child: const Text('Деталі')),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
