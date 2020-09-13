class Language {
  List<Languages> languages;

  Language({this.languages});

  Language.fromJson(Map<String, dynamic> json) {
    if (json['languages'] != null) {
      languages = new List<Languages>();
      json['languages'].forEach((v) {
        languages.add(new Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.languages != null) {
      data['languages'] = this.languages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Languages {
  String name;
  String isoCode;
  String nativeName;
  String direction;
  int id;
  List<TranslatedNames> translatedNames;

  Languages(
      {this.name,
      this.isoCode,
      this.nativeName,
      this.direction,
      this.id,
      this.translatedNames});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isoCode = json['iso_code'];
    nativeName = json['native_name'];
    direction = json['direction'];
    id = json['id'];
    if (json['translated_names'] != null) {
      translatedNames = new List<TranslatedNames>();
      json['translated_names'].forEach((v) {
        translatedNames.add(new TranslatedNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso_code'] = this.isoCode;
    data['native_name'] = this.nativeName;
    data['direction'] = this.direction;
    data['id'] = this.id;
    if (this.translatedNames != null) {
      data['translated_names'] =
          this.translatedNames.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TranslatedNames {
  String languageName;
  String name;

  TranslatedNames({this.languageName, this.name});

  TranslatedNames.fromJson(Map<String, dynamic> json) {
    languageName = json['language_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_name'] = this.languageName;
    data['name'] = this.name;
    return data;
  }
}
