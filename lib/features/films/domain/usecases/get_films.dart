import 'package:dartz/dartz.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';

import '../../../authentification/domain/entities/app_error_entity.dart';
import '../../data/models/film_model.dart';
import '../repository/films_repository.dart';

class Films implements UseCase<List<FilmModel>>{
  final FilmsRepository _filmsRepository;

  Films(this._filmsRepository);

  @override
  Future<Either<AppError, List<FilmModel>>> call({String search = ''}) async =>
      _filmsRepository.getTodayFilms(search: search);
}