part of 'sessions_bloc.dart';

abstract class SessionsEvent extends Equatable{
  const SessionsEvent();

  @override
  List<Object?> get props => [];
}

class SessionsInitiateEvent extends SessionsEvent {
  final String filmId;
  const SessionsInitiateEvent(this.filmId);

  @override
  List<Object> get props => [];
}
