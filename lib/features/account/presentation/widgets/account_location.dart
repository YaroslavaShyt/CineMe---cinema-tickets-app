import 'package:cine_me/features/account/presentation/pages/account_page.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';



class AccountLocation extends BeamLocation<BeamState> {
  AccountLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/*'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
    const BeamPage(
      key: ValueKey('account'),
      title: 'Account',
      type: BeamPageType.noTransition,
      child: AccountPage(detailsPath: '/account'),
    ),

  ];
}


