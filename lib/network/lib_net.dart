import 'dart:convert';

import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/model/options/translations.dart';
import 'package:http/http.dart' as http;

String url = "http://api.quran.com:3000/api/v3";

Future<Object> getDataTranslations() async {
  var connection = await http.get("$url/options/translations");

  if (connection.statusCode == 200) {
    return TranslationsModel.fromJson(json.decode(connection.body));
  } else {
    return null;
  }
}

Future<Object> getDataChapters() async {
  var conn = await http.get("$url/chapters");

  if (conn.statusCode == 200) {
    return ChaptersModel.fromJson(json.decode(conn.body));
  } else {
    return null;
  }
}
