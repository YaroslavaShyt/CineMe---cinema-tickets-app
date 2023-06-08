part of 'films_search_bloc.dart';


abstract class FilmsSearchEvent extends Equatable{
  const FilmsSearchEvent();

  @override
  List<Object?> get props => [];
}

class FilmsSearchInitiateEvent extends FilmsSearchEvent {
  final String search;
  const FilmsSearchInitiateEvent({this.search = ''});


  @override
  List<Object> get props => [];
}
