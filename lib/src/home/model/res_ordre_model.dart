
class ResOrdreModel {
  List<Ordre>? ordres;

  ResOrdreModel({this.ordres});

  ResOrdreModel.fromJson(dynamic json) {
    if (json["records"] != null) {
      ordres = [];
      json["records"].forEach((v) {
        ordres?.add(Ordre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (ordres != null) {
      map["records"] = ordres?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Ordre {
  int? id_ordre;
  String? nom_client;
  String? num_serie;
  String? diagnostic_description;
  String? compteur;
  String? roue_secours;
  String? cric;
  String? allume_cigares;
  String? radio_cassette;
  String? cles;
  List< dynamic >? image_signature;

  Ordre({this.id_ordre, this.nom_client, this.num_serie, this.diagnostic_description});

  Ordre.fromJson(dynamic json) {
    id_ordre = json["id"];
    nom_client = json["nom_client"];
    num_serie = json["num_serie"] is! bool ? json["num_serie"] : "";
    diagnostic_description = json["diagnostic_description"] is! bool ? json["diagnostic_description"] : "";
    compteur = json["compteur"]is! bool ? json["compteur"] : "";
    roue_secours = json["roue_secours"]is! bool ? json["roue_secours"] : "";
    cric = json["cric"]is! bool ? json["cric"] : "";
    allume_cigares = json["allume_cigares"]is! bool ? json["allume_cigares"] : "";
    radio_cassette = json["radio_cassette"]is! bool ? json["radio_cassette"] : "";
    cles = json["cles"]is! bool ? json["cles"] : "";
    image_signature = json["image_signature"]is! bool ? json["image_signature"] : [];

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id_ordre;
    map["nom_client"] = nom_client;
    map["num_serie"] = num_serie;
    map["diagnostic_description"] = diagnostic_description;
    map["compteur"] = compteur;
    map["roue_secours"] = roue_secours;
    map["cric"] = cric;
    map["allume_cigares"] = allume_cigares;
    map["radio_cassette"] = radio_cassette;
    map["cles"] = cles;
    map["image_signature"] = image_signature;


    return map;
  }
}
