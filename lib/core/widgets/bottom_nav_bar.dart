import 'package:cine_me/core/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:cine_me/features/account/presentation/widgets/account_location.dart';
import 'package:cine_me/features/films/presentation/widgets/films_page_widgets/home_location.dart';
import 'package:cine_me/features/films/presentation/widgets/search_page_widgets/search_location.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex;

  final _routerDelegates = [
    BeamerDelegate(
      initialPath: '/home',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/home')) {
          return HomeLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/search',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/search')) {
          return SearchLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/account',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('/account')) {
          return AccountLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    _currentIndex = uriString.contains('/home')
        ? 0
        : uriString.contains('/search')
            ? 1
            : 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Beamer(
            routerDelegate: _routerDelegates[0],
          ),
          Beamer(
            routerDelegate: _routerDelegates[1],
          ),
          Beamer(
            routerDelegate: _routerDelegates[2],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(73, 71, 157, 10),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              label: "poster".tr().toString(),
              icon: const Icon(
                Icons.movie_creation_outlined,
                color: white,
              )),
          BottomNavigationBarItem(
              label: "search".tr().toString(),
              icon: const Icon(
                Icons.search_outlined,
                color: white,
              )),
          BottomNavigationBarItem(
              label: "tickets".tr().toString(),
              icon: const Icon(
                Icons.account_circle,
                color: white,
              )),
        ],
        onTap: (index) {
          if (index != _currentIndex) {
            setState(() => _currentIndex = index);
            _routerDelegates[_currentIndex].update(rebuild: false);
          }
        },
      ),
    );
  }
}
