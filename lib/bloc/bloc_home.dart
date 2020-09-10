import 'package:alquran/model/options/translations.dart';
import 'package:alquran/network/lib_net.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeState {}

class LoadingHomeState extends HomeState {}

class SuccessDownloadData extends HomeState {
  TranslationsModel translationsModel;

  SuccessDownloadData({this.translationsModel});
}

class FailedDownloadData extends HomeState {}

class HomeProvider {}

class TranslationsBloc extends Bloc<HomeProvider, HomeState> {
  TranslationsBloc() : super(LoadingHomeState());

  @override
  Stream<HomeState> mapEventToState(HomeProvider event) async* {
    yield LoadingHomeState();

    var connTranslation = await getDataTranslations();

    if (connTranslation == null) {
      yield FailedDownloadData();

      return;
    }

    yield SuccessDownloadData(translationsModel: connTranslation);
  }
}
