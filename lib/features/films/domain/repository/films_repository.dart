import 'package:cine_me/features/films/data/models/film_comment_model.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';

abstract class FilmsRepository {
  Future<Either<AppError, List<FilmModel>>> getTodayFilms(
      {String localization = 'en', String search = ''});
  Future<Either<AppError, List<FilmSessionModel>>> getFilmSessions(
      {String filmId = '', String sessionId = ''});
  Future<Either<AppError, IsSuccess>> getIsTicketBooked(
      int sessionId, List<int> seats);
  Future<Either<AppError, IsSuccess>> getIsPaymentSuccess(
      int sessionId,
      List<int> seats,
      String email,
      String cvv,
      String cardNumber,
      String expirationDat);

  Future<Either<AppError, List<FilmCommentModel>>> getFilmComments(
      String localization, String filmId);
}
