import 'package:beamer/beamer.dart';
import 'package:cine_me/core/get_it/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/carousel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:cine_me/features/films/presentation/bloc/book_ticket/book_ticket_bloc.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/seat_types_row.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/screen_painter.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/session_details_tail.dart';
import 'package:cine_me/core/widgets/custom_button.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/seats.dart';
import 'package:cine_me/features/films/presentation/widgets/film_session_page_widgets/session_details_widgets.dart';

class SessionsPage extends StatefulWidget {
  final String filmName;
  final String filmId;
  final String detailsPath;
  const SessionsPage(
      {Key? key,
      required this.filmId,
      required this.detailsPath,
      required this.filmName})
      : super(key: key);

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  late SessionsBloc sessionsBloc;
  late final BookTicketBloc bookTicketBloc;
  List<int> seats = [];
  List<int> seatsNumbers = [];
  int totalToPay = 0;
  int selectedSessionIndex = 0;

  Map<String, dynamic> dateTime = {};

  @override
  void initState() {
    super.initState();
    sessionsBloc = getItInst<SessionsBloc>();
    sessionsBloc.add(SessionsInitiateEvent(filmId: widget.filmId));
    bookTicketBloc = getItInst<BookTicketBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    sessionsBloc.close();
  }

  List<FilmSessionModel> filterDates(List<FilmSessionModel> filmDates) {
    int currentTimeStamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    List<FilmSessionModel> dates = [];
    for (var i = 0; i < filmDates.length; i++) {
      dates.add(filmDates[i]);
    }
    List<FilmSessionModel> filteredDates =
        dates.where((date) => int.parse(date.date) > currentTimeStamp).toList();
    filteredDates.sort((a, b) => a.date.compareTo(b.date));
    return filteredDates;
  }

  void processDates(List<FilmSessionModel> filteredDates) {
    for (var i = 0; i < filteredDates.length; i++) {
      if (i == 0 ||
          DateTime.fromMillisecondsSinceEpoch(
                      int.parse(filteredDates[i].date) * 1000)
                  .day !=
              DateTime.fromMillisecondsSinceEpoch(
                      int.parse(filteredDates[i - 1].date) * 1000)
                  .day) {
        dateTime[DateFormat('dd.MM.yyyy').format(
            DateTime.fromMillisecondsSinceEpoch(
                int.parse(filteredDates[i].date) * 1000))] = [];
      }
    }
    for (var i = 0; i < filteredDates.length; i++) {
      dateTime[DateFormat('dd.MM.yyyy').format(
              DateTime.fromMillisecondsSinceEpoch(
                  int.parse(filteredDates[i].date) * 1000))]
          .add(
        OutlinedButton(
          onPressed: () {
            Beamer.of(context).beamToNamed(
                '${widget.detailsPath}?sessionId=${filteredDates[i].id}&filmName=${widget.filmName}');
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: red,
          ),
          child: Text(
              DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                  int.parse(filteredDates[i].date) * 1000)),
              style: const TextStyle(fontSize: 18, color: white)),
        ),
      );
    }
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
            title: Text(
              '${widget.filmName} - ${"sessions".tr().toString()}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            backgroundColor: const Color.fromRGBO(73, 71, 167, 100),
            shadowColor: Colors.transparent,
          ),
          body: BlocConsumer<SessionsBloc, SessionsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SessionsError) {
                  return const ErrorPage();
                } else if (state is SessionsSuccess) {
                  final sessions = state.filmSessionsList;
                  var filteredDates = filterDates(sessions);
                  processDates(filteredDates);
                  return ListView(
                    children: [
                      const SizedBox(height: 20),
                      Carousel(
                        filmSessionModels: filteredDates,
                        onRocketChanged: (value) {
                          setState(() {
                            selectedSessionIndex = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SessionDetailsHead(
                          date: filteredDates[selectedSessionIndex].date,
                          type: filteredDates[selectedSessionIndex].type,
                          name:
                              filteredDates[selectedSessionIndex].room['name']),
                      const SizedBox(
                        height: 10,
                      ),
                      const SeatTypesRow(),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomPaint(
                        painter: UpwardArcPainter(),
                        child: SizedBox(
                          height: 50,
                          width: double.maxFinite,
                          child: Center(
                              child: Text(
                            "screen".tr().toString(),
                            style: notoSansDisplayRegularTiny,
                          )),
                        ),
                      ),
                      Center(
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Seats(
                                seats: filteredDates[selectedSessionIndex],
                                onSeatPressed: _onSeatPressed,
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      SessionDetailsTail(
                          seatsNumbers: seatsNumbers, totalToPay: totalToPay),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: CustomButton(
                            text: "pay".tr().toString(),
                            onPressed: () {
                              bookTicketBloc.add(BookTicketInitiateEvent(
                                  seats: seats,
                                  sessionId: int.parse(
                                      filteredDates[selectedSessionIndex].id),
                                  price: totalToPay));
                            },
                          )),
                      BlocListener<BookTicketBloc, BookTicketState>(
                        listener: (context, state) {
                          if (state is BookTicketSuccess) {
                            Beamer.of(context).beamToNamed(
                                '${widget.detailsPath}?'
                                'filmName=${widget.filmName}&'
                                'sessionId=${filteredDates[selectedSessionIndex].id}&'
                                'seats=${seats.join(',')}&'
                                'totalToPay=$totalToPay&'
                                'cinemaName=${filteredDates[selectedSessionIndex].room['name']}&'
                                'type=${filteredDates[selectedSessionIndex].type}&'
                                'date=${filteredDates[selectedSessionIndex].date}');
                          }
                        },
                        child: const SizedBox(
                          height: 20,
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                    child: CircularProgressIndicator(
                  color: white,
                ));
              }),
        ));
  }
}
