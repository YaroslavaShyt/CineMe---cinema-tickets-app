import 'package:cine_me/features/films/presentation/pages/film_details_page.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:cine_me/features/films/presentation/pages/films_page.dart';


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
    if (state.uri.pathSegments.length == 2)
      const BeamPage(
        key: ValueKey('home/details'),
        title: 'Details A',
        child: FilmDetails(),
      )
  ];
}