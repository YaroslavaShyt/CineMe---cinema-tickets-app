import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/domain/repository/films_repository.dart';

import '../datasourses/films_remote_datasourse.dart';

class FilmsRepositoryImpl implements FilmsRepository{
  final FilmsRemoteDatasourse _filmsRemoteDatasourse;

  FilmsRepositoryImpl(this._filmsRemoteDatasourse);

  Future<List<FilmModel>> getTodayFilms(String date, String search) async{
    List<FilmModel> filmsList = [];
    final data = await _filmsRemoteDatasourse.getTodayFilmsJson(date, search);
    if (data == Map<String, dynamic>){
      for (var i = 0; i < data.length(); i++){
        filmsList.add(FilmModel(
            id: data['data'][i]['id'],
            name: i['data']['name'],
            allowedAge: i['data']['age'],
            trailer: trailer,
            image: image,
            smallImage: smallImage,
            originalName: originalName,
            duration: duration,
            language: language,
            rating: rating,
            year: year,
            country: country,
            genre: genre,
            plot: plot,
            starring:
            starring,
            director: director,
            screenwriter: screenwriter,
            studio: studio));
      }
    }
  }
}