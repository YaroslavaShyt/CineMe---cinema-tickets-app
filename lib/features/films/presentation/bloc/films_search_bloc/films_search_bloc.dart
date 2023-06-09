import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/domain/usecases/get_films.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'films_search_state.dart';
part 'films_search_event.dart';

class FilmsSearchBloc extends Bloc<FilmsSearchEvent, FilmsSearchState>{
  final Films films;
  final String date;
  final String search;


  FilmsSearchBloc({
    required this.films,
    required this.date,
    required this.search,

  }) : super(FilmsSearchInitial());


  @override
  Stream<FilmsSearchState> mapEventToState(FilmsSearchEvent event) async*{
    if(event is FilmsSearchInitiateEvent){
      final response = await films(search: event.search, localization: event.localization);
      yield response.fold((l) => FilmsSearchError(l.appErrorType)
          , (r)=> FilmsSearchSuccess(r));
    }
  }

}