import 'package:beamer/beamer.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/colors.dart';
import '../../widgets/transparent_button.dart';

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
    print('in sessions page init, ${widget.filmId}');
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
            appBar: AppBar(),
            body: BlocConsumer<SessionsBloc, SessionsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SessionsError) {
                    return const Text('error');
                  } else if (state is SessionsSuccess) {
                    print('in success: $state');
                    final sessions = state.filmSessionsList;
                    if (sessions.isEmpty) {
                      print('in empty');
                      return const Text('Отакої, виникла помилка!');
                    }
                    DateTime now = DateTime.now();
                    int timestampMilliseconds = now.millisecondsSinceEpoch;
                 //   print('now $timestampMilliseconds');
                    int currentTimeStamp =
                        DateTime.now().millisecondsSinceEpoch ~/
                            1000; // поточний час в Unix timestamp
                //    print(currentTimeStamp);
                    List<String> dates = [];
                    for (var i = 0; i < sessions.length; i++) {
                      dates.add(sessions[i].date);
                    }
                    List<String> filteredDates = dates
                        .where((date) => int.parse(date) > currentTimeStamp)
                        .toList(); // фільтруємо дати
                 //   print(filteredDates);
                    filteredDates.sort((a, b) =>
                        a.compareTo(b)); // виводимо відфільтровані дати
                    return Center(
                        child: ListView(children: [
                      for (var i = 0; i < filteredDates.length; i++)
                        //if (sessions[i].date > timestampMilliseconds)
                        TransparentButton(
                            rout:
                                '${widget.detailsPath}?sessionId=${sessions[i].id}',
                            text: DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(filteredDates[i]) * 1000)
                                .toString())
                      //  Text(DateTime.fromMillisecondsSinceEpoch(int.parse(sessions[i].date) * 1000).toString())
                    ]));
                  }
                  return const CircularProgressIndicator();
                }
                ),
            backgroundColor: lightBlack,
        ));
  }
}
