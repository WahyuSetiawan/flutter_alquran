import 'package:alquran/bloc/bloc_verses.dart';
import 'package:alquran/model/chapters/chapters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageVerses extends StatefulWidget {
  final Chapters chapter_id;
  final VersesBloc versesBloc;

  PageVerses({Key key, this.chapter_id, @required this.versesBloc})
      : super(key: key);

  @override
  _PageVersesState createState() => _PageVersesState();
}

class _PageVersesState extends State<PageVerses> {
  @override
  void initState() {
    super.initState();

    widget.versesBloc.add(VerseProvider(
      id: widget.chapter_id.id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => widget.versesBloc,
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("Detail Verse"),
          ),
          body: BlocBuilder<VersesBloc, VerseState>(
            builder: (context, state) {
              if (state is SuccessVerse) {
                return Container(
                  child: ListView.builder(
                    itemCount: state.versesModel.verses.length,
                    itemBuilder: (context, index) {
                      String arti = "";

                      for (var a in state.versesModel.verses[index].words) {
                        if (a.translation != null) {
                          arti += a.translation.text;
                        }
                      }

                      return Container(
                        decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? Colors.transparent
                                : Colors.black54),
                        child: Row(
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
                                child: Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        state.versesModel.verses[index]
                                            .textIndopak,
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        arti,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              return Container(
                child: Text("failed"),
              );
            },
          ),
        ));
  }
}
