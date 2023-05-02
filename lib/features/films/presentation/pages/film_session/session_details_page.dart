import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/book_ticket/book_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/dialog.dart';
import 'package:cine_me/features/films/presentation/widgets/seats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/presentation/widgets/error_widget.dart';

import '../../widgets/transparent_button.dart';

class SessionDetails extends StatefulWidget {
  final String sessionId;
  const SessionDetails({Key? key, required this.sessionId}) : super(key: key);

  @override
  State<SessionDetails> createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  late final SessionsBloc sessionsBloc;
  late final BookTicketBloc bookTicketBloc;
  List<int> seats = [];

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

  void _onSeatPressed(int seatNumber) {
    setState(() {
      if (seats.contains(seatNumber)) {
        seats.remove(seatNumber);
      } else {
        seats.add(seatNumber);
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
                    return const CustomErrorWidget(
                        errorName: 'Отакої, жодного фільму не знайдено :(');
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
                                    result1:
                                    state.isTicketBooked.success.toString(),
                                    result2: state.isTicketBooked.data.toString(),
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                      child:ListView(
                    children: [
                      Text(
                        'Обрано: ${seats.toString()}',
                        style: const TextStyle(color: white),
                      ),
                      const Text('Оберіть місце'),
                      Seats(
                        seats: session,
                        onSeatPressed: _onSeatPressed,
                      ),

                      TransparentButton(
                        text: 'Обрати',
                        onPressed: () {
                          context.read<BookTicketBloc>().add(
                              BookTicketInitiateEvent(
                                  seats: seats,
                                  sessionId: int.parse(widget.sessionId)));
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
