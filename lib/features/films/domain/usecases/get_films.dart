import 'package:dartz/dartz.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';

class Films implements UseCase<List<FilmModel>>{
  final FilmsRepository _filmsRepository;

  Films(this._filmsRepository);

  @override
  Future<Either<AppError, List<FilmModel>>> call({String search = ''}) async =>
      _filmsRepository.getTodayFilms(search: search);
}