import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'film_card_vertical_widget.dart';


class RecentFilms extends StatelessWidget {
  final List<FilmModel> films;
  const RecentFilms({Key? key, required this.films}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (var i in films)
          FilmCardVertical(film: i),
      ],);
  }
}