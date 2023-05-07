import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/widgets/films_app_bar.dart';


class FilmsPage extends StatefulWidget {
  final String detailsPath;
  const FilmsPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  late FilmsBloc filmsBloc;

  @override
  void initState() {
    super.initState();
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: '');
    filmsBloc.add(const FilmsInitiateEvent());
  }

  @override
  void dispose() {
    super.dispose();
    filmsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => filmsBloc)],
        child: Scaffold(
            backgroundColor: lightBlack,
            appBar: const FilmsAppBar(title: 'Афіша',),
            body: BlocConsumer<FilmsBloc, FilmsState>(
                listener: (context, state) {},
              builder: (context, state) {
                if (state is FilmsError) {
                  return const ErrorPage();
                }
                else if (state is FilmsSuccess){
                  final films = state.films;
                  if (films.isEmpty){
                    return const ErrorPage();
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const SizedBox(height: 30,),
                       FilmsSlider(detailsPath: widget.detailsPath, films: films)
                  ]);
                }
                 return const Center(child: CircularProgressIndicator(color: white));
                },
            ),
        ));
  }
}
