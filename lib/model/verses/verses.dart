import 'package:alquran/model/verses/verse.dart';

class VersesModel {
  List<Verse> verses;

  VersesModel({this.verses});

  VersesModel.fromJson(Map<String, dynamic> json) {
    if (json['chapters'] != null) {
      verses = new List<Verse>();
      json['chapters'].forEach((v) {
        verses.add(new Verse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.verses != null) {
      data['verses'] = this.verses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
