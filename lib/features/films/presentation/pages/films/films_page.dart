import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/progress_page.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/body_content_widget.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/drawer.dart';
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
    filmsBloc.add(const FilmsInitiateEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    filmsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => filmsBloc)],
        child: Scaffold(
          drawer: const CustomDrawer(),
          body: BlocConsumer<FilmsBloc, FilmsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FilmsError) {
                return Text(
                  state.message,
                  style: const TextStyle(color: white),
                );
              } else if (state is FilmsSuccess) {
                if (state.films.isEmpty) {
                  return const ErrorPage();
                }
                return BodyContent(
                    scrollControllerOffset: _scrollControllerOffset,
                    controller: _controller,
                    scrollController: _scrollController,
                    films: state.films);
              }
              return const ProgressPage(processName: 'Завантажуємо фільми...');
            },
          ),
        ));
  }
}
