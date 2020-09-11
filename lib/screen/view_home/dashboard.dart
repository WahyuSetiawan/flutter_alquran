import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/screen/view_home/list_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'list_chapter.dart';
import 'setting.dart';

class DashboardPage extends StatefulWidget {
  final ChaptersBloc chaptersBloc;
  final VersesBloc versesBloc;

  DashboardPage({
    Key key,
    this.chaptersBloc,
    this.versesBloc,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget header() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bandung"),
          Text("date"),
        ],
      ),
    );
  }

  Widget lastReading() {
    return GestureDetector(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Last Reading"),
          ],
        ),
      ),
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
        child: Text("List Bookmark"),
      ),
    );
  }

  Widget listChapter() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ListChapterAlQuranPage(
              chaptersBloc: widget.chaptersBloc,
              versesBloc: widget.versesBloc,
            );
          },
        ));
      },
      child: Card(
        child: Text("List Chapter"),
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
        child: Text("Setting"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidgetList = [
      header(),
      lastReading(),
      listChapter(),
      listBookmark(),
      setting(),
    ];

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10, top: 9, bottom: 9),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: listWidgetList.length,
          itemBuilder: (BuildContext context, int index) =>
              listWidgetList[index],
          staggeredTileBuilder: (int index) {
            switch (index) {
              case 0:
                return new StaggeredTile.count(4, .5);
              case 1:
                return new StaggeredTile.count(4, 2);
              default:
                return new StaggeredTile.fit(2);
            }
          },
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      ),
    );
  }
}
