part of 'films_bloc.dart';

abstract class FilmsEvent extends Equatable{
  const FilmsEvent();

  @override
  List<Object?> get props => [];
}

class FilmsInitiateEvent extends FilmsEvent {
  final String search;
  final String localization;
  const FilmsInitiateEvent({this.search = '', this.localization = 'en'});


  @override
  List<Object> get props => [];
}
