import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/book_ticket/book_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/dialog.dart';
import 'package:cine_me/features/films/presentation/widgets/seats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/presentation/widgets/transparent_button.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/core/constants/font_styling.dart';

class SessionDetails extends StatefulWidget {
  final String detailsPath;
  final String sessionId;
  const SessionDetails({Key? key,
    required this.sessionId,
    required this.detailsPath}) : super(key: key);

  @override
  State<SessionDetails> createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  late final SessionsBloc sessionsBloc;
  late final BookTicketBloc bookTicketBloc;
  List<int> seats = [];
  int totalToPay = 0;

  @override
  void initState() {
    super.initState();
    sessionsBloc =
        getItInst<SessionsBloc>(param1: '', param2: widget.sessionId);
    sessionsBloc
        .add(SessionsInitiateEvent(filmId: '', sessionId: widget.sessionId));
    bookTicketBloc = getItInst<BookTicketBloc>(
        param1: int.parse(widget.sessionId), param2: seats);
  }

  @override
  void dispose() {
    super.dispose();
    sessionsBloc.close();
    bookTicketBloc.close();
  }

  void _onSeatPressed(int seatNumber, int price) {
    setState(() {
      if (seats.contains(seatNumber)) {
        seats.remove(seatNumber);
        totalToPay -= price;
      } else {
        seats.add(seatNumber);
        totalToPay += price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sessionsBloc),
          BlocProvider(create: (context) => bookTicketBloc),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Назад'),
            shadowColor: Colors.transparent,
            backgroundColor: lightBlack,
          ),
          body: BlocConsumer<SessionsBloc, SessionsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SessionsError) {
                  return const Text('error');
                } else if (state is SessionsSuccess) {
                  final session = state.filmSessionsList;
                  if (session.isEmpty) {
                    return const ErrorPage();
                  }
                  return MultiBlocListener(
                      listeners: [
                        BlocListener<BookTicketBloc, BookTicketState>(
                          listener: (context, state) {
                            if (state is BookTicketSuccess) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BookTicketDialog(
                                    totalToPay: totalToPay.toString(),
                                    sessionId: widget.sessionId,
                                    seats: seats.join(','),
                                    detailsPath: widget.detailsPath,
                                      result:
                                    state.isTicketBooked.success.toString(),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Text('Оберіть місце', style: notoSansDisplayRegularMedium,)),


                      Seats(
                        seats: session,
                        onSeatPressed: _onSeatPressed,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      Text(
                        'Обрано: ${seats.toString()}',
                        style: notoSansDisplayRegularSmall,
                      ),
                      Text('До сплати: $totalToPay',
                        style: notoSansDisplayRegularSmall,
                      ),]),
                      CustomButton(
                        text: 'Обрати',
                        onPressed: () {
                          context.read<BookTicketBloc>().add(
                              BookTicketInitiateEvent(
                                  seats: seats,
                                  sessionId: int.parse(widget.sessionId),
                                  price: totalToPay
                              ));
                        },
                      )
                    ],
                  ));
                }
                return const CircularProgressIndicator();
              }),
          backgroundColor: lightBlack,
        ));
  }
}
