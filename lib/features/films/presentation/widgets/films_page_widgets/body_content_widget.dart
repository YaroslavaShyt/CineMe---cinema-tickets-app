import 'package:flutter/material.dart';
import 'package:cine_me/core/widgets/app_bar_widget.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import '../../bloc/films_search_bloc/films_search_bloc.dart';
import 'appbar.dart';
import 'film_page_body_widget.dart';


class BodyContent extends StatelessWidget {
  final ScrollController scrollController;
  final List<FilmModel> films;
  final TextEditingController controller;
  final double scrollControllerOffset;
  final Function onPressed;
  final String detailsPath;
  final FilmsSearchBloc filmsSearchBloc;
  const BodyContent({
    Key? key,
    required this.filmsSearchBloc,
    required this.detailsPath,
    required this.onPressed,
    required this.scrollControllerOffset,
    required this.controller,
    required this.scrollController,
    required this.films
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FilmBody(
                  detailsPath: detailsPath,
                  scrollController: scrollController,
                  films: films,
                  filmsSearchBloc: filmsSearchBloc,
                ),
              )
          )
        ]),
        PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 100.0),
          child: FilmAppBar(
            widget: const AppTitle(),
            scrollOffset: scrollControllerOffset,
            onPressed: onPressed,
          ),)
      ],
    );
  }
}
