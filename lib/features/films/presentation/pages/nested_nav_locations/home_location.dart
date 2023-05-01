import 'package:cine_me/features/films/presentation/pages/films/film_details_page.dart';
import 'package:cine_me/features/films/presentation/pages/film_session/session_details_page.dart';
import 'package:cine_me/features/films/presentation/pages/film_session/sessions_page.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/presentation/pages/films/films_page.dart';


class HomeLocation extends BeamLocation<BeamState> {
  HomeLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    const BeamPage(
      key: ValueKey('home'),
      title: 'Tab Home',
      type: BeamPageType.noTransition,
      child: FilmsPage(detailsPath: '/home/details',),
    ),
    if (state.uri.pathSegments.length == 2  && state.uri.pathSegments[0] == 'home' && state.uri.pathSegments[1] == 'details')
        BeamPage(
        key: ValueKey('home/details'),
        title: 'Details A',
        child: FilmDetails(filmName: state.queryParameters['filmName'] ?? '', detailsPath: '/home/details/sessions'),
      )
    else if (state.uri.pathSegments.length == 3 &&
        state.uri.pathSegments[0] == 'home' &&
        state.uri.pathSegments[1] == 'details' && state.uri.pathSegments[2] == 'sessions')
      BeamPage(
          key:  ValueKey('home/details/sessions'),
          child: SessionsPage(filmId: state.queryParameters['filmId'] ?? '', detailsPath: '/home/details/sessions/session')
      )
    else if (state.uri.pathSegments.length == 4 &&
        state.uri.pathSegments[0] == 'home' && state.uri.pathSegments[1] == 'details'
          && state.uri.pathSegments[2] == 'sessions' && state.uri.pathSegments[3] == 'session')
      BeamPage(
      key:  ValueKey('home/details/sessions/session'),
      child: SessionDetails(sessionId: state.queryParameters['sessionId']?.toString() ?? '')
      ),
  ];
}