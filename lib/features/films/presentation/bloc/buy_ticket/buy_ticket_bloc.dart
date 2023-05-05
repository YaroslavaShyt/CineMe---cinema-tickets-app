import 'package:bloc/bloc.dart';
import 'package:cine_me/features/films/data/models/is_payment_success_model.dart';
import 'package:cine_me/features/films/data/models/is_ticket_booked.dart';
import 'package:cine_me/features/films/domain/usecases/buy_ticket.dart';
import 'package:equatable/equatable.dart';

part 'buy_ticket_state.dart';
part 'buy_ticket_event.dart';

class BuyTicketBloc extends Bloc<BuyTicketEvent, BuyTicketState>{
  final BoughtTicket boughtTicket;

  BuyTicketBloc({
    required this.boughtTicket,
  }) : super(BuyTicketInitial());

  @override
  Stream<BuyTicketState> mapEventToState(BuyTicketEvent event) async*{
    //  print('у блоці сесії');
    if(event is BuyTicketInitiateEvent){
         print('in bloc before sessions');
         print('sessionId: ${event.sessionId}\nseats:${event.seats}\nemail${event.email}'
             '\ncardNumber:${event.cardNumber}\ncvv:${event.cvv}\nexpire:${event.expireDate}');
      final response = await boughtTicket(
          sessionId: event.sessionId, seats: event.seats, email: event.email,
          cardNumber: event.cardNumber, cvv: event.cvv, expirationDate: event.expireDate
      );
      //   print('in bloc after sessions');
      yield response.fold((l){
        return BuyTicketError(l.toString());
      }, (r)=> BuyTicketSuccess(r));
    }else{
      print('it is not initial sessions');
    }
  }

}