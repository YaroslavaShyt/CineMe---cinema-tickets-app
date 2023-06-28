import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/film_details/film_details_stack.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/film_details/stack_details.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/film_details/storyline.dart';
import 'package:cine_me/features/films/presentation/widgets/film_details_page_widgets/film_details/summary_widget.dart';
import 'package:cine_me/core/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../film_details_page_widgets/film_details/rating_row.dart';

class FilmDetailsWidget extends StatelessWidget {
  final List<FilmModel> films;
  final String detailsPath;
  final Widget player;
  final YoutubePlayerController controller;
  const FilmDetailsWidget(
      {Key? key,
      required this.controller,
      required this.films,
      required this.detailsPath,
      required this.player})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FilmDetailsStack(controller: controller, film: films[0]),
        const SizedBox(
          height: 20,
        ),
        RatingRow(
            rating: films[0].rating,
          onPressed: (){
            Share.share('${films[0].name}\n'
                '${films[0].rating}\n'
                '${films[0].country}\n'
                '${films[0].year}\n'
                '${films[0].trailer}');
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: SummaryWidget(
              director: films[0].director,
              writers: films[0].screenwriter,
              image: films[0].smallImage),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
          child: Storyline(storyline: films[0].plot),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0, bottom: 50.0),
            child: CustomButton(
              text: "see sessions".tr().toString(),
              onPressed: (){
                Beamer.of(context)
                    .beamToNamed('$detailsPath?filmName=${films[0].name}&filmId=${films[0].id}');
              },
            ))
      ],
    );
  }
}
