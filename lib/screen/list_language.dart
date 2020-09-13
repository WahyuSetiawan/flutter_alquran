import 'package:alquran/bloc/bloc_chapters.dart';
import 'package:alquran/bloc/cubit_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListLanguage extends StatefulWidget {
  ListLanguage({Key key}) : super(key: key);

  @override
  _ListLanguageState createState() => _ListLanguageState();
}

class _ListLanguageState extends State<ListLanguage> {
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(1, 1),
          )
        ],
      ),
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.chevron_left,
              size: 30,
              color: Color(0xff565656),
            ),
          ),
          Text("List Language",
              style: TextStyle(
                fontSize: 18,
                letterSpacing: .7,
                fontFamily: "roboto",
                fontWeight: FontWeight.bold,
                color: Color(0xff565656),
              )),
          Container(),
        ],
      ),
    );
  }

  Widget listLanguage() {
    return Expanded(child: BlocBuilder<CubitLangugage, StateCubit>(
      builder: (context, state) {
        if (state is LoadingLanguageCubit) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is LoadLanguageCubit) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context
                      .bloc<CubitLangugage>()
                      .changeLanguge(state.language.languages[index]);

                  context.bloc<ChaptersBloc>().add(ChapterProvider(
                        langugage: state.language.languages[index].isoCode,
                      ));

                  Navigator.of(context).pop();
                },
                title: Text(state.language.languages[index].name),
                trailing: Icon(Icons.chevron_right),
              );
            },
            itemCount: state.language.languages.length,
          );
        }

        return Center(
          child: Column(
            children: [Text("Tidak ada langugage yang ditampilkan ")],
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          header(),
          listLanguage(),
        ],
      ),
    );
  }
}
