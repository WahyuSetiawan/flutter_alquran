import 'dart:convert';

import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/model/options/language.dart';
import 'package:alquran/model/options/translations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../model/verses/verses.dart';

String url = "http://api.quran.com:3000/api/v3";

Future<Object> getDataTranslations() async {
  var connection = await http.get("$url/options/translations");

  if (connection.statusCode == 200) {
    return TranslationsModel.fromJson(json.decode(connection.body));
  } else {
    return null;
  }
}

Future<Object> getDataChapters({String language}) async {
  var conn = await Dio().get("$url/chapters", queryParameters: {
    "language": language,
  });

  if (conn.statusCode == 200) {
    return ChaptersModel.fromJson(conn.data);
  } else {
    return null;
  }
}

Future<Object> getDataVerse({
  @required chapter_id,
  int recitation = 1,
  String language = "en",
  String text_type = "word",
}) async {
  Response response = await Dio().get(
    "$url/chapters/$chapter_id/verses",
    queryParameters: {
      "recitation": recitation,
      "text_type": text_type,
      "language": language,
    },
  );

  if (response.statusCode == 200) {
    print(response.request.uri);
    return VersesModel.fromJson(response.data);
  } else {
    return null;
  }
}

Future<Object> getDataLanguage() async {
  Response response = await Dio().get("$url/options/languages");

  if (response.statusCode == 200) {
    return Language.fromJson(response.data);
  } else {
    return null;
  }
}
