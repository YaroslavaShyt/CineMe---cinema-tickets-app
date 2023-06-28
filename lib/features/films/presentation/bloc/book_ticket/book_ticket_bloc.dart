import 'package:cine_me/features/films/data/models/is_success_model.dart';
import 'package:cine_me/features/films/domain/usecases/get_ticket_booked.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_ticket_event.dart';
part 'book_ticket_state.dart';

class BookTicketBloc extends Bloc<BookTicketEvent, BookTicketState>{
  final BookedTicket bookedTicket;

  BookTicketBloc({

    required this.bookedTicket,
  }) : super(BookTicketInitial());

  @override
  Stream<BookTicketState> mapEventToState(BookTicketEvent event) async*{
    if(event is BookTicketInitiateEvent){
      final response = await bookedTicket(sessionId: event.sessionId, seats: event.seats);
      yield response.fold((l){
        return const BookTicketError('error');
      }, (r)=> BookTicketSuccess(r));
    }
  }

}