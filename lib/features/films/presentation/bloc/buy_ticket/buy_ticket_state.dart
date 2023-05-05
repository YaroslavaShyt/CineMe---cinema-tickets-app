part of 'buy_ticket_bloc.dart';

abstract class BuyTicketState extends Equatable {
  const BuyTicketState();

  @override
  List<Object> get props => [];
}

class BuyTicketInitial extends BuyTicketState {}

class BuyTicketSuccess extends BuyTicketState {
  final IsPaymentSuccess result;

  const BuyTicketSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class BuyTicketError extends BuyTicketState {
  final String message;

  const BuyTicketError(this.message);

  @override
  List<Object> get props => [message];
}