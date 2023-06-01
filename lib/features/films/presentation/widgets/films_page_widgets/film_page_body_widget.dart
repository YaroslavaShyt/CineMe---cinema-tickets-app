import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/recent_films_widget.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'category_widget.dart';
import 'film_stack_widget.dart';

class FilmBody extends StatelessWidget {
  final List<FilmModel> films;
  final ScrollController scrollController;

  const FilmBody({Key? key, required this.films, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
        SingleChildScrollView(
          controller: scrollController,
        child:
        Column(
          children: [
            SizedBox(
              height: 360,
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(73, 71, 167, 100),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  TopFilmsPageBlock(
                    films: films,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const CategoryRow(),
            const SizedBox(height: 10),
            const CategoryOptionsRow(),
            RecentFilms(films: films),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
