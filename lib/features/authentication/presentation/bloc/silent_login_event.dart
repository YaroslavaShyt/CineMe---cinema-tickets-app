part of 'silent_login_bloc.dart';

abstract class SilentLoginEvent extends Equatable{
  const SilentLoginEvent();

  @override
  List<Object?> get props => [];
}

class SilentLoginInitiateEvent extends SilentLoginEvent {

  const SilentLoginInitiateEvent();

  @override
  List<Object> get props => [];
}
