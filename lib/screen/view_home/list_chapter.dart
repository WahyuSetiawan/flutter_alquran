import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../verse_page.dart';

class ListChapterAlQuran extends StatefulWidget {
  final ChaptersBloc chaptersBloc;
  final VersesBloc versesBloc;

  ListChapterAlQuran({
    Key key,
    @required this.chaptersBloc,
    @required this.versesBloc,
  }) : super(key: key);

  @override
  _ListChapterAlQuranState createState() => _ListChapterAlQuranState();
}

class _ListChapterAlQuranState extends State<ListChapterAlQuran> {
  Widget listChapters(ChaptersModel chaptersModel) {
    return ListView.builder(
      itemCount: chaptersModel.chapters.length,
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
              color: index % 2 == 0 ? Colors.transparent : Colors.black38,
            ),
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    chaptersModel.chapters[index].nameSimple,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      chaptersModel.chapters[index].nameArabic,
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
    return Scaffold(
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
    );
  }
}
