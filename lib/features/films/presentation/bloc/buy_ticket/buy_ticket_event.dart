part of 'buy_ticket_bloc.dart';

abstract class BuyTicketEvent extends Equatable{
  const BuyTicketEvent();

  @override
  List<Object?> get props => [];
}

class BuyTicketInitiateEvent extends BuyTicketEvent {
  final int sessionId;
  final List<int> seats;
  final String email;
  final String cardNumber;
  final String expireDate;
  final String cvv;
  const BuyTicketInitiateEvent({
    this.sessionId=0,
    this.seats=const [0],
    this.cardNumber='',
    this.email = '',
    this.cvv = '',
    this.expireDate = ''});

  @override
  List<Object> get props => [];
}
