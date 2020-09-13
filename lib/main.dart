import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_home.dart';
import 'package:alquran/bloc/bloc_item_bottom_navigation.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:alquran/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TranslationsBloc _translationsBloc;
  ChaptersBloc _chapterBloc;
  NavigationBloc _navigationBloc;
  CubitBookmark _cubitBookmark;
  VersesBloc _versesBloc;

  @override
  void initState() {
    this._translationsBloc = TranslationsBloc();
    this._translationsBloc.add(HomeProvider());

    this._chapterBloc = ChaptersBloc();
    this._chapterBloc.add(ChapterProvider());

    this._navigationBloc = NavigationBloc();
    this._navigationBloc.add(PageNavigationBar.Dashboard);

    this._cubitBookmark = CubitBookmark();
    this._cubitBookmark.getData();

    this._versesBloc = VersesBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => this._translationsBloc),
        BlocProvider(create: (context) => this._chapterBloc),
        BlocProvider(create: (context) => this._navigationBloc),
        BlocProvider(create: (context) => this._cubitBookmark),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => this._versesBloc)
      ],
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
