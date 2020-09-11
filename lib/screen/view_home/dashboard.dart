import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/screen/view_home/list_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

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
                "Bandung",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                dateFormat.format(DateTime.now()).toString(),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget lastReading() {
    return GestureDetector(
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
                "Last reading",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Expanded(child: Stack())
            ],
          ),
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
            return ListChapterAlQuranPage(
              chaptersBloc: widget.chaptersBloc,
              versesBloc: widget.versesBloc,
            );
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
      lastReading(),
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
