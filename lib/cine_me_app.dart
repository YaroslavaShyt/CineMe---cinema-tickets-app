import 'package:cine_me/features/authentification/presentation/bloc/silent_login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/getit/get_it.dart';

class CineMe extends StatefulWidget {
  final initScreen;
  const CineMe({Key? key, required this.initScreen}) : super(key: key);

  @override
  State<CineMe> createState() => _CineMeState();
}

class _CineMeState extends State<CineMe> {
  late SilentLoginBloc _silentLoginBloc;

  @override
  void initState() {
    super.initState();
    _silentLoginBloc = getItInst<SilentLoginBloc>();
  }


  @override
  void dispose() {
    _silentLoginBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<SilentLoginBloc>.value(
        value: _silentLoginBloc,
      ),],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CineMe',
        home: widget.initScreen
      ),
    );
  }
}
