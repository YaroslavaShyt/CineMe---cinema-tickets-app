import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_widget.dart';

class FilmDetails extends StatefulWidget {
  final String filmName;
  final String detailsPath;
  const FilmDetails(
      {Key? key, required this.filmName, required this.detailsPath})
      : super(key: key);

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  late FilmsBloc filmsBloc;
  late String videoUrl;
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: widget.filmName);
    filmsBloc.add(FilmsInitiateEvent(search: widget.filmName));
    videoUrl = '';
    controller = YoutubePlayerController(initialVideoId: videoUrl);
  }

  @override
  void dispose() {
    filmsBloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => filmsBloc)],
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Назад'),
              backgroundColor: lightBlack,
              shadowColor: Colors.transparent,
            ),
            body: BlocConsumer<FilmsBloc, FilmsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FilmsError) {
                    return const ErrorPage();
                  } else if (state is FilmsSuccess) {
                    final films = state.films;
                    if (films.isEmpty) {
                      return const ErrorPage();
                    }
                  //  videoUrl = YoutubePlayer.convertUrlToId(films[0].trailer)!;
                    return FilmDetailsWidget(
                      films: films,
                      detailsPath: widget.detailsPath,
                      controller: controller,
                    );
                  }
                  return const Center(child: CircularProgressIndicator(color: white));
                })));
  }
}
