import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:alquran/sharedpreferences/sharedprefrerences.dart';

class CubitLastReading extends Cubit<LastReadingState> {
  CubitLastReading() : super(LoadingLastReadingState());

  int chapterId;
  int numberVerse;

  changeLastReading(int chapterId, int numberVerse) async {
    this.chapterId = chapterId;
    this.numberVerse = numberVerse;

    await Prefs.prefs.setLastRead(chapterId, numberVerse);

    emit(SuccessChangeLastReadingState(
      chapterId: this.chapterId,
      numberVerse: this.numberVerse,
    ));
  }

  getDataLastReading() {
    Prefs.prefs.getLastRead().then((value) {
      if (value == "") {
        var cID = int.tryParse(value.split("_")[0]);
        var nVerse = int.tryParse(value.split("_")[1]);

        this.chapterId = cID;
        this.numberVerse = nVerse;

        emit(SuccessChangeLastReadingState(
          chapterId: this.chapterId,
          numberVerse: this.numberVerse,
        ));
      }
    });
  }
}

abstract class LastReadingState {}

class LoadingLastReadingState extends LastReadingState {}

class SuccessChangeLastReadingState extends LastReadingState {
  int chapterId;
  int numberVerse;
  SuccessChangeLastReadingState({
    this.chapterId,
    this.numberVerse,
  });
}
