import 'package:alquran/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            title: 'Al Quran',
            theme: ThemeCubit._browseTheme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
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

  static final _browseTheme = ThemeData(
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
    ),
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
    backgroundColor: Color(0xeff0f3),
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}
