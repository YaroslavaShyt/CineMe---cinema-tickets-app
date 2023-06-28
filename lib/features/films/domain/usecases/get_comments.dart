import 'package:cine_me/features/films/data/models/film_comment_model.dart';
import 'package:cine_me/features/films/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';

class Comments implements UseCaseFilmComment{
  late final FilmsRepository _filmsRepository;

  Comments(this._filmsRepository);

  @override
  Future<Either<AppError, List<FilmCommentModel>>> call(String localization, String filmId) =>
      _filmsRepository.getFilmComments(localization, filmId);
}