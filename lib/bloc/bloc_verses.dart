import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/verses/verse.dart';
import '../model/verses/verses.dart';
import '../network/lib_net.dart';

class VersesBloc extends Bloc<VerseProvider, VerseState> {
  VersesBloc() : super(LoadingVerse());

  @override
  Stream<VerseState> mapEventToState(VerseProvider event) async* {
    yield LoadingVerse();

    var data = await getDataVerse(chapter_id: event.id);

    if (data == null) {
      yield FailedVerse();
    }

    if (data is VersesModel) {
      yield SuccessVerse(versesModel: data);
    }
  }
}

abstract class VerseState {}

class LoadingVerse extends VerseState {}

class SuccessVerse extends VerseState {
  VersesModel versesModel;

  SuccessVerse({@required this.versesModel});
}

class FailedVerse extends VerseState {}

class VerseProvider {
  int id;

  VerseProvider({@required this.id});
}
