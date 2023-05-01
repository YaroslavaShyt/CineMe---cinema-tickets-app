part of 'sessions_bloc.dart';

abstract class SessionsEvent extends Equatable{
  const SessionsEvent();

  @override
  List<Object?> get props => [];
}

class SessionsInitiateEvent extends SessionsEvent {
  final String filmId;
  final String sessionId;
  const SessionsInitiateEvent({this.filmId='', this.sessionId=''});

  @override
  List<Object> get props => [];
}
