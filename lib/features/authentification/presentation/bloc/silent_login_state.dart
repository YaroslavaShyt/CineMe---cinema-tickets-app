part of 'silent_login_bloc.dart';

abstract class SilentLoginState extends Equatable {
  const SilentLoginState();

  @override
  List<Object> get props => [];
}

class SilentLoginInitial extends SilentLoginState {}

class SilentLoginSuccess extends SilentLoginState {}

class SilentLoginError extends SilentLoginState {
  final String message;

  const SilentLoginError(this.message);

  @override
  List<Object> get props => [message];
}