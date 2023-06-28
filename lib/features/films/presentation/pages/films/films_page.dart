import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:cine_me/features/films/presentation/bloc/films_search_bloc/films_search_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/body_content_widget.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/drawer/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmsPage extends StatefulWidget {
  final String detailsPath;
  const FilmsPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<FilmsPage> createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  late FilmsBloc filmsBloc;
  late FilmsSearchBloc filmsSearchBloc;
  final TextEditingController _controller = TextEditingController();
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;
  bool _initialized = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: '');
    filmsSearchBloc = getItInst<FilmsSearchBloc>(param1: '', param2: '');
    super.initState();
  }

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    filmsSearchBloc.close();
    filmsBloc.close();
    super.dispose();
  }

  _initialize() {
    final currentLocale = context.locale;
    filmsSearchBloc.add(FilmsSearchInitiateEvent(
        localization: currentLocale.languageCode == 'uk' &&
                currentLocale.countryCode == 'UA'
            ? 'uk'
            : 'en'));
    filmsBloc.add(FilmsInitiateEvent(
        localization: currentLocale.languageCode == 'uk' &&
                currentLocale.countryCode == 'UA'
            ? 'uk'
            : 'en'));
    _initialized = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => filmsBloc),
        BlocProvider(create: (context) => filmsSearchBloc)
      ],
      child: Scaffold(
        drawer: CustomDrawer(
          function: (locale) {
            filmsBloc.add(FilmsInitiateEvent(localization: locale));
            filmsSearchBloc.add(FilmsSearchInitiateEvent(localization: locale));
          },
        ),
        body: BlocConsumer<FilmsBloc, FilmsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FilmsError) {
              return Text(
                state.message,
              );
            } else if (state is FilmsSuccess) {
              final films = state.films;
              return BodyContent(
                filmsSearchBloc: filmsSearchBloc,
                detailsPath: widget.detailsPath,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                scrollControllerOffset: _scrollControllerOffset,
                controller: _controller,
                scrollController: _scrollController,
                films: films,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
