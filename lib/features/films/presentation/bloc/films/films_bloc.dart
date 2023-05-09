import 'package:cine_me/features/films/data/models/film_model.dart';
import 'package:cine_me/features/films/domain/usecases/get_films.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'film_state.dart';
part 'films_event.dart';

class FilmsBloc extends Bloc<FilmsEvent, FilmsState>{
  final Films films;
  final String date;
  final String search;

  FilmsBloc({
    required this.films,
    required this.date,
    required this.search,
  }) : super(FilmsInitial());

  @override
  Stream<FilmsState> mapEventToState(FilmsEvent event) async*{
    if(event is FilmsInitiateEvent){
      final response = await films(search: event.search);
      yield response.fold((l){
        return FilmsError(l.appErrorType);
      }, (r)=> FilmsSuccess(r));
    }
  }

}