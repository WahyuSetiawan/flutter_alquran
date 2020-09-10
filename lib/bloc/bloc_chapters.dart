import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/network/lib_net.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChaptersState {}

class LoadingGetteringChapters extends ChaptersState {}

class SuccessGetteringChapters extends ChaptersState {
  ChaptersModel chaptersModel;

  SuccessGetteringChapters({this.chaptersModel});
}

class FailedGetteringChapters extends ChaptersState {}

class ChapterProvider {}

class ChaptersBloc extends Bloc<ChapterProvider, ChaptersState> {
  ChaptersBloc() : super(LoadingGetteringChapters());

  @override
  Stream<ChaptersState> mapEventToState(ChapterProvider event) async* {
    // TODO: implement mapEventToState
    yield LoadingGetteringChapters();

    var data = await getDataChapters();

    if (data == null) {
      yield FailedGetteringChapters();
    }

    if (data is ChaptersModel) {
      yield SuccessGetteringChapters(chaptersModel: data);
    }
  }
}
