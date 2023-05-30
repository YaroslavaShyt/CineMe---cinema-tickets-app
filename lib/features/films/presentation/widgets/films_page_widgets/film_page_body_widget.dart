import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/film_cards_list_widget.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/recent_films_widget.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'category_widget.dart';
import 'film_stack_widget.dart';

class FilmBody extends StatelessWidget {
  final TextEditingController controller;
  final List<FilmModel> films;
  const FilmBody({Key? key, required this.controller, required this.films}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(children: [
          Column(children: [
            Stack(children: [
              Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(73, 71, 167, 100),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: TopFilmsPageBlock(
                    controller: controller,
                  )),
              FilmCardsList(
                films: films,
              )
            ]),
            const SizedBox(height: 30),
            const CategoryRow(),
            const SizedBox(height: 10),
            const CategoryOptionsRow(),
            RecentFilms(films: films,),
            const SizedBox(height: 30),
          ])
        ]));
  }
}
