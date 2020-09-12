import 'package:alquran/database/database_bookmark.dart';
import 'package:alquran/database/model/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CubitBookmarkState {}

class LoadingCubitBookmarkState extends CubitBookmarkState {}

class SuccessCubitBookmarkState extends CubitBookmarkState {
  List<BookmarkModel> listBokmark;

  SuccessCubitBookmarkState({
    @required this.listBokmark,
  });
}

class CubitBookmark extends Cubit<CubitBookmarkState> {
  CubitBookmark() : super(LoadingCubitBookmarkState());

  List<BookmarkModel> bookmarkModel = List();

  Future<void> getData() async {
    emit(LoadingCubitBookmarkState());

    this.bookmarkModel = await DatabaseBookmark.db.allBookmark;

    emit(SuccessCubitBookmarkState(listBokmark: this.bookmarkModel));
  }
}
