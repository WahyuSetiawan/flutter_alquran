import 'package:alquran/model/options/language.dart';
import 'package:alquran/network/lib_net.dart';
import 'package:alquran/sharedpreferences/sharedprefrerences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class StateCubit {}

class LoadingLanguageCubit extends StateCubit {}

class LoadLanguageCubit extends StateCubit {
  Language language;
  String currentLanguge;

  LoadLanguageCubit({
    @required this.language,
    @required this.currentLanguge,
  });
}

class FirstLoadCubit extends StateCubit {}

class CubitLangugage extends Cubit<StateCubit> {
  CubitLangugage() : super(FirstLoadCubit());

  Language languages;
  String currentLanguge;

  Future<void> changeLanguge(Languages languages) async {
    this.currentLanguge = languages.isoCode;

    await Prefs.prefs.setLanguage(this.currentLanguge);

    emit(LoadLanguageCubit(
      language: this.languages,
      currentLanguge: this.currentLanguge,
    ));

    return null;
  }

  Future<void> getLanguageFromApi() async {
    emit(LoadingLanguageCubit());
    var dataLanguage = await getDataLanguage();

    if (dataLanguage == null) {
    } else if (dataLanguage is Language) {
      this.languages = dataLanguage;

      emit(LoadLanguageCubit(
        language: dataLanguage,
        currentLanguge: this.currentLanguge,
      ));
    }
  }

  void setCurrentLanguge(String value) {
    this.currentLanguge = value;

    emit(LoadLanguageCubit(
      language: this.languages,
      currentLanguge: this.currentLanguge,
    ));
  }
}
