import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_home.dart';
import 'package:alquran/bloc/bloc_item_bottom_navigation.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/screen/view_home/last_reading.dart';
import 'package:alquran/screen/view_home/list_chapter.dart';
import 'package:alquran/screen/view_home/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'view_home/dashboard.dart';
import 'view_home/list_chapter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomePage> {
  TranslationsBloc _translationsBloc;
  ChaptersBloc _chapterBloc;
  NavigationBloc _navigationBloc;
  VersesBloc _versesBloc;

  @override
  void initState() {
    this._translationsBloc = TranslationsBloc();
    this._translationsBloc.add(HomeProvider());

    this._chapterBloc = ChaptersBloc();
    this._chapterBloc.add(ChapterProvider());

    this._navigationBloc = NavigationBloc();
    this._navigationBloc.add(PageNavigationBar.Dashboard);

    this._versesBloc = VersesBloc();

    super.initState();
  }

  BottomNavigationBar bottomNavigation(PageNavigationBar pageNavigationBar) {
    return BottomNavigationBar(
      currentIndex: PageNavigationBar.values.indexOf(pageNavigationBar),
      onTap: (value) {
        this._navigationBloc.add(PageNavigationBar.values[value]);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          title: Text("Dashboard"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.home),
          title: Text("home"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.adobe),
          title: Text("Last Reading"),
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.addressBook),
          title: Text("Setting"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => this._translationsBloc,
          ),
          BlocProvider(
            create: (context) => this._chapterBloc,
          ),
          BlocProvider(
            create: (context) => this._navigationBloc,
          ),
          BlocProvider(
            create: (context) => this._versesBloc,
          )
        ],
        child: BlocBuilder<NavigationBloc, PageNavigationBar>(
          builder: (context, pageNavigationBar) => Scaffold(
            body: IndexedStack(
              index: PageNavigationBar.values.indexOf(pageNavigationBar),
              children: [
                DashboardPage(
                  chaptersBloc: this._chapterBloc,
                  versesBloc: this._versesBloc,
                ),
                ListChapterAlQuranPage(
                  chaptersBloc: this._chapterBloc,
                  versesBloc: this._versesBloc,
                ),
                PageLastReading(),
                SettingPage(),
              ],
            ),
            // bottomNavigationBar: bottomNavigation(pageNavigationBar),
          ),
        ));
  }
}
