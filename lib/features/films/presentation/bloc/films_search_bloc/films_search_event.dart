part of 'films_search_bloc.dart';


abstract class FilmsSearchEvent extends Equatable{
  const FilmsSearchEvent();

  @override
  List<Object?> get props => [];
}

class FilmsSearchInitiateEvent extends FilmsSearchEvent {
  final String search;
  final String localization;
  const FilmsSearchInitiateEvent({this.search = '', this.localization='en'});


  @override
  List<Object> get props => [];
}
