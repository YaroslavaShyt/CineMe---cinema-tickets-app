
part of 'account_bloc.dart';


abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountSuccess extends AccountState {
  final UserModel user;

  const AccountSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object> get props => [message];
}