import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/widgets/films_app_bar.dart';
import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/presentation/bloc/films/films_bloc.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class SearchPage extends StatefulWidget {
  final String detailsPath;
  const SearchPage({Key? key, required this.detailsPath}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  late FilmsBloc filmsBloc;

  @override
  void initState() {
    super.initState();
    filmsBloc = getItInst<FilmsBloc>(param1: '', param2: '');
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
      child: BlocConsumer<FilmsBloc, FilmsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FilmsError) {
            return const ErrorPage();
          } else if (state is FilmsSuccess) {
            final films = state.films;
            if (films.isEmpty) {
              return const ErrorPage();
            }
            return Scaffold(
                appBar: const FilmsAppBar(title: 'Пошук'),
                backgroundColor: lightBlack,
                body: SearchWidget(
                  films: films,
                  controller: controller,
                  field: TextField(
                    onChanged: (string) {
                      filmsBloc.add(FilmsInitiateEvent(search: string));
                    },
                    style: notoSansDisplayRegularSmall,
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Шукати',
                      border: InputBorder.none,
                    ),
                  ),
                ));
          }
          return Scaffold(
              appBar: const FilmsAppBar(title: 'Пошук'),
              backgroundColor: lightBlack,
              body: SearchWidget(
                controller: controller,
                field: TextField(
                  onChanged: (string) {
                    filmsBloc.add(FilmsInitiateEvent(search: string));
                  },
                  style: notoSansDisplayRegularSmall,
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Шукати',
                    border: InputBorder.none,
                  ),
                ),
              ));
        },
      ),
    );
  }
}
