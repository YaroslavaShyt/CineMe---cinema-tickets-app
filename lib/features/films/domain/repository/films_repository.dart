import 'package:cine_me/features/films/data/models/film_model.dart';

abstract class FilmsRepository{
  Future<List<FilmModel>> getTodayFilms (String date, String search);
}