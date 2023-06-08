import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/presentation/bloc/films_search_bloc/films_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'film_card_vertical_widget.dart';


class RecentFilms extends StatefulWidget {
  final String detailsPath;
  // final List<FilmModel> films; // Видаліть це поле
  const RecentFilms({
    Key? key,
    // required this.films, // Видаліть цей аргумент
    required this.detailsPath,
  }) : super(key: key);

  @override
  State<RecentFilms> createState() => _RecentFilmsState();
}

class _RecentFilmsState extends State<RecentFilms> {
    late List<FilmModel> films;

  List<FilmModel> getRecentFilms(List<FilmModel> films) {
    List<FilmModel> list = [];
    for (var film in films) {
      if (!getTopFilms(films).contains(film)) {
        list.add(film);
      }
    }
    return list.take(4).toList();
  }

  List<FilmModel> getTopFilms(List<FilmModel> films) {
    films.sort((a, b) => b.rating.compareTo(a.rating));
    return films.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmsSearchBloc, FilmsSearchState>(
      builder: (context, state) {
        if (state is FilmsSearchSuccess) {
          state.films.length > 4 ?
            films = getRecentFilms(state.films):
              films = state.films;
          return Wrap(
            children: [
              for (var i in films) // Використовуйте фільми з CategoryFilmsLoaded
                GestureDetector(
                  onTap: () {
                    Beamer.of(context).beamToNamed('${widget.detailsPath}?filmName=${i.name}');
                  },
                  child: FilmCardVertical(film: i),
                ),
            ],
          );
        }

        return Container(); // Повертаємо пустий контейнер, якщо стан ще не завантажений
      },
    );
  }
}
