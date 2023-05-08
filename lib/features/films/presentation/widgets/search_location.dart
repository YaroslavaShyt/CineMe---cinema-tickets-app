import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

import '../pages/search_page.dart';



class SearchLocation extends BeamLocation<BeamState> {
  SearchLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    const BeamPage(
      key: ValueKey('search'),
      title: 'Search',
      type: BeamPageType.noTransition,
      child: SearchPage(detailsPath: '/search'),
    ),

  ];
}

