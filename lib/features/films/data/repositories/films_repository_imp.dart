import 'package:cine_me/core/usecases/shared_pref_access_token.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentication/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/datasourses/films_remote_datasourse.dart';
import 'package:intl/date_symbol_data_file.dart';


class FilmsRepositoryImpl implements FilmsRepository {
  final FilmsRemoteDataSource _filmsRemoteDataSource;

  FilmsRepositoryImpl(this._filmsRemoteDataSource);

  @override
  Future<Either<AppError, List<FilmModel>>> getTodayFilms({String search = ''}) async {
    try {
      final accessToken = await getAccessToken();
      //await initializeDateFormatting('uk_UA', '');
      final data = await _filmsRemoteDataSource.getTodayFilmsJson(accessToken, search: search);
      return data.fold(
            (error) => Left(AppError(error.appErrorType)),
            (json) {
          final List<FilmModel> filmsList = (json['data'] as List)
              .map((filmData) => FilmModel.fromJson(filmData))
              .toList();
          return Right(filmsList);
        },
      );
    } catch (e) {
     return Left(AppError(e.toString()));
    }
  }

  @override
  Future<Either<AppError, List<FilmSessionModel>>> getFilmSessions({String filmId = '', String sessionId = ''}) async {
    try {
      final accessToken = await getAccessToken();
      final data = await _filmsRemoteDataSource.getFilmSessionsJson(accessToken, filmId: filmId, sessionId: sessionId);
      return data.fold(
            (error) => const Left(AppError('Не вдалося отримати дані про сеанси.')),
            (json) {
          final List<FilmSessionModel> sessionsList = (filmId.isNotEmpty)
              ? (json['data'] as List)
              .map((sessionData) => FilmSessionModel.fromJson(sessionData))
              .toList()
              : [FilmSessionModel.fromJson(json)];
          return Right(sessionsList);
        },
      );
    } catch (e) {
      return const Left(AppError('Не вдалося отримати дані про сеанси.'));
    }
  }

  @override
  Future<Either<AppError, IsSuccess>> getIsTicketBooked(int sessionId, List<int> seats) async {
    try {
      final accessToken = await getAccessToken();
      final data = await _filmsRemoteDataSource.bookTicket(accessToken, sessionId, seats);
      return data.fold(
            (error) => const Left(AppError('Не вдалося забронювати квитки.')),
            (json) => Right(IsSuccess.fromJson(json)),
      );
    } catch (e) {
      return const Left(AppError('Не вдалося забронювати квитки.'));
    }
  }

  @override
  Future<Either<AppError, IsSuccess>> getIsPaymentSuccess(
      int sessionId,
      List<int> seats,
      String email,
      String cvv,
      String cardNumber,
      String expirationDate,
      ) async {
    try {
      final accessToken = await getAccessToken();
      final data = await _filmsRemoteDataSource.buyTicket(
        accessToken,
        sessionId,
        seats,
        email,
        cvv,
        cardNumber,
        expirationDate,
      );
      return data.fold(
            (error) => const Left(AppError('Не вдалося придбати квитки.')),
            (json) => Right(IsSuccess.fromJson(json)),
      );
    } catch (e) {
      return const Left(AppError('Не вдалося придбати квитки.'));
    }
  }
}

