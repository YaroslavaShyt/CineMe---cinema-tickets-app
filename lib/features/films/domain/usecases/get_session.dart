import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/core/usecases/usecase.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';

class FilmSessions extends UseCase<List<FilmSessionModel>>{
  final FilmsRepository _filmsRepository;

  FilmSessions(this._filmsRepository);

  @override
  Future<Either<AppError, List<FilmSessionModel>>> call({String filmId='', String sessionId = ''}) async =>
    _filmsRepository.getFilmSessions(filmId: filmId, sessionId: sessionId);


}