import 'package:ecommerce_app/models/dark_theme_preferences.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider extends ChangeNotifier{
  DarkThemePreferences ddarkThemePreferences = DarkThemePreferences();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkThemee(bool value){
    ddarkThemePreferences.setDarkTheme(value);
    _darkTheme = value;
    notifyListeners();
  }
}