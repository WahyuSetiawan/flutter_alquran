import 'dart:convert';

import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:alquran/database/database_bookmark.dart';
import 'package:alquran/database/model/bookmark.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/model/verses/verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PageVerses extends StatefulWidget {
  final Chapters chapter_id;
  final int column_number;

  PageVerses({
    Key key,
    @required this.chapter_id,
    int column_number,
  })  : this.column_number = column_number,
        super(key: key);

  @override
  _PageVersesState createState() => _PageVersesState();
}

class _PageVersesState extends State<PageVerses> {
  ItemScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    context.bloc<VersesBloc>().add(VerseProvider(
          id: widget.chapter_id.id,
        ));

    this._scrollController = ItemScrollController();
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

  Widget itemVerser(Verse verse, int index) {
    String arti = "";

    for (var a in verse.words) {
      if (a.translation != null) {
        arti += " " + a.translation.text;
      }
    }

    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
          // color: index % 2 == 0
          //     ? Colors.transparent
          //     : Color(0xffFAE07A),
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                (index + 1).toString(),
              ),
            ),
          ),
          Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: 20,
                      ),
                      child: Text(
                        verse.textIndopak,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xff968251),
                              fontSize: 18,
                              letterSpacing: 2,
                              height: 1.5,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        arti.trim(),
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              letterSpacing: 1.2,
                              wordSpacing: 1.4,
                              height: 1.5,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: Icon(
                            Icons.play_arrow,
                            size: 16,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        BlocBuilder<CubitBookmark, CubitBookmarkState>(
                          builder: (context, state) {
                            BookmarkModel bookmark;

                            if (state is SuccessCubitBookmarkState) {
                              var indexBookmark =
                                  state.listBokmark.indexWhere((element) {
                                return element.numberVerse == index &&
                                    widget.chapter_id.id == element.id_chapter;
                              });

                              if (indexBookmark >= 0) {
                                bookmark = state.listBokmark[indexBookmark];
                              }
                            } else {
                              bookmark = null;
                            }

                            return GestureDetector(
                                onTap: () {
                                  if (bookmark != null) {
                                    context
                                        .bloc<CubitBookmark>()
                                        .deleteBookmark(bookmark.id);
                                  } else {
                                    context
                                        .bloc<CubitBookmark>()
                                        .insertBookmark(BookmarkModel(
                                            id: null,
                                            id_chapter: widget.chapter_id.id,
                                            jsonChapter: jsonEncode(HtmlEscape()
                                                .convert(jsonEncode(widget
                                                    .chapter_id
                                                    .toJson()))),
                                            jsonVerses: HtmlEscape().convert(
                                                jsonEncode(jsonEncode(
                                                    verse.toJson()))),
                                            numberVerse: index));
                                  }
                                },
                                child: Icon(
                                  bookmark != null
                                      ? Icons.bookmark
                                      : Icons.bookmark_outline,
                                  size: 16,
                                ));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          header(),
          BlocBuilder<VersesBloc, VerseState>(buildWhen: (previous, current) {
            if (previous is LoadingVerse && current is SuccessVerse) {
              if (widget.column_number != null) {
                Future.delayed(const Duration(milliseconds: 60), () {
                  this._scrollController.scrollTo(
                      index: widget.column_number,
                      duration: const Duration(seconds: 1));
                });
              }
            }

            return true;
          }, builder: (context, state) {
            if (state is SuccessVerse) {
              return Expanded(
                child: ScrollablePositionedList.builder(
                    itemScrollController: this._scrollController,
                    itemCount: state.versesModel.verses.length,
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) =>
                        itemVerser(state.versesModel.verses[index], index)),
              );
            }

            return Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          })
        ],
      ),
    );
  }
}
