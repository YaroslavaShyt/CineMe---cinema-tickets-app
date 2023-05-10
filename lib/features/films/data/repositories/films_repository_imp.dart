import 'package:cine_me/core/usecases/shared_pref_access_token.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/data/models/is_payment_success_model.dart';
import 'package:cine_me/features/films/data/models/is_ticket_booked.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cine_me/features/authentification/domain/entities/app_error_entity.dart';
import 'package:cine_me/features/films/data/datasourses/films_remote_datasourse.dart';


class FilmsRepositoryImpl implements FilmsRepository{
  final FilmsRemoteDatasourse _filmsRemoteDatasourse;

  FilmsRepositoryImpl(this._filmsRemoteDatasourse);

  @override
  Future<Either<AppError, List<FilmModel>>> getTodayFilms({String search = ''}) async{
    List<FilmModel> filmsList = [];
    final accessToken = await getAccessToken();
    final data = await _filmsRemoteDatasourse.getTodayFilmsJson(accessToken, search: search);
    if (data.isRight()){
      final elseData = data.getOrElse(() => {});
      if (elseData != {}){
        final mapData = elseData['data'];
        for (var i = 0; i < mapData.length; i++) {
          search.isEmpty ?
            filmsList.add(
                FilmModel(
                    id: mapData[i]['id'],
                    name: mapData[i]['name'],
                    image: mapData[i]['image'])):
            filmsList.add(
                FilmModel(
                    id: mapData[i]['id'],
                    name: mapData[i]['name'],
                    allowedAge: mapData[i]['age'],
                    trailer: mapData[i]['trailer'],
                    image: mapData[i]['image'],
                    smallImage: mapData[i]['smallImage'],
                    originalName: mapData[i]['originalName'],
                    duration: mapData[i]['duration'],
                    language: mapData[i]['language'],
                    rating: mapData[i]['rating'],
                    year: mapData[i]['year'],
                    country: mapData[i]['country'],
                    genre: mapData[i]['genre'],
                    plot: mapData[i]['plot'],
                    starring: mapData[i]['starring'],
                    director: mapData[i]['director'],
                    screenwriter: mapData[i]['screenwriter'],
                    studio: mapData[i]['studio']
                ));
          }}
        return Right(filmsList);
    }
    return const Left(AppError('Не вдалося отримати дані про афішу.'));
  }

  @override
  Future<Either<AppError, List<FilmSessionModel>>> getFilmSessions({String filmId = '', String sessionId = ''}) async {
      List<FilmSessionModel> sessionsList = [];
      final accessToken = await getAccessToken();
      final data = await _filmsRemoteDatasourse.getFilmSessionsJson(accessToken, filmId: filmId, sessionId: sessionId);
      if (data.isRight()){
          final elseData = data.getOrElse(() => {});
          if (elseData != {}){
            final mapData = elseData['data'];
            if (filmId.isNotEmpty){
              for (var i = 0; i < mapData.length; i++) {
                sessionsList.add(
                    FilmSessionModel(
                id: mapData[i]['id'].toString(),
                date: mapData[i]['date'].toString(),
                type: mapData[i]['type'],
                minPrice: mapData[i]['minPrice'].toString(),
                ));
              }
            }
            else{
            sessionsList.add(FilmSessionModel(
                id: mapData['id'].toString(),
                date: mapData['date'].toString(),
                type: mapData['type'],
                minPrice: mapData['minPrice'].toString(),
                room: mapData['room']));
            }
          }
          return Right(sessionsList);
      }
      return const Left(AppError('Не вдалося отримати дані про сеанси.'));
  }

  @override
  Future<Either<AppError, IsTicketBooked>> getIsTicketBooked(int sessionId, List <int> seats) async {
    final accessToken = await getAccessToken();
    final data = await _filmsRemoteDatasourse.bookTicket(
        accessToken, sessionId, seats);
    if (data.isRight()) {
      final elseData = data.getOrElse(() => {});
      if (elseData != {}) {
        return Right(IsTicketBooked(
            data: elseData['data'], success: elseData['success']));
      }
    }
    return const Left(AppError('Не вдалося забронювати квитки.'));
  }

  @override
  Future<Either<AppError, IsPaymentSuccess>>
  getIsPaymentSuccess(int sessionId, List <int> seats, String email, String cvv, String cardNumber, String expirationDate) async {
    final accessToken = await getAccessToken();
    final data = await _filmsRemoteDatasourse.buyTicket(
        accessToken, sessionId, seats, email, cvv, cardNumber, expirationDate);
    if (data.isRight()) {
      final elseData = data.getOrElse(() => {});
      if (elseData != {}) {
        return Right(IsPaymentSuccess(
            data: elseData['data'], success: elseData['success']));
      }
    }
    return const Left(AppError('Не вдалося придбати квитки.'));
  }
}
