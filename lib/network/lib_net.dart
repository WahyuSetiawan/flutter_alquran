import 'dart:convert';

import 'package:alquran/model/chapters/chapters.dart';
import 'package:alquran/model/options/translations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../model/verses/verse.dart';
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

Future<Object> getDataChapters() async {
  var conn = await http.get("$url/chapters");

  if (conn.statusCode == 200) {
    return ChaptersModel.fromJson(json.decode(conn.body));
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
    return VersesModel.fromJson(response.data);
  } else {
    return null;
  }
}
