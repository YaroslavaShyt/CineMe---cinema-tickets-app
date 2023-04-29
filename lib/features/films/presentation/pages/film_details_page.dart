import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:flutter/material.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({Key? key}) : super(key: key);

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Beamer.of(context).beamBack();
        }, icon: Icon(Icons.close))],
      ),
    )
    ;
  }
}
