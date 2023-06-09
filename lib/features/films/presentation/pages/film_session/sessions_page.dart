import 'package:beamer/beamer.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/data/models/film_session_model.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';
import 'package:intl/intl.dart';


class SessionsPage extends StatefulWidget {
  final String filmName;
  final String filmId;
  final String detailsPath;
  const SessionsPage({Key? key, required this.filmId, required this.detailsPath, required this.filmName}) : super(key: key);

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  late SessionsBloc sessionsBloc;
  Map<String, dynamic> dateTime = {};

  @override
  void initState() {
    super.initState();
    sessionsBloc = getItInst<SessionsBloc>(
        param1: widget.filmId,
        param2: {'sessionId':'', 'localization': /*context.locale == const Locale('uk', 'UA') ? 'uk' :*/ 'en'}
    );
    sessionsBloc.add(SessionsInitiateEvent(filmId: widget.filmId));
  }

  @override
  void dispose() {
    super.dispose();
    sessionsBloc.close();
  }

  List<FilmSessionModel> filterDates(List<FilmSessionModel> filmDates){
    int currentTimeStamp = DateTime
        .now()
        .millisecondsSinceEpoch ~/ 1000;
    List<FilmSessionModel> dates = [];
    for (var i = 0; i < filmDates.length; i++) {
      dates.add(filmDates[i]);
    }
    List<FilmSessionModel> filteredDates = dates
        .where((date) => int.parse(date.date) > currentTimeStamp)
        .toList();
    filteredDates.sort((a, b) =>
        a.date.compareTo(b.date));
    return filteredDates;
  }

  void processDates(List<FilmSessionModel> filteredDates){
    for (var i = 0; i < filteredDates.length; i++) {
      if (i == 0 ||
          DateTime.fromMillisecondsSinceEpoch(int.parse(filteredDates[i].date) * 1000).day !=
              DateTime.fromMillisecondsSinceEpoch(int.parse(filteredDates[i - 1].date) * 1000).day) {
              dateTime[DateFormat('dd.MM.yyyy').format(DateTime
                  .fromMillisecondsSinceEpoch(int.parse(filteredDates[i].date) * 1000))] = [];
      }
    }
    for (var i = 0; i < filteredDates.length; i++) {
      dateTime[DateFormat('dd.MM.yyyy').format(DateTime
          .fromMillisecondsSinceEpoch(int.parse(filteredDates[i].date) * 1000))]
          .add(OutlinedButton(
        onPressed: () {
          Beamer.of(context).beamToNamed('${widget.detailsPath}?sessionId=${filteredDates[i].id}&filmName=${widget.filmName}');
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: red,),
        child: Text(
            DateFormat('HH:mm').format(DateTime
                .fromMillisecondsSinceEpoch(int.parse(filteredDates[i].date) * 1000)),
            style: const TextStyle(fontSize: 18, color: white)
        ),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => sessionsBloc)],
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Назад'),
              backgroundColor: lightBlack,
              shadowColor: Colors.transparent,
            ),
            body: BlocConsumer<SessionsBloc, SessionsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SessionsError) {
                    return const ErrorPage();
                  } else if (state is SessionsSuccess) {
                    final sessions = state.filmSessionsList;
                    if (sessions.isEmpty) {
                      return const ErrorPage();
                    }
                   var filteredDates = filterDates(sessions);
                    processDates(filteredDates);
                    return ListView(
                      children: [
                        for (var entry in dateTime.entries)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(entry.key, style: notoSansDisplayRegularSmall,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: entry.value.cast<Widget>()),
                              const SizedBox(height: 50,)
                            ],
                          ),
                      ],
                    );
                  }
    return const Center(child: CircularProgressIndicator(color: white,));
                }
                ),
            backgroundColor: lightBlack,
        ));
  }
}
