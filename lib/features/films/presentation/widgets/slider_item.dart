import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
import 'package:flutter/material.dart';

import '../bloc/films/films_bloc.dart';

class MySliderItem extends StatelessWidget {
  final FilmModel filmModel;
  final String detailsPath;
  const MySliderItem({
    Key? key,
    required this.filmModel,
    required this.detailsPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(filmModel.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          filmModel.name,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: white),
        ),
        const SizedBox(height: 30.0),
        Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 10), child:
        TransparentButton(
          onPressed: (){Beamer.of(context).beamToNamed('$detailsPath?filmName=${filmModel.name}');},
          text: 'Деталі',),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
