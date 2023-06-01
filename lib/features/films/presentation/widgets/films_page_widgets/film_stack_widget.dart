import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter/material.dart';
import 'film_cards_list_widget.dart';


class TopFilmsPageBlock extends StatelessWidget {
  final List<FilmModel> films;
  const TopFilmsPageBlock({Key? key, required this.films})
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
        const Positioned(
            left: 30,
            top: 110,
            child: Text(
              'Trending',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
        Positioned(
            top: 160,
            child: FilmCardsList(films: films)),
      ],
    );
  }
}