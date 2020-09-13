import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'verse_page.dart';

class ListChapterAlQuranPage extends StatefulWidget {
  ListChapterAlQuranPage({
    Key key,
  }) : super(key: key);

  @override
  _ListChapterAlQuranPageState createState() => _ListChapterAlQuranPageState();
}

class _ListChapterAlQuranPageState extends State<ListChapterAlQuranPage> {
  Widget listChapters(ChaptersModel chaptersModel) {
    return ListView.builder(
      itemCount: chaptersModel.chapters.length,
      padding: EdgeInsets.only(top: 0),
      itemBuilder: (context, index) =>
          itemListViewChapter(chaptersModel.chapters[index], index),
    );
  }

  Widget itemListViewChapter(Chapters chaptersModel, int index) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return PageVerses(chapter_id: chaptersModel);
            },
          ));
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(
                top: 15,
                bottom: 15,
                left: 10,
                right: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    alignment: Alignment.topCenter,
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        fontFamily: "roboto",
                        color: Color(0xff696969),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chaptersModel.nameSimple,
                          style: TextStyle(
                            fontFamily: "roboto",
                            fontSize: 16,
                            color: Color(0xff696969),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${chaptersModel.revelationPlace} | ${chaptersModel.versesCount} ayat",
                          style: TextStyle(
                            fontFamily: "roboto",
                            fontSize: 11,
                            letterSpacing: .5,
                            color: Color(0xff696969),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      chaptersModel.nameArabic,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "roboto",
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: Theme.of(context).dividerColor,
              margin: EdgeInsets.only(left: 40, right: 30),
              height: 1,
            )
          ],
        ));
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(1, 1),
          )
        ],
      ),
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.chevron_left,
              size: 30,
              color: Color(0xff565656),
            ),
          ),
          Text("List Chapters",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: .7,
                fontFamily: "roboto",
                fontWeight: FontWeight.bold,
                color: Color(0xff565656),
              )),
          Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // appBar: AppBar(
      //   title: Text("List Chipter"),
      // ),
      body: Column(
        children: [
          header(),
          Expanded(
            child: Container(
              child: BlocBuilder<ChaptersBloc, ChaptersState>(
                builder: (context, state) {
                  if (state is SuccessGetteringChapters) {
                    return listChapters(state.chaptersModel);
                  }

                  return Expanded(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
