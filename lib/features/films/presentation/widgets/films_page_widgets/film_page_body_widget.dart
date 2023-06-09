import 'package:cine_me/features/films/presentation/bloc/films_search_bloc/films_search_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/recent_films_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'category/category_row.dart';
import 'category/category_widget.dart';
import 'film_stack_widget.dart';

class FilmBody extends StatefulWidget {
  final List<FilmModel> films;
  final String detailsPath;
  final ScrollController scrollController;
  final FilmsSearchBloc filmsSearchBloc;


  const FilmBody({
    Key? key,
    required this.filmsSearchBloc,
    required this.films,
    required this.scrollController,
    required this.detailsPath,
  }) : super(key: key);

  @override
  _FilmBodyState createState() => _FilmBodyState();
}

class _FilmBodyState extends State<FilmBody> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 360,
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(73, 71, 167, 10),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  TopFilmsPageBlock(
                    detailsPath: widget.detailsPath,
                    films: widget.films,
                  ),
                ],
              ),
            ),
            CategoryRow(
              onPressedClearFilter: (){
                widget.filmsSearchBloc.add(FilmsSearchInitiateEvent(search: '',
                    localization: context.locale.languageCode == 'uk' &&
                        context.locale.countryCode == 'UA'? 'uk' : 'en'));
              },
            ),
            const SizedBox(height: 10),
            CategoryOptionsRow(
              onPressedAction: () {
                widget.filmsSearchBloc.add(FilmsSearchInitiateEvent(search: "action".tr().toString(),
                    localization: context.locale.languageCode == 'uk' &&
                        context.locale.countryCode == 'UA'? 'uk' : 'en'
                ));
              },
              onPressedAdventure: () {
                widget.filmsSearchBloc.add(FilmsSearchInitiateEvent(search: "adventure".tr().toString(),
                    localization: context.locale.languageCode == 'uk' &&
                        context.locale.countryCode == 'UA'? 'uk' : 'en'
                ));
              },
              onPressedHorror: () {
                widget.filmsSearchBloc.add(FilmsSearchInitiateEvent(search: "horror".tr().toString(),
                    localization: context.locale.languageCode == 'uk' &&
                        context.locale.countryCode == 'UA'? 'uk' : 'en'
                ));
              },
              onPressedRomance: () {
                widget.filmsSearchBloc.add(FilmsSearchInitiateEvent(search: "romance".tr().toString(),
                    localization: context.locale.languageCode == 'uk' &&
                        context.locale.countryCode == 'UA'? 'uk' : 'en'
                ));
              },
            ),
            RecentFilms(
              detailsPath: widget.detailsPath,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }


}
