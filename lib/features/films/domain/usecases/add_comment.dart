import 'package:cine_me/features/films/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';

class CommentAdded extends UseCaseCommentAdded<Type> {
  final FilmsRepository _filmsRepository;

  CommentAdded(this._filmsRepository);
  @override
  Future<Either<AppError, IsSuccess>> call(String comment, String filmId,
          String localization, int rating) async =>
      _filmsRepository.getIsCommentAdded(comment, filmId, localization, rating);
}
