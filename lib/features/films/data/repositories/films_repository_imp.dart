import 'package:cine_me/core/usecases/shared_pref_access_token.dart';
import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../authentification/domain/entities/app_error_entity.dart';
import '../datasourses/films_remote_datasourse.dart';


class FilmsRepositoryImpl implements FilmsRepository{
  final FilmsRemoteDatasourse _filmsRemoteDatasourse;

  FilmsRepositoryImpl(this._filmsRemoteDatasourse);

  @override
  Future<Either<AppError, List<FilmModel>>> getTodayFilms({String search = ''}) async{
    List<FilmModel> filmsList = [];
    final accessToken = await getAccessToken();
    final data = await _filmsRemoteDatasourse.getTodayFilmsJson(accessToken, search: search);
  //  print('in getTodayFilms filmsrepoimp');
  //  print('data: $data');
    if (data.isRight()){
      final elseData = data.getOrElse(() => {});
      if (elseData != {}){
  //      print('elseData: $elseData');
        final mapData = elseData['data'];
  //      print('mapData: $mapData');
        for (var i = 0; i < mapData.length; i++) {
          if (search.isEmpty){
            filmsList.add(
                FilmModel(
                    id: mapData[i]['id'],
                    name: mapData[i]['name'],
                    image: mapData[i]['image']));
          }else {
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
            //     print('filmList: $filmsList');
          }}}
        print('filmList: $filmsList');
        return Right(filmsList);
    }
    return const Left(AppError(AppErrorType.api));
  }

  @override
  Future<Either<AppError, List<FilmSessionModel>>> getFilmSessions(String filmId) async {
      List<FilmSessionModel> sessionsList = [];
      final accessToken = await getAccessToken();
      final data = await _filmsRemoteDatasourse.getFilmSessionsJson(filmId, accessToken);
      //  print('in getTodayFilms filmsrepoimp');
      //  print('data: $data');
      if (data.isRight()){
      final elseData = data.getOrElse(() => {});
      if (elseData != {}){
      //      print('elseData: $elseData');
        final mapData = elseData['data'];
      //      print('mapData: $mapData');
        for (var i = 0; i < mapData.length; i++) {
          print('${mapData[i]['id']}\n'
              '${mapData[i]['date']}\n'
              '${mapData[i]['type']}\n'
              '${mapData[i]['minPrice']}');
          sessionsList.add(
              FilmSessionModel(
          id: mapData[i]['id'].toString(),
          date: mapData[i]['date'].toString(),
          type: mapData[i]['type'],
          minPrice: mapData[i]['minPrice'].toString(),
          ));
      //     print('filmList: $filmsList');
  }}
    print('filmList: $sessionsList');
    return Right(sessionsList);
  }
  return const Left(AppError(AppErrorType.api));
}}
