part of 'sessions_bloc.dart';

abstract class SessionsState extends Equatable {
  const SessionsState();

  @override
  List<Object> get props => [];
}

class SessionsInitial extends SessionsState {}

class SessionsSuccess extends SessionsState {
  final List<FilmSessionModel> filmSessionsList;

  const SessionsSuccess(this.filmSessionsList);

  @override
  List<Object> get props => [filmSessionsList];
}

class SessionsError extends SessionsState {
  final String message;

  const SessionsError(this.message);

  @override
  List<Object> get props => [message];
}

class SessionDetailsSuccess extends SessionsState {
  final List<FilmSessionModel> filmSessionsList;

  const SessionDetailsSuccess(this.filmSessionsList);

  @override
  List<Object> get props => [filmSessionsList];
}

class SessionDetailsError extends SessionsState {
  final String message;

  const SessionDetailsError(this.message);

  @override
  List<Object> get props => [message];
}