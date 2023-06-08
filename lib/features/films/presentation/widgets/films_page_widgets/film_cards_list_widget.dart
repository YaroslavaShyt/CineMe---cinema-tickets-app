import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter/material.dart';
import 'film_card_horizontal_widget.dart';


class FilmCardsList extends StatelessWidget {
  final List<FilmModel> films;
  final String detailsPath;
  const FilmCardsList({
    Key? key,
    required this.detailsPath,
    required this.films
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: 500,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 20,
            ),
            for (var i in films)
              GestureDetector(
                onTap: (){
                  Beamer.of(context)
                      .beamToNamed('$detailsPath?filmName=${i.name}');
                },
                child: FilmCardHorizontal(
                  film: i,
                ),
              ),
            const SizedBox(
              width: 100,
            ),
          ],
        ));
  }
}

