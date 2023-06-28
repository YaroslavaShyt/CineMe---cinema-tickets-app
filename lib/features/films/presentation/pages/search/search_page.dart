import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/scaffold_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';

class SearchPage extends StatefulWidget {
  final String detailsPath;
  const SearchPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  late FilmsBloc filmsBloc;
  List<FilmModel> films = [];
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;
  String localization = 'en';

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: '');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    localization = context.locale.languageCode == 'uk' &&
            context.locale.countryCode == 'UA'
        ? 'uk'
        : 'en';
    filmsBloc.add(FilmsInitiateEvent(search: '', localization: localization));
    super.didChangeDependencies();
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    filmsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => filmsBloc)],
      child: BlocConsumer<FilmsBloc, FilmsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FilmsError) {
            return const ErrorPage();
          } else if (state is FilmsSuccess) {
            films = state.films;
          }
          return SearchScaffold(
            onPressedEmpty: () {
              filmsBloc.add(FilmsInitiateEvent(localization: localization));
            },
            onPressedFilms: () {
              filmsBloc.add(FilmsInitiateEvent(
                  search: 'film', localization: localization));
            },
            onPressedCartoons: () {
              filmsBloc.add(FilmsInitiateEvent(
                  search: 'cartoon', localization: localization));
            },
            onPressedShow: () {
              filmsBloc.add(FilmsInitiateEvent(
                  search: 'show', localization: localization));
            },
            scrollController: _scrollController,
            scrollControllerOffset: _scrollControllerOffset,
            films: films,
            controller: controller,
            function: (string) {
              filmsBloc.add(FilmsInitiateEvent(
                  search: string, localization: localization));
            },
          );
        },
      ),
    );
  }
}
