import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'film_cards_list_widget.dart';


class TopFilmsPageBlock extends StatelessWidget {
  final List<FilmModel> films;
  final String detailsPath;
  const TopFilmsPageBlock({
    Key? key,
    required this.detailsPath,
    required this.films
  })
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
              color: Color.fromRGBO(100, 100, 180, 100),
            ),
          ),
        ),
        Positioned(
            left: 30,
            top: 100,
            child: Text(
              "trending".tr().toString(),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
        Positioned(
            top: 150,
            child: FilmCardsList(
                detailsPath: detailsPath,
                films: films)),
      ],
    );
  }
}