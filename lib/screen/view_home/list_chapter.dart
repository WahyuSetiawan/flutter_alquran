import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../verse_page.dart';

class ListChapterAlQuranPage extends StatefulWidget {
  final ChaptersBloc chaptersBloc;
  final VersesBloc versesBloc;

  ListChapterAlQuranPage({
    Key key,
    @required this.chaptersBloc,
    @required this.versesBloc,
  }) : super(key: key);

  @override
  _ListChapterAlQuranPageState createState() => _ListChapterAlQuranPageState();
}

class _ListChapterAlQuranPageState extends State<ListChapterAlQuranPage> {
  Widget listChapters(ChaptersModel chaptersModel) {
    return ListView.builder(
      itemCount: chaptersModel.chapters.length,
      padding: EdgeInsets.only(top: 0),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return PageVerses(
                  chapter_id: chaptersModel.chapters[index],
                  versesBloc: widget.versesBloc,
                );
              },
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Color(0x88696969),
              width: 1,
            ))),
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(right: 20),
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
                    children: [
                      Text(
                        chaptersModel.chapters[index].nameSimple,
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: Color(0xff696969),
                        ),
                      ),
                      Text(
                        chaptersModel.chapters[index].revelationPlace + "|",
                        style: TextStyle(
                          fontFamily: "roboto",
                          color: Color(0xff696969),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text(
                      chaptersModel.chapters[index].nameArabic,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "roboto",
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => widget.chaptersBloc,
          ),
          BlocProvider(
            create: (context) => widget.versesBloc,
          )
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          // appBar: AppBar(
          //   title: Text("List Chipter"),
          // ),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                ),
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Text("List Chapters"),
              ),
              Expanded(
                child: Container(
                  child: BlocBuilder<ChaptersBloc, ChaptersState>(
                    builder: (context, state) {
                      if (state is SuccessGetteringChapters) {
                        return listChapters(state.chaptersModel);
                      }

                      return Text("loading");
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
