import 'package:car_reception_flutter/common/api_factory/api.dart';
import 'package:car_reception_flutter/common/api_factory/dio_factory.dart';
import 'package:car_reception_flutter/common/utils/utils.dart';
import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

resReceptionApi(
    {required OnResponse<dynamic> onResponse, required Reception reception}) {
  Api.callKW(
    model: "hs.ordre",
    method: "set_liste_ordre_reception",
    args: [
      reception.id_ordre,
      reception.compteur,
      reception.roue_secours,
      reception.cric,
      reception.allume_cigares,
      reception.radio_cassette,
      reception.cles,
      reception.diagnostic_description,
      reception.image_signature,
    ],
    kwargs: {},
    onResponse: (response) {
      onResponse((response));
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
  /* Api.read(
    model: "hs.ordre",
    // method: "set_liste_ordre_reception",
    fields: [
      "id_ordre",
      "compteur",
      "roue_secours",
      "cric",
      "allume_cigares",
      "radio_cassette",
      "cles",
      "diagnostic_description",
      "image_signature",
    ],
    ids: [3788],
    onResponse: (response) {
      print(response.toString());
      onResponse(ResReceptionModel.fromJson(response));
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );*/
}

resReceptionApiWrite({required OnResponse onResponse}) {
  Api.write(
    model: "hs.ordre",
    // method: "set_liste_ordre_reception",
    values: {
      "compteur": 242900,
      "roue_secours": "oui",
      "cric": "oui",
      "allume_cigares": "oui",
      "radio_cassette": "oui",
      "cles": "oui",
      "diagnostic_description": "VIDANGE + FILTRES",
      "image_signature": [],
    },
    ids: [3788],
    onResponse: (response) {
      if (kDebugMode) {
        print(response.toString());
      }
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

resReceptionReadImageApi(
    {required OnResponse<dynamic> onResponse, required int id}) {
  Api.read(
    model: "ir.attachment",
    ids: [id],
    fields: [],
    onResponse: (response) {
      if (kDebugMode) {
        print(response.toString());
      }
      onResponse(response);
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

resReceptionApiCreateImage(
    {required OnResponse<int> onResponse, required String data}) {
  ReceptionController controller = Get.find<ReceptionController>();

  Api.create(
    model: "ir.attachment",
    values: {
      "name": 'signature-client.png',
      "type": 'binary',
      "res_model": 'hs.ordre',
      "datas": data,
    },
    onResponse: (dynamic response) {
      controller.result.value = response;
      print(response.toString());
      print("APi Response = $response");
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

resReceptionApiDeleteImage(
    {required OnResponse<bool> onResponse, required int id}) {
  Api.unlink(
    model: "ir.attachment",
    ids: [id],
    onResponse: (dynamic response) {
      print("APi Unlink Response = $response");
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

resReceptionApiAttachImage(
    {required OnResponse<int> onResponse,
    required int id,
    required int signature}) {
  ReceptionController controller = Get.find<ReceptionController>();

  Api.write(
    model: "hs.ordre",
    ids: [id],
    values: {
      'image_signature': [
        '${(4, 0, [signature])}'
      ],
    },
    onResponse: (response) {
      print(response.toString());
    },
    onError: (error, data) async {
      handleApiError(error);
    },
  );
}
