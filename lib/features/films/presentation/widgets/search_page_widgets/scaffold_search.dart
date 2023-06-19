import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_categories_row.dart';
import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_widgets.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../data/models/film_model.dart';
import '../films_page_widgets/appbar.dart';
import 'search_text_field.dart';

class SearchScaffold extends StatelessWidget {
  final List<FilmModel> films;
  final TextEditingController controller;
  final void Function(String) function;
  final double scrollControllerOffset;
  final ScrollController scrollController;
  final VoidCallback onPressedFilms;
  final VoidCallback onPressedCartoons;
  final VoidCallback onPressedShow;
  final VoidCallback onPressedEmpty;

  const SearchScaffold({
    Key? key,
    required this.scrollController,
    required this.films,
    required this.controller,
    required this.function,
    required this.scrollControllerOffset,
    required this.onPressedFilms,
    required this.onPressedCartoons,
    required this.onPressedShow,
    required this.onPressedEmpty
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(73, 71, 167, 10),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
                SearchTextField(
                  function: function,
                  controller: controller,
                ),
                Positioned(
                  left: 20,
                    top: 120,
                    child: SearchCategoryRow(
                      onPressedEmpty: onPressedEmpty,
                        onPressedFilms: onPressedFilms,
                        onPressedCartoons: onPressedCartoons,
                        onPressedShow: onPressedShow
                    )
                )
              ],
            ),
         Expanded(
           child: SearchWidget(
             films: films,
             controller: controller,
           ),
         ),
        ],
      ),
    );
  }
}
