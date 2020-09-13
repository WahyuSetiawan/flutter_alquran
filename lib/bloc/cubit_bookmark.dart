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

  Future<void> insertBookmark(BookmarkModel model) async {
    int index = this.bookmarkModel.indexWhere((element) =>
        element.id_chapter == model.id_chapter &&
        element.numberVerse == model.numberVerse);

    if (index == -1) {
      print("insert chapter ${model.id_chapter}");

      this.bookmarkModel.add(model);

      await DatabaseBookmark.db.insertBookmark(model);

      emit(SuccessCubitBookmarkState(listBokmark: this.bookmarkModel));
    }

    return;
  }

  Future<void> deleteBookmark(int id) async {
    int index = this.bookmarkModel.indexWhere((element) => element.id == id);

    print("remove data at $id");

    if (index >= 0) {
      this.bookmarkModel.removeAt(index);

      await DatabaseBookmark.db.deleteBookmark(id);

      emit(SuccessCubitBookmarkState(listBokmark: this.bookmarkModel));
    }
  }

  void refreshData() {
    emit(SuccessCubitBookmarkState(listBokmark: this.bookmarkModel));
  }
}
