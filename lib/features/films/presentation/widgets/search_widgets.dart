import 'package:cine_me/core/usecases/shared_preferences_favourites.dart';
import 'package:flutter/material.dart';

import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';

import 'package:cine_me/core/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchWidget extends StatelessWidget {
  final List<FilmModel> films;
  final TextEditingController controller;
  final TextField field;
  const SearchWidget({Key? key,
    this.films = const [],
    required this.controller,
    required this.field}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: Column(children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10,),
                    Expanded(
                      child: field
                    ),
                    IconButton(
                        icon: const Icon(Icons.search, color: white,),
                        onPressed: (){}//onPressed
                    ),
                  ],
                ),
              ),
                  Expanded(child: ListView(children: [
              if (controller.text.isNotEmpty)
                for (var film in films)
                  Column(children: [
                    const SizedBox(height: 20,),
                  CustomCard(film: film)])]))
            ])));
  }
}

class CustomCard extends StatefulWidget {
  final FilmModel film;
  const CustomCard({Key? key, required this.film}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool visible = false;
  late Color heartColor;

  @override
  Future<void> initState() async {
    super.initState();
    List<String>? favouriteFilms = await getFavoriteFilms();
    favouriteFilms != null && favouriteFilms.contains(widget.film.name) ? heartColor = red : heartColor = white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        Padding(padding: const EdgeInsets.all(5.0),child: Image(image: NetworkImage(widget.film.smallImage), height: 100, width: 70,)),
        Expanded(child: Text(widget.film.name, style: notoSansDisplayRegularSmall,)),
          /*IconButton(onPressed: (){
              if (heartColor == red){
                deleteFavoriteFilms(widget.film.name);
                setState(() {
                  heartColor = white;
                  });
                }else {
                updateFavoriteFilms(widget.film.name);
                    setState(() {

                  heartColor = red;
              });}
          }, icon: Icon(Icons.favorite, color: heartColor,))*/
          Padding(padding: const EdgeInsets.only(right: 10.0),
              child: Column(children: [Row(children: [
          const Icon(Icons.star, color: Colors.yellow,),
           Text(widget.film.rating.toString(), style: notoSansDisplayRegularSmall,)
        ]),
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: red
            ),
            onPressed: (){
          setState(() {
            visible = !visible;
          });
        }, child: const Text('Деталі', style: notoSansDisplayRegularTiny,))
        ]))
      ],),
          Visibility(
            visible: visible,
            child: Tail(film: widget.film)
          )
    ],));
  }
}


class Tail extends StatelessWidget {
  final FilmModel film;
  const Tail({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
             Text('Рік, країна: ${film.year} ${film.country}\n', style: notoSansDisplayRegularTiny,),
             Text('Жанр: ${film.genre}\n', style: notoSansDisplayRegularTiny,),
             Text('Мова: ${film.language}\n', style: notoSansDisplayRegularTiny,),
             Text('Тривалість: ${film.duration} хв\n', style: notoSansDisplayRegularTiny,),
             Text('Режисер: ${film.director}\n', style: notoSansDisplayRegularTiny,),
             Text('Сценарист: ${film.screenwriter}\n', style: notoSansDisplayRegularTiny,),
             Text('У ролях: ${film.starring}\n', style: notoSansDisplayRegularTiny,),
             Text('Сюжет: ${film.plot}', style: notoSansDisplayRegularTiny,)
          ]));
  }
}
