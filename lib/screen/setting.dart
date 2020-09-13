import 'package:alquran/bloc/cubit_language.dart';
import 'package:alquran/model/options/language.dart';
import 'package:alquran/screen/list_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
          Text("Setting",
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

  Widget listSetting() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            title: Text("Language",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 18)),
            trailing: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ListLanguage(),
                ));
              },
              child: BlocBuilder<CubitLangugage, StateCubit>(
                builder: (context, state) {
                  var language = "indonesia";

                  if (state is LoadLanguageCubit) {
                    if (state.language != null) {
                      var index = state.language.languages.indexWhere(
                          (element) => element.isoCode == state.currentLanguge);

                      if (index >= 0)
                        language = state.language.languages[index].name;
                    }
                  }

                  return Text(
                    language,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 14),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          header(),
          listSetting(),
        ],
      ),
    );
  }
}
