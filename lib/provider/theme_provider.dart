import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  Color primary = colorCustom;
  Color accent = Colors.white;
  Color secondary = Colors.black;
  bool darkThemeValue = false;

  void activateDarkTheme(bool value) async {
    final _pref = await SharedPreferences.getInstance();
    _pref.setBool("DarkTheme", value);

    if (value == true) {
      accent = Colors.black;
      secondary = Colors.white;
    } else {
      accent = Colors.white;
      secondary = Colors.black;
    }
    darkThemeValue = value;
    notifyListeners();
  }
}

Map<int, Color> color = {
  50: Color.fromRGBO(255, 92, 87, .1),
  100: Color.fromRGBO(255, 92, 87, .2),
  200: Color.fromRGBO(255, 92, 87, .3),
  300: Color.fromRGBO(255, 92, 87, .4),
  400: Color.fromRGBO(255, 92, 87, .5),
  500: Color.fromRGBO(255, 92, 87, .6),
  600: Color.fromRGBO(255, 92, 87, .7),
  700: Color.fromRGBO(255, 92, 87, .8),
  800: Color.fromRGBO(255, 92, 87, .9),
  900: Color.fromRGBO(255, 92, 87, 1),
};
MaterialColor colorCustom = MaterialColor(0xFFFF481A, color);
