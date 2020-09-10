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
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Verse"),
      ),
      body: BlocBuilder<VersesBloc, VerseState>(
        builder: (context, state) {
          if (state is SuccessVerse) {
            return Container(
              child: Text(state.versesModel.verses.length.toString()),
            );
          }

          return Container(
            child: Text("failed"),
          );
        },
      ),
    );
  }
}
