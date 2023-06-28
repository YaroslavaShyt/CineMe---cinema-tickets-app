import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'CineMe',
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color:  Provider.of<ThemeProvider>(context).getTheme.primaryColorLight),
    );
  }
}