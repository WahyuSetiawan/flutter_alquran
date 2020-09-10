import 'dart:convert';

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
