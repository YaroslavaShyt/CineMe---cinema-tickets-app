part of 'book_ticket_bloc.dart';

abstract class BookTicketState extends Equatable {
  const BookTicketState();

  @override
  List<Object> get props => [];
}

class BookTicketInitial extends BookTicketState {}

class BookTicketSuccess extends BookTicketState {
  final IsSuccess isTicketBooked;

  const BookTicketSuccess(this.isTicketBooked);

  @override
  List<Object> get props => [isTicketBooked];
}

class BookTicketError extends BookTicketState {
  final String message;

  const BookTicketError(this.message);

  @override
  List<Object> get props => [message];
}