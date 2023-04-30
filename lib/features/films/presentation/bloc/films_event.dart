part of 'films_bloc.dart';

abstract class FilmsEvent extends Equatable{
  const FilmsEvent();

  @override
  List<Object?> get props => [];
}

class FilmsInitiateEvent extends FilmsEvent {
  final String search;
  const FilmsInitiateEvent({this.search = ''});

  @override
  List<Object> get props => [];
}
