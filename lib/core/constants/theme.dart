import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


ThemeData light = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    primaryColorLight: Colors.white
);

ThemeData dark = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  primaryColorLight: Colors.white,
);


class ThemeProvider extends ChangeNotifier{
  late ThemeData _selectedTheme;



  ThemeProvider({required bool isDarkMode}){
    _selectedTheme = isDarkMode ? dark : light;
  }

  Future<void> swapTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs.setBool("isDarkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs.setBool("isDarkTheme", true);
    }
    notifyListeners();
  }

  ThemeData get getTheme => _selectedTheme;

}