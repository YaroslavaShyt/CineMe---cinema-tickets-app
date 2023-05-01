import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/domain/usecases/get_session.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sessions_state.dart';
part 'sessions_event.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState>{
  final FilmSessions filmSessions;
  final String filmId;
  final String sessionId;

  SessionsBloc({
    required this.filmSessions,
    required this.filmId,
    required this.sessionId
  }) : super(SessionsInitial());

  @override
  Stream<SessionsState> mapEventToState(SessionsEvent event) async*{
  //  print('у блоці сесії');
    if(event is SessionsInitiateEvent){
   //   print('in bloc before sessions');
      final response = await filmSessions(filmId: filmId, sessionId: sessionId);
   //   print('in bloc after sessions');
      yield response.fold((l){
        return SessionsError(l.toString());
      }, (r)=> SessionsSuccess(r));
    }else{
      print('it is not initial sessions');
    }
  }

}