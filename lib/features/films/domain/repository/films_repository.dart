import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';

abstract class FilmsRepository{
  Future<Either<AppError, List<FilmModel>>> getTodayFilms ();
}