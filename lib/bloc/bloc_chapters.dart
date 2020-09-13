import 'package:alquran/model/options/language.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/network/lib_net.dart';

abstract class ChaptersState {}

class LoadingGetteringChapters extends ChaptersState {}

class SuccessGetteringChapters extends ChaptersState {
  ChaptersModel chaptersModel;

  SuccessGetteringChapters({this.chaptersModel});
}

class FailedGetteringChapters extends ChaptersState {}

class ChapterProvider {
  String langugage;
  ChapterProvider({
    this.langugage = "id",
  });
}

class ChaptersBloc extends Bloc<ChapterProvider, ChaptersState> {
  ChaptersBloc() : super(LoadingGetteringChapters());

  ChaptersModel chaptersModel;

  @override
  Stream<ChaptersState> mapEventToState(ChapterProvider event) async* {
    yield LoadingGetteringChapters();

    var data = await getDataChapters(
      language: event.langugage,
    );

    if (data == null) {
      yield FailedGetteringChapters();
    }

    if (data is ChaptersModel) {
      this.chaptersModel = data;

      yield SuccessGetteringChapters(chaptersModel: this.chaptersModel);
    }
  }
}
