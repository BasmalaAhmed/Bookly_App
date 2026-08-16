import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  static const String _themeKey = 'theme_mode';

  Future <void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme = prefs.getString(_themeKey);

    if (savedTheme == 'dark'){
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  Future <void> toggleTheme() async {
    final newTheme = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    emit(newTheme);

    final prefs = await SharedPreferences.getInstance(); 

    await prefs.setString(_themeKey, newTheme == ThemeMode.dark ? 'dark' : 'light' ,);
  }
}
