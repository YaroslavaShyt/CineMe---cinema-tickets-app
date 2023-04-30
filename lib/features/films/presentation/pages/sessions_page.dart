import 'package:cine_me/core/getit/get_it.dart';
import 'package:cine_me/features/films/presentation/bloc/sessions_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionsPage extends StatefulWidget {
  final String filmId;
  const SessionsPage({Key? key, required this.filmId}) : super(key: key);

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
    sessionsBloc.add(SessionsInitiateEvent(widget.filmId));
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
        }
        else if (state is SessionsSuccess){
          print('in success: $state');
          final sessions = state.filmSessionsList;
          if (sessions.isEmpty){
            print('in empty');
            return const Text('Отакої, виникла помилка!');
          }
          return Center(child: Text(widget.filmId));
        }
        return const CircularProgressIndicator();
      }
      )
    )
    );
  }
}
