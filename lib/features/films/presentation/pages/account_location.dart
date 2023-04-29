import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';



class BLocation extends BeamLocation<BeamState> {
  BLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    const BeamPage(
      key: ValueKey('account'),
      title: 'Account',
      type: BeamPageType.noTransition,
      child: RootScreen(),
    ),

  ];
}

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('this is account(rout)'));
  }
}
