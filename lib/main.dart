import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_home.dart';
import 'package:alquran/bloc/bloc_item_bottom_navigation.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:alquran/bloc/cubit_language.dart';
import 'package:alquran/bloc/cubit_theme.dart';
import 'package:alquran/screen/home.dart';
import 'package:alquran/sharedpreferences/sharedprefrerences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

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
  CubitLangugage _cubitLangugage;
  ThemeCubit _themeCubit;

  @override
  void initState() {
    this._translationsBloc = TranslationsBloc();
    this._translationsBloc.add(HomeProvider());

    this._chapterBloc = ChaptersBloc();

    this._navigationBloc = NavigationBloc();
    this._navigationBloc.add(PageNavigationBar.Dashboard);

    this._cubitBookmark = CubitBookmark();
    this._cubitBookmark.getData();

    this._versesBloc = VersesBloc();

    this._cubitLangugage = CubitLangugage();
    this._cubitLangugage.getLanguageFromApi();

    this._themeCubit = ThemeCubit();

    super.initState();

    Prefs.prefs.getLanguage().then((value) {
      this._cubitLangugage.setCurrentLanguge(value);

      this._chapterBloc.add(ChapterProvider(langugage: value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => this._translationsBloc),
        BlocProvider(create: (context) => this._chapterBloc),
        BlocProvider(create: (context) => this._navigationBloc),
        BlocProvider(create: (context) => this._cubitBookmark),
        BlocProvider(create: (context) => this._themeCubit),
        BlocProvider(create: (context) => this._cubitLangugage),
        BlocProvider(create: (context) => this._versesBloc)
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            title: 'Al Quran',
            theme: theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
