part of 'book_ticket_bloc.dart';

abstract class BookTicketEvent extends Equatable{
  const BookTicketEvent();

  @override
  List<Object?> get props => [];
}

class BookTicketInitiateEvent extends BookTicketEvent {
  final int sessionId;
  final List<int> seats;
  final int price;
  const BookTicketInitiateEvent({this.sessionId=0, this.seats=const [], this.price = 0});

  @override
  List<Object> get props => [];
}
