import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:dartz/dartz.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/film_session_model.dart';

abstract class FilmsRepository{
  Future<Either<AppError, List<FilmModel>>> getTodayFilms ({String search = ''});
  Future<Either<AppError, List<FilmSessionModel>>> getFilmSessions(String filmId);
}