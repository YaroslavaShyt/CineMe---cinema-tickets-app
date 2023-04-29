part of 'films_bloc.dart';

abstract class FilmsState extends Equatable {
  const FilmsState();

  @override
  List<Object> get props => [];
}

class FilmsInitial extends FilmsState {}

class FilmsSuccess extends FilmsState {
  final List<FilmModel> films;

  const FilmsSuccess(this.films);

  @override
  List<Object> get props => [films];
}

class FilmsError extends FilmsState {
  final String message;

  const FilmsError(this.message);

  @override
  List<Object> get props => [message];
}