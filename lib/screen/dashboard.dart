import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:alquran/bloc/cubit_last_reading.dart';
import 'package:alquran/screen/search.dart';
import 'package:alquran/screen/list_bookmark.dart';
import 'package:alquran/screen/verse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

import 'view_home/../list_chapter.dart';
import 'view_home/../setting.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({
    Key key,
    CubitBookmark bookmarkCubit,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var dateFormat = DateFormat.yMd();

  Widget header() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dateFormat.format(DateTime.now()).toString(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          // GestureDetector(
          //   child: Icon(
          //     Icons.search,
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) {
          //         return SearchPage();
          //       },
          //     ));
          //   },
          // )
          Container()
        ],
      ),
    );
  }

  Widget lastReading(BuildContext context) {
    return BlocBuilder<CubitLastReading, LastReadingState>(
      builder: (context, state) {
        int chapterId;
        int numberVerse;

        if (state is SuccessChangeLastReadingState) {
          if (state.chapterId != null && state.numberVerse != null) {
            chapterId = state.chapterId;
            numberVerse = state.numberVerse;
          }

          return GestureDetector(
            onTap: () {
              var index = context
                  .bloc<ChaptersBloc>()
                  .chaptersModel
                  .chapters
                  .indexWhere((element) => element.id == state.chapterId);

              if (index >= 0) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return PageVerses(
                      chapter_id: context
                          .bloc<ChaptersBloc>()
                          .chaptersModel
                          .chapters[index],
                      column_number: state.numberVerse,
                    );
                  },
                ));
              }
            },
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFE3D764),
                ),
                child: ListTile(
                  title:
                      Text("Last Reading Chapter ${chapterId}:${numberVerse}"),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget listBookmark() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ListBookmarkPage();
          },
        ));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE3D764),
          ),
          height: 150,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List Bookmark",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Expanded(child: Stack())
            ],
          ),
        ),
      ),
    );
  }

  Widget listChapter() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ListChapterAlQuranPage();
          },
        ));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE3D764),
          ),
          height: 150,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "List Chapter",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Expanded(child: Stack())
            ],
          ),
        ),
      ),
    );
  }

  Widget setting() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SettingPage();
          },
        ));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFE3D764),
          ),
          height: 150,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Setting",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Expanded(child: Stack())
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgetList = [
      header(),
      lastReading(context),
      listChapter(),
      listBookmark(),
      setting(),
    ];

    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 9, bottom: 9),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: listWidgetList.length,
        itemBuilder: (BuildContext context, int index) => listWidgetList[index],
        staggeredTileBuilder: (int index) {
          switch (index) {
            case 0:
              return new StaggeredTile.fit(4);
              break;
            case 1:
              return new StaggeredTile.fit(4);
              break;
            default:
              return new StaggeredTile.fit(2);
          }
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
