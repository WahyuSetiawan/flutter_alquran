import 'dart:convert';

import 'package:flutter/material.dart';

class BookmarkModel {
  int id;
  String jsonChapter;
  String jsonVerses;
  int numberVerse;

  BookmarkModel({
    @required this.id,
    @required this.jsonChapter,
    @required this.jsonVerses,
    @required this.numberVerse,
  });

  BookmarkModel copyWith({
    int id,
    String jsonChapter,
    String jsonVerses,
    int numberVerse,
  }) {
    return BookmarkModel(
      id: id ?? this.id,
      jsonChapter: jsonChapter ?? this.jsonChapter,
      jsonVerses: jsonVerses ?? this.jsonVerses,
      numberVerse: numberVerse ?? this.numberVerse,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jsonChapter': jsonChapter,
      'jsonVerses': jsonVerses,
      'numberVerse': numberVerse,
    };
  }

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BookmarkModel(
      id: map['id'],
      jsonChapter: map['jsonChapter'],
      jsonVerses: map['jsonVerses'],
      numberVerse: map['numberVerse'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookmarkModel.fromJson(String source) =>
      BookmarkModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookmarkModel(id: $id, jsonChapter: $jsonChapter, jsonVerses: $jsonVerses, numberVerse: $numberVerse)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BookmarkModel &&
        o.id == id &&
        o.jsonChapter == jsonChapter &&
        o.jsonVerses == jsonVerses &&
        o.numberVerse == numberVerse;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jsonChapter.hashCode ^
        jsonVerses.hashCode ^
        numberVerse.hashCode;
  }
}
