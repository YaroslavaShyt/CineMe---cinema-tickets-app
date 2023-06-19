import 'package:flutter/material.dart';

import '../../../data/models/film_model.dart';

class Tail extends StatelessWidget {
  final FilmModel film;
  const Tail({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Рік, країна: ${film.year} ${film.country}\n',
          ),
          Text(
            'Жанр: ${film.genre}\n',

          ),
          Text(
            'Мова: ${film.language}\n',

          ),
          Text(
            'Тривалість: ${film.duration} хв\n',

          ),
          Text(
            'Режисер: ${film.director}\n',

          ),
          Text(
            'Сценарист: ${film.screenwriter}\n',

          ),
          Text(
            'У ролях: ${film.starring}\n',

          ),
          Text(
            'Сюжет: ${film.plot}',

          )
        ]));
  }
}
