import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_home.dart';
import 'package:alquran/bloc/bloc_item_bottom_navigation.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomePage> {
  TranslationsBloc _translationsBloc;
  ChaptersBloc _chapterBloc;
  NavigationBloc _navigationBloc;

  @override
  void initState() {
    this._translationsBloc = TranslationsBloc();
    this._translationsBloc.add(HomeProvider());

    this._chapterBloc = ChaptersBloc();
    this._chapterBloc.add(ChapterProvider());

    this._navigationBloc = NavigationBloc();
    this._navigationBloc.add(PageNavigationBar.Home);

    super.initState();
  }

  Widget listChapters(ChaptersModel chaptersModel) {
    return ListView.builder(
      itemCount: chaptersModel.chapters.length,
      itemBuilder: (context, index) {
        return Container(child: Text(chaptersModel.chapters[index].nameSimple));
      },
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
          )
        ],
        child: BlocBuilder<NavigationBloc, PageNavigationBar>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text("Home Alquran"),
            ),
            body: Container(
              child: BlocBuilder<ChaptersBloc, ChaptersState>(
                builder: (context, state) {
                  if (state is SuccessGetteringChapters) {
                    return listChapters(state.chaptersModel);
                  }

                  return Text("loading");
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: PageNavigationBar.values.indexOf(state),
              onTap: (value) {
                print(PageNavigationBar.values[value].toString());

                this._navigationBloc.add(PageNavigationBar.values[value]);
              },
              items: [
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
            ),
          ),
        ));
  }
}
