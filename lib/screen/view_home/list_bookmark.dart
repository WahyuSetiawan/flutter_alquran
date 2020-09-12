import 'package:alquran/bloc/cubit_bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBookmarkPage extends StatefulWidget {
  final CubitBookmark cubitBookmark;

  ListBookmarkPage({Key key, CubitBookmark cubitBookmark})
      : this.cubitBookmark = cubitBookmark,
        super(key: key);

  @override
  _ListBookmarkPageState createState() => _ListBookmarkPageState();
}

class _ListBookmarkPageState extends State<ListBookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => widget.cubitBookmark,
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text("List Bookmark"),
          ),
          body: Column(
            children: [
              BlocBuilder<CubitBookmark, CubitBookmarkState>(
                builder: (context, state) {
                  if (state is SuccessCubitBookmarkState) {
                    return Text("loading bookmark ${state.listBokmark.length}");
                  }

                  return Text("Loading");
                },
              )
            ],
          ),
        ));
  }
}
