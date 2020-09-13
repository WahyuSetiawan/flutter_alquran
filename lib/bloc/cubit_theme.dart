import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(browseTheme);

  static final lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
    backgroundColor: Color(0xffFFFFDB),
    primaryColor: Color(0xff968251),
    fontFamily: 'roboto',
    textTheme: TextTheme(
      button: TextStyle(
        color: Color(
          0xff0d0d0d,
        ),
      ),
    ),
  );

  static final browseTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
    backgroundColor: Color(0xffFFFFDB),
    primaryColor: Color(0xff968251),
    fontFamily: 'roboto',
    dividerColor: Color(0x88696969),
    textTheme: TextTheme(
      button: TextStyle(
        color: Color(
          0xff0d0d0d,
        ),
      ),
      subtitle1: TextStyle(
        fontFamily: "roboto",
        fontSize: 16,
        color: Color(0xFF545454),
      ),
      subtitle2: TextStyle(
        fontFamily: "roboto",
        fontSize: 14,
        color: Color(0xFF545454),
      ),
      bodyText1: TextStyle(
        fontFamily: "roboto",
        fontSize: 12,
        color: Color(0xFF545454),
      ),
      bodyText2: TextStyle(
        fontFamily: "roboto",
        fontSize: 10,
        letterSpacing: 1,
        color: Color(0xFF545454),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
    backgroundColor: Color(0xeff0f3),
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? lightTheme : darkTheme);
  }
}
