import 'package:alquran/model/options/translations.dart';
import 'package:alquran/network/lib_net.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TranslationState {}

class LoadingTranslation extends TranslationState {}

class SuccessTranslation extends TranslationState {
  TranslationsModel translationsModel;

  SuccessTranslation({this.translationsModel});
}

class FailedDownloadData extends TranslationState {}

class HomeProvider {}

class TranslationsBloc extends Bloc<HomeProvider, TranslationState> {
  TranslationsBloc() : super(LoadingTranslation());

  @override
  Stream<TranslationState> mapEventToState(HomeProvider event) async* {
    yield LoadingTranslation();

    var connTranslation = await getDataTranslations();

    if (connTranslation == null) {
      yield FailedDownloadData();

      return;
    }

    yield SuccessTranslation(translationsModel: connTranslation);
  }
}
