import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';

class FilmCardVertical extends StatelessWidget {
  final FilmModel film;
  const FilmCardVertical({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 180,
                child: Image(image: NetworkImage(film.image),),
              ),
            )),
        const SizedBox(height: 10,),
        SizedBox(
            width: 180,
            child: Text(film.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color.fromRGBO(73, 71, 167, 100),)))
      ],
    );
  }
}
