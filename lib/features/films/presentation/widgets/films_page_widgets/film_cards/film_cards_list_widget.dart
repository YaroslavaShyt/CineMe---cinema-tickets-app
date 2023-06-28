import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/films/films_bloc.dart';
import '../../../bloc/films_search_bloc/films_search_bloc.dart';
import 'film_card_horizontal_widget.dart';


class FilmCardsList extends StatelessWidget {
  final List<FilmModel> films;
  final String detailsPath;
  const FilmCardsList({
    Key? key,
    required this.detailsPath,
    required this.films
  }) : super(key: key);

  List<FilmModel> getTopFilms( List<FilmModel> films) {
    films.sort((a, b) => b.rating.compareTo(a.rating));
    return films.take(3).toList();
  }
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FilmsBloc, FilmsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is FilmsSuccess){
        return SizedBox(
            height: 250,
            width: 500,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(
                  width: 20,
                ),
                for (var i in getTopFilms(state.films))
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
          return const CircularProgressIndicator();
        }
    );
  }
}

