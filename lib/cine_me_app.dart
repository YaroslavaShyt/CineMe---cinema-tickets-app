import 'package:beamer/beamer.dart';
import 'package:cine_me/core/constants/theme.dart';
import 'package:cine_me/features/authentication/presentation/bloc/silent_login_bloc.dart';
import 'package:cine_me/features/authentication/presentation/pages/login_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cine_me/core/getit/get_it.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CineMe extends StatefulWidget {
  final initScreen;
  const CineMe({Key? key, required this.initScreen}) : super(key: key);

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
/*
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<SilentLoginBloc>.value(
          value: _silentLoginBloc,
        ),],
      child: BeamerProvider(
        routerDelegate: BeamerDelegate(
          initialPath: '/',
          locationBuilder: RoutesLocationBuilder(
            routes: {
              '/': (context, state, data) => const BottomNavBar(),
              '/home': (context, state, data) => const BottomNavBar(),
              '*': (context, state, data) => const BottomNavBar(),
            },
          ),
        ),
        child: MaterialApp(
          onGenerateRoute:(settings) {
            // Отримайте назву маршруту
            final String? name = settings.name;

            // Обробка генерації маршрутів
            if (name == '/example') {
              // Поверніть відповідний об'єкт типу Route, наприклад MaterialPageRoute
              return MaterialPageRoute(
                builder: (BuildContext context) {
                  // Поверніть відповідний віджет для маршруту
                  return ExamplePage();
                },
              );
            }

            // Поверніть null, якщо маршрут не знайдено
            return null;
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
 //   routeInformationParser: BeamerParser(),
    routerDelegate: BeamerDelegate(
    initialPath: '/',
    locationBuilder: RoutesLocationBuilder(
    routes: {
    '*': (context, state, data) => const BottomNavBar(),
    },
    ),
    ),
    debugShowCheckedModeBanner: false,
    title: 'CineMe',

        /*MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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
        )*/
//Builder(
       //   builder: (context) {
       //     var screen = appFilms;
        //    if (widget.initScreen is LogIn) {
        //      screen = appLogIn;
       //     }
       //     return screen;
     //     },
        ),
      ));
  }
}*/

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
