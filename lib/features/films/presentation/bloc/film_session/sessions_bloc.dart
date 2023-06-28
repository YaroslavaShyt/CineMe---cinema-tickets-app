import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/domain/usecases/get_session.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sessions_state.dart';
part 'sessions_event.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState>{
  final FilmSessions filmSessions;

  SessionsBloc({
    required this.filmSessions,
  }) : super(SessionsInitial());

  @override
  Stream<SessionsState> mapEventToState(SessionsEvent event) async*{
    if(event is SessionsInitiateEvent){
      final response = await filmSessions(filmId: event.filmId, sessionId: event.sessionId);
      yield response.fold((l){
        return SessionsError(l.toString());
      }, (r)=> SessionsSuccess(r));
    }
  }

}