import 'dart:ui';

import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/getit/get_it.dart';
import '../../bloc/films/films_bloc.dart';

class FilmDetails extends StatefulWidget {
  final String filmName;
  final String detailsPath;
  const FilmDetails({Key? key, required this.filmName, required this.detailsPath}) : super(key: key);

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  late FilmsBloc filmsBloc;

  @override
  void initState() {
    super.initState();
    print('init details: ${widget.filmName}');
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: widget.filmName);
    print(filmsBloc.search);
    filmsBloc.add(FilmsInitiateEvent(search: widget.filmName));
  }

  @override
  void dispose() {
    super.dispose();
    filmsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    print('параметр ${widget.filmName}');
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => filmsBloc)],
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlack,
      ),
      body:  BlocConsumer<FilmsBloc, FilmsState>(
    listener: (context, state) {},
    builder: (context, state) {
      if (state is FilmsError) {
        return const Text('error');
      }
      else if (state is FilmsSuccess) {
        final films = state.films;
        if (films.isEmpty) {
          return const Text('Отакої, виникла помилка!');
        }
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(films[0].image),
            fit: BoxFit.cover)
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.9)]
                    )
                ),
                child:Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 20),
                    child: Image(image: NetworkImage(films[0].image),
                        width: 250,
                        fit: BoxFit.cover,)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Text(films[0].name),
                Text(films[0].year.toString())]),
                Text(films[0].genre),
                Text(films[0].country),
                Text(films[0].starring),
                Text(films[0].rating),
                Text(films[0].plot),
                TransparentButton(rout: '${widget.detailsPath}?filmId=${films[0].id}',
                    text: 'Переглянути сеанси')
              ]

            )
          ),
        ));
      }
      return const CircularProgressIndicator();
    })
    )
    );
  }
}
