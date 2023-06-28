import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/theme.dart';
import 'package:cine_me/features/authentication/presentation/bloc/silent_login_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cine_me/core/get_it/get_it.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CineMe extends StatefulWidget {
  final initScreen;
  final userExists;
  const CineMe({Key? key, required this.initScreen, required this.userExists}) : super(key: key);

  @override
  State<CineMe> createState() => _CineMeState();
}

class _CineMeState extends State<CineMe> {
  late SilentLoginBloc _silentLoginBloc;
  final routerDelegate = BeamerDelegate(
      initialPath: '/home',
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '*': (context, state, data) => const BottomNavBar(),
        },
      )
  );

  @override
  void initState() {
    super.initState();
    _silentLoginBloc = getItInst<SilentLoginBloc>();
    if(!widget.userExists) _silentLoginBloc.add(const SilentLoginInitiateEvent());
  }


  @override
  void dispose() {
    _silentLoginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, value, child){
      return MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'CineMe',
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerParser(),
        theme: value.getTheme,
      );
    }
    );

  }
}

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
