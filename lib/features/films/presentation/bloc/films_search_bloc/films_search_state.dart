part of 'films_search_bloc.dart';


abstract class FilmsSearchState extends Equatable {
  const FilmsSearchState();

  @override
  List<Object> get props => [];
}

class FilmsSearchInitial extends FilmsSearchState {}

class FilmsSearchSuccess extends FilmsSearchState {
  final List<FilmModel> films;

  const FilmsSearchSuccess(this.films);

  @override
  List<Object> get props => [films];
}

class FilmsSearchError extends FilmsSearchState {
  final String message;

  const FilmsSearchError(this.message);

  @override
  List<Object> get props => [message];
}