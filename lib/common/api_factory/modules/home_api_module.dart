import 'package:car_reception_flutter/common/api_factory/api.dart';
import 'package:car_reception_flutter/common/api_factory/dio_factory.dart';
import 'package:car_reception_flutter/common/utils/utils.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:flutter/material.dart';

resOrdreApi({required OnResponse<ResReceptionModel> onResponse}) {
/*
  Api.searchRead(
    model: "hs.ordre",
    domain: ['state','in','draft'],
    fields: [
      "id",
      "nom_client",
      "num_serie",
      "diagnostic_description",
      "id_ordre",
      "compteur",
      "roue_secours",
      "cric",
      "allume_cigares",
      "radio_cassette",
      "cles",
      "image_signature",
    ],
    limit: 30,
    order: "id",
    onResponse: (response) {
      print(response);
      onResponse(ResOrdreModel.fromJson(response));
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
*/
  Api.callKW(
    model: "hs.ordre",
    method: "get_liste_ordre_reception",
    args: [
      {
        'fields': [
          "id_ordre",
          "nom_client",
          "num_serie",
          "diagnostic_description",
          "compteur",
          "roue_secours",
          "cric",
          "allume_cigares",
          "radio_cassette",
          "cles",
          "image_signature",
        ],
      }
    ],
    kwargs: {

    },
    onResponse: (response) {
      debugPrint("request response $response");
      onResponse(ResReceptionModel.fromJson(response));
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}
