import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/progress_page.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
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

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: '');
    filmsSearchBloc = getItInst<FilmsSearchBloc>(param1: '', param2: '');
    filmsSearchBloc.add(const FilmsSearchInitiateEvent());
    filmsBloc.add(const FilmsInitiateEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    filmsSearchBloc.close();
    filmsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => filmsBloc),
          BlocProvider(create: (context) => filmsSearchBloc)
        ],
        child: Scaffold(
          drawer: const CustomDrawer(),
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
                    onPressed: (){Scaffold.of(context).openDrawer();},
                    scrollControllerOffset: _scrollControllerOffset,
                    controller: _controller,
                    scrollController: _scrollController,
                    films: films);
              }
              return const ProgressPage(processName: 'Завантажуємо фільми...');
            },
          ),
        ));
  }
}
