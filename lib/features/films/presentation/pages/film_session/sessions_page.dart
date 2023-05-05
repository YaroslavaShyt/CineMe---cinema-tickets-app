import 'package:beamer/beamer.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/core/widgets/error_widget.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/constants/colors.dart';
import 'package:cine_me/core/constants/font_styling.dart';


class SessionsPage extends StatefulWidget {
  final String filmId;
  final String detailsPath;
  const SessionsPage({Key? key, required this.filmId, required this.detailsPath}) : super(key: key);

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
  late SessionsBloc sessionsBloc;

  @override
  void initState() {
    super.initState();
    sessionsBloc = getItInst<SessionsBloc>(param1: widget.filmId, param2: '');
    sessionsBloc.add(SessionsInitiateEvent(filmId: widget.filmId));
  }

  @override
  void dispose() {
    super.dispose();
    sessionsBloc.close();
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
                    int currentTimeStamp = DateTime
                        .now()
                        .millisecondsSinceEpoch ~/ 1000;
                    List<String> dates = [];
                    for (var i = 0; i < sessions.length; i++) {
                      dates.add(sessions[i].date);
                    }
                    List<String> filteredDates = dates
                        .where((date) => int.parse(date) > currentTimeStamp)
                        .toList();
                    filteredDates.sort((a, b) =>
                        a.compareTo(b));
                    return ListView(
                      children: [
                        for (var i = 0; i < filteredDates.length; i++)
                          if (i == 0 ||
                              DateTime.fromMillisecondsSinceEpoch(int.parse(filteredDates[i]) * 1000).day !=
                                  DateTime.fromMillisecondsSinceEpoch(int.parse(filteredDates[i - 1]) * 1000).day)
                                Column(children: [Padding(
                                    padding: const EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                  '${DateTime
                                      .fromMillisecondsSinceEpoch(int.parse(filteredDates[i]) * 1000)
                                      .day}'
                                      '.${DateTime
                                      .fromMillisecondsSinceEpoch(int.parse(filteredDates[i]) * 1000)
                                      .month}'
                                      '.${DateTime
                                      .fromMillisecondsSinceEpoch(int.parse(filteredDates[i]) * 1000)
                                      .year}\n',
                                  style: notoSansDisplayRegularSmall,
                                )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var j = 0; j < sessions.length; j++)
                                        if (sessions[j].date == filteredDates[i])
                                          OutlinedButton(
                                            onPressed: () {
                                              Beamer.of(context).beamToNamed('${widget.detailsPath}?sessionId=${sessions[j].id}');
                                            },
                                            style: OutlinedButton.styleFrom(
                                              backgroundColor: red,),
                                            child: Text(
                                              '${DateTime
                                                  .fromMillisecondsSinceEpoch(int.parse(sessions[j].date) * 1000)
                                                  .hour}'
                                                  ':${DateTime
                                                  .fromMillisecondsSinceEpoch(int.parse(sessions[j].date) * 1000)
                                                  .minute}',
                                                style: const TextStyle(fontSize: 18, color: white)
                                            ),
                                          ),
                                    ],
                                  ),
                                ])
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var j = 0; j < sessions.length; j++)
                                  if (sessions[j].date == filteredDates[i])
                                    OutlinedButton(
                                      onPressed: () {
                                        Beamer.of(context).beamToNamed('${widget.detailsPath}?sessionId=${sessions[j].id}');
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: red,),
                                      child: Text(
                                        '${DateTime
                                            .fromMillisecondsSinceEpoch(int.parse(sessions[j].date) * 1000)
                                            .hour}'
                                            ':${DateTime
                                            .fromMillisecondsSinceEpoch(int.parse(sessions[j].date) * 1000)
                                            .minute}',
                                        style: const TextStyle(fontSize: 18, color: white),
                                      ),
                                    ),
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
