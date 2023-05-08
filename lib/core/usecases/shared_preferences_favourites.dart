import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getFavoriteFilms() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('favoriteFilms') ?? [];
}


void updateFavoriteFilms(String movie) async {
  List<String> currentFavorites = await getFavoriteFilms();
  currentFavorites.add(movie);
  saveFavoriteFilms(currentFavorites);
}

void saveFavoriteFilms(List<String> favoriteFilms) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('favoriteFilms', favoriteFilms);
}

void deleteFavoriteFilms(String filmName) async{
  List<String>? filmsList = await getFavoriteFilms();
  if (filmsList != null && filmsList.contains(filmName)) {
    filmsList.remove(filmName);
    saveFavoriteFilms(filmsList);
  }

}