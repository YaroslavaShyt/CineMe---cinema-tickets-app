import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/stack_details.dart';
import 'package:cine_me/features/films/presentation/widgets/title_year.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../hour_minute_text.dart';
import '../search_page_widgets/search_category_item.dart';
import 'actions_row.dart';

class FilmDetailsStack extends StatefulWidget {
  final FilmModel film;
  final YoutubePlayerController controller;
  const FilmDetailsStack({Key? key, required this.film, required this.controller}) : super(key: key);

  @override
  State<FilmDetailsStack> createState() => _FilmDetailsStackState();
}

class _FilmDetailsStackState extends State<FilmDetailsStack> {
  bool isTrailerVisible = false;
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
         StackImage(image: widget.film.image),
         const GradientContainer(),
          const Positioned(top: 20, left: 0, right: 0, child: ActionsRow()),
        Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 SizedBox(
                     width: 280,
                     child: TitleYear(year: widget.film.year.toString(), title: widget.film.name)
                 ),
                 const SizedBox(height: 15,),
                 HourMinuteText(duration: widget.film.duration,)
                ],),
               TrailerButton(
                onPressed: () {
                  setState(() {
                    isTrailerVisible = true;
                  });
                },
              )
            ],
          )),
      Positioned(
        top: 190,
        left: 20,
        right: 20,
        child: SizedBox(
          width: 230,
          child: Wrap(
            children: [
              for (var i in widget.film.genre.split(','))
                SearchCategoryItem(text: i, isFilmDetails: true,)
            ],
          ),
        ),),

          if (isTrailerVisible)
            Positioned.fill(
              // Position the YoutubePlayerBuilder to fill the entire stack
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: controller,
                ),
                builder: (context, player) {
                  return player;
                },)
            ),
        ],
      ),
    );
  }
}
