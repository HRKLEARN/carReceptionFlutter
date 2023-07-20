class ResReceptionModel {
  List<Reception>? receptions;

  ResReceptionModel({this.receptions});

  ResReceptionModel.fromJson(Map<String, dynamic> json) {
    receptions =
        json.values.map((dynamic json) => Reception.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (receptions != null) {
      map["result"] = receptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Reception {
  int? id_ordre;
  String? compteur;
  String? nom_client;
  String? num_serie;
  String? roue_secours;
  String? cric;
  String? allume_cigares;
  String? radio_cassette;
  String? cles;
  String? diagnostic_description;
  List<dynamic>? image_signature;
  List<dynamic>? images;

  Reception({
    this.id_ordre,
    this.num_serie,
    this.nom_client,
    this.compteur,
    this.roue_secours,
    this.cric,
    this.allume_cigares,
    this.radio_cassette,
    this.cles,
    this.diagnostic_description,
    this.image_signature,
    this.images,
  });

  Reception.fromJson(dynamic json) {
    id_ordre = json["id_ordre"] is! bool ? json["id_ordre"] : 0;
    num_serie = json["num_serie"] is! bool ? json["num_serie"] : "";
    nom_client = json["nom_client"] is! bool ? json["nom_client"] : "";
    compteur = json["compteur"] is! bool ? json["compteur"] : "";
    roue_secours = json["roue_secours"] is! bool ? json["roue_secours"] : "";
    cric = json["cric"] is! bool ? json["cric"] : "";
    allume_cigares =
        json["allume_cigares"] is! bool ? json["allume_cigares"] : "";
    radio_cassette =
        json["radio_cassette"] is! bool ? json["radio_cassette"] : "";
    cles = json["cles"] is! bool ? json["cles"] : "";
    diagnostic_description = json["diagnostic_description"] is! bool
        ? json["diagnostic_description"]
        : "";
    image_signature =
        json["image_signature"] is! bool ? json["image_signature"] : [];

    images =
    json["images"] is! bool ? json["images"] : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id_ordre"] = id_ordre;
    map["num_serie"] = num_serie;
    map["nom_client"] = nom_client;
    map["compteur"] = compteur;
    map["roue_secours"] = roue_secours;
    map["cric"] = cric;
    map["allume_cigares"] = allume_cigares;
    map["radio_cassette"] = radio_cassette;
    map["cles"] = cles;
    map["diagnostic_description"] = diagnostic_description;
    map["image_signature"] = image_signature;
    map["images"] = images;

    return map;
  }
}
