import 'package:cine_me/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:cine_me/features/account/presentation/widgets/account_location.dart';
import 'package:cine_me/features/films/presentation/pages/nested_nav_locations/home_location.dart';
import 'package:cine_me/features/films/presentation/widgets/search_location.dart';



class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() =>
      _BottomNavBarState();
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
    _currentIndex = uriString.contains('/home') ? 0 : 1;
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
        unselectedItemColor: white,
        selectedItemColor: red,
        backgroundColor: lightBlack,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(label: 'Афіша', icon: Icon(Icons.movie_creation_outlined, color: white,)),
          BottomNavigationBarItem(label: 'Пошук', icon: Icon(Icons.search_outlined, color: white,)),
          BottomNavigationBarItem(label: 'Акаунт', icon: Icon(Icons.account_circle, color: white,)),
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