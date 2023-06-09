import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/domain/usecases/get_films.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'films_state.dart';
part 'films_event.dart';

class FilmsBloc extends Bloc<FilmsEvent, FilmsState>{
  final Films films;
  final String date;
  final String search;
  final String localization;

  FilmsBloc({
    required this.films,
    required this.date,
    required this.search,
    this.localization = 'en'
  }) : super(FilmsInitial());


  @override
  Stream<FilmsState> mapEventToState(FilmsEvent event) async*{
    if(event is FilmsInitiateEvent){
      final response = await films(search: event.search, localization: event.localization);
      yield response.fold((l) => FilmsError(l.appErrorType)
      , (r)=> FilmsSuccess(r));
    }
  }

}