import 'package:beamer/beamer.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/book_ticket/book_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/seats.dart';
import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/session_details_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/custom_red_button.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/screen_painter.dart';


class SessionDetails extends StatefulWidget {
  final String filmName;
  final String detailsPath;
  final String sessionId;
  const SessionDetails(
      {Key? key, required this.sessionId, required this.detailsPath, required this.filmName})
      : super(key: key);

  @override
  State<SessionDetails> createState() => _SessionDetailsState();
}

class _SessionDetailsState extends State<SessionDetails> {
  late final SessionsBloc sessionsBloc;
  late final BookTicketBloc bookTicketBloc;
  List<int> seats = [];
  List<int> seatsNumbers = [];
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

  void _onSeatPressed(int seatId, int seatNumber, int price) {
    setState(() {
      if (seats.contains(seatId)) {
        seats.remove(seatId);
        seatsNumbers.remove(seatNumber);
        totalToPay -= price;
      } else {
        seats.add(seatId);
        seatsNumbers.add(seatNumber);
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
                              Beamer.of(context).beamToNamed('${widget.detailsPath}?'
                                  'filmName=${widget.filmName}&'
                                  'sessionId=${widget.sessionId}&'
                                  'seats=${seats.join(',')}&'
                                  'totalToPay=$totalToPay&'
                                  'cinemaName=${session[0].room['name']}&'
                                  'type=${session[0].type}&'
                                  'date=${session[0].date}');
                            }
                          },
                        ),
                      ],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SessionDetailsHead(date: session[0].date, type: session[0].type, name: session[0].room['name']),
                          const SeatTypesRow(),
                          CustomPaint(
                            painter: UpwardArcPainter(),
                            child: const SizedBox(
                              height: 50,
                              width: double.maxFinite,
                              child: Center(
                                  child: Text('Екран',
                                style: notoSansDisplayRegularTiny,
                              )),
                            ),
                          ),
                          Center(child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Seats(
                                seats: session,
                                onSeatPressed: _onSeatPressed,
                              ))),
                          SessionDetailsTail(seatsNumbers: seatsNumbers, totalToPay: totalToPay),
                          Padding(padding: const EdgeInsets.only(left: 20, right: 20),
                              child: CustomButton(
                                text: 'Обрати',
                                onPressed: () {
                                  context.read<BookTicketBloc>().add(
                                      BookTicketInitiateEvent(
                                          seats: seats,
                                          sessionId:
                                              int.parse(widget.sessionId),
                                          price: totalToPay));
                                },
                              ))
                        ],
                      ));
                }
                return const Center(
                    child: CircularProgressIndicator(color: white));
              }),
          backgroundColor: lightBlack,
        ));
  }
}
