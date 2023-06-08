import 'package:flutter/material.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/data/models/time_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/theme.dart';

class FilmCardHorizontal extends StatelessWidget {
  final FilmModel film;
  const FilmCardHorizontal({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Stack(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 200,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Provider.of<ThemeProvider>(context).getTheme == light
                        ? const Color.fromRGBO(73, 71, 167, 100)
                        : const Color.fromRGBO(236, 237, 246, 10)),
                child: Image(
                  image: NetworkImage(film.image),
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
              left: 20,
              top: 20,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 150),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          Text(film.name,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),),
                          Text('(${film.year.toString()})',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 255, 255, 100)),),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Text(HourMinute(time: film.duration).hourMinute,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 255, 255, 100)),),
                    ],
                  ),
                ),
              )
          )
        ]));
  }
}
