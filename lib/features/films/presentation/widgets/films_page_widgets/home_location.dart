import 'package:cine_me/features/films/presentation/pages/buy_ticket/buy_ticket_page.dart';
import 'package:cine_me/features/films/presentation/pages/films/film_details_page.dart';
import 'package:cine_me/features/films/presentation/pages/session/sessions_page.dart';
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
          child: FilmsPage(
            detailsPath: '/home/details',
          ),
        ),
        if (state.uri.pathSegments.length == 2 &&
            state.uri.pathSegments[0] == 'home' &&
            state.uri.pathSegments[1] == 'details')
          BeamPage(
            key: const ValueKey('/home/details'),
            title: 'Details A',
            child: FilmDetails(
                filmName: state.queryParameters['filmName'] ?? '',
                detailsPath: '/home/details/sessions'),
          )
        else if (state.uri.pathSegments.length == 3 &&
            state.uri.pathSegments[0] == 'home' &&
            state.uri.pathSegments[1] == 'details' &&
            state.uri.pathSegments[2] == 'sessions')
          BeamPage(
              key: const ValueKey('/home/details/sessions'),
              child: SessionsPage(
                  filmId: state.queryParameters['filmId'] ?? '',
                  filmName: state.queryParameters['filmName'] ?? '',
                  detailsPath: '/home/details/sessions/buyticket'))
        else if (state.uri.pathSegments.length == 4 &&
            state.uri.pathSegments[0] == 'home' &&
            state.uri.pathSegments[1] == 'details' &&
            state.uri.pathSegments[2] == 'sessions' &&
            state.uri.pathSegments[3] == 'buyticket')
          BeamPage(
            key: const ValueKey('/home/details/sessions/buyticket'),
            child: BuyTicketPage(
              cinemaName: state.queryParameters['cinemaName'] ?? '',
              filmName: state.queryParameters['filmName'] ?? '',
              date: state.queryParameters['date'] ?? '',
              type: state.queryParameters['type'] ?? '',
              totalToPay: int.parse(state.queryParameters['totalToPay']!),
              detailsPath: 'home/details/sessions/buyticket',
              sessionId: int.parse(state.queryParameters['sessionId']!),
              seats: state.queryParameters['seats']?.split(',').map((e) => int.parse(e)).toList() ?? [0],
            )
          )
      ];
}
