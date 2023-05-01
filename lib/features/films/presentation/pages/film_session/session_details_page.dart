import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/film_session/sessions_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    sessionsBloc = getItInst<SessionsBloc>(param1: '', param2: widget.sessionId);
    sessionsBloc.add(SessionsInitiateEvent(filmId:'', sessionId: widget.sessionId));
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
                      return const CustomErrorWidget(errorName: 'Отакої, жодного фільму не знайдено :(');
                    }
                    return ListView(
                        children: [
                          const Text('Оберіть місце'),
                          Seats(seats: session),
                          const TransparentButton(text: 'Обрати',),
                        ],

                    );
                  }
                  return const CircularProgressIndicator();
                }
                ),
          backgroundColor: lightBlack,
        )
    );
  }
}
