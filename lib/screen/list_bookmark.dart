import 'dart:convert';

import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:alquran/database/model/bookmark.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/screen/verse_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape_small.dart';

class ListBookmarkPage extends StatefulWidget {
  final CubitBookmark cubitBookmark;

  ListBookmarkPage({Key key, CubitBookmark cubitBookmark})
      : this.cubitBookmark = cubitBookmark,
        super(key: key);

  @override
  _ListBookmarkPageState createState() => _ListBookmarkPageState();
}

class _ListBookmarkPageState extends State<ListBookmarkPage> {
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
          Text("Verses",
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

  Widget itemContainerBookmark(BookmarkModel bookmarkModel, int index) {
    Map<String, dynamic> data = jsonDecode(HtmlUnescape().convert(HtmlUnescape()
        .convert(bookmarkModel.jsonChapter)
        .substring(
            1, HtmlUnescape().convert(bookmarkModel.jsonChapter).length - 1)));

    Chapters chaptersModel = Chapters.fromJson(data);

    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return PageVerses(
                chapter_id: chaptersModel,
                column_number: bookmarkModel.numberVerse,
              );
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
                        fontSize: 14,
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
                      (bookmarkModel.numberVerse + 1).toString(),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.bloc<CubitBookmark>().refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          header(),
          BlocBuilder<CubitBookmark, CubitBookmarkState>(
            builder: (context, state) {
              if (state is SuccessCubitBookmarkState) {
                return Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  itemCount: context.bloc<CubitBookmark>().bookmarkModel.length,
                  itemBuilder: (context, index) {
                    return itemContainerBookmark(
                      context.bloc<CubitBookmark>().bookmarkModel[index],
                      index,
                    );
                  },
                ));
              }

              return Expanded(
                child: Center(
                  child: Text("Loading"),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
