class TranslationsModel {
  List<Translations> translations;

  TranslationsModel({this.translations});

  TranslationsModel.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = new List<Translations>();
      json['translations'].forEach((v) {
        translations.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.translations != null) {
      data['translations'] = this.translations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int id;
  String authorName;
  String slug;
  String name;
  String languageName;

  Translations(
      {this.id, this.authorName, this.slug, this.name, this.languageName});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorName = json['author_name'];
    slug = json['slug'];
    name = json['name'];
    languageName = json['language_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author_name'] = this.authorName;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['language_name'] = this.languageName;
    return data;
  }
}
