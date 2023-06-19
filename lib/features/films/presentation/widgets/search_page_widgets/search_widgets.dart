import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_film_card.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/core/constants/colors.dart';

class SearchWidget extends StatelessWidget {
  final List<FilmModel> films;
  final TextEditingController controller;
  const SearchWidget({
    Key? key,
    required this.films,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
          children: [
        for (var film in films)
           Padding(
             padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0,),
             child: SizedBox(
                 height: 200,
                 child: CustomCard(film: film)
             ),
           ),
            const SizedBox(height: 10),

      ]),
    );
  }
}
