part of 'book_ticket_bloc.dart';

abstract class BookTicketEvent extends Equatable{
  const BookTicketEvent();

  @override
  List<Object?> get props => [];
}

class BookTicketInitiateEvent extends BookTicketEvent {
  final int sessionId;
  final List<int> seats;
  const BookTicketInitiateEvent({this.sessionId=0, this.seats=const []});

  @override
  List<Object> get props => [];
}
