import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmCardsList extends StatelessWidget {
  final List<FilmModel> films;
  const FilmCardsList({Key? key, required this.films})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        child: ListView(
          padding: const EdgeInsets.only(top: 180),
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 20,
            ),
            for (var i in films) FilmCardHorizontal(film: i,),
            const SizedBox(
              width: 30,
            ),
          ],
        ));
  }
}

class FilmCardHorizontal extends StatelessWidget {
  final FilmModel film;
  const FilmCardHorizontal({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
          height: 200,
          width: 320,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.redAccent),
          child: Image(image: NetworkImage(film.image), fit: BoxFit.cover,),
        )));
  }
}

