import 'package:alquran/bloc/bloc_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomeStateState createState() => _HomeStateState();
}

class _HomeStateState extends State<HomePage> {
  TranslationsBloc _translationsBloc;

  @override
  void initState() {
    this._translationsBloc = TranslationsBloc();

    this._translationsBloc.add(HomeProvider());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => this._translationsBloc,
            )
          ],
          child: Container(
            child: BlocBuilder<TranslationsBloc, HomeState>(
              builder: (context, state) {
                if (state is SuccessDownloadData) {
                  return Text(
                      "success getering data : ${state.translationsModel.translations.length}");
                }

                return Text("loading");
              },
            ),
          )),
    );
  }
}
