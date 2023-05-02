
part of 'account_bloc.dart';


abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountSuccess extends AccountState {
  final UserModel user;
  final Either<AppError, List<TicketModel>> ticketsResponse;

  const AccountSuccess(this.user, this.ticketsResponse);

  @override
  List<Object> get props => [user, ticketsResponse];
}

class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object> get props => [message];
}