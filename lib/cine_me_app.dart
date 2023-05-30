import 'package:beamer/beamer.dart';
import 'package:cine_me/features/authentication/presentation/bloc/silent_login_bloc.dart';
import 'package:cine_me/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'core/widgets/bottom_nav_bar.dart';

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
      child: BeamerProvider(
        routerDelegate: BeamerDelegate(
          initialPath: '/home',
          locationBuilder: RoutesLocationBuilder(
            routes: {
              '/home': (context, state, data) => const BottomNavBar(),
            },
          ),
        ),
        child: Builder(
          builder: (context) {
            var screen = appFilms;
            if (widget.initScreen is LogIn) {
              screen = appLogIn;
            }
            return screen;
          },
        ),
      ),
    );
  }
}

var appLogIn = const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: LogIn(),
  title: 'CineMe',
);

var appFilms = MaterialApp.router(
  debugShowCheckedModeBanner: false,
  title: 'CineMe',
  routerDelegate: BeamerDelegate(
    initialPath: '/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) => const BottomNavBar()
      },
    ),
  ),
  routeInformationParser: BeamerParser(),
);

