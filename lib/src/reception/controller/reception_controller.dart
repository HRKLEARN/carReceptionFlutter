import 'dart:convert';

import 'package:car_reception_flutter/common/api_factory/modules/reception_api_module.dart';
import 'package:car_reception_flutter/common/config/prefs/pref_utils.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReceptionController extends GetxController {

  final listOfReceptions = <Reception>[].obs;
  RxInt result = 0.obs;
  final Rx<ByteData> img = ByteData(0).obs;
  RxMap<int, XFile>? images= <int, XFile>{}.obs;
  final currentReception = Reception().obs;


  @override
  void onInit() async {
    super.onInit();
    currentReception.value = await PrefUtils.getReception();
  }

  updateReception(Reception reception) {
    resReceptionApi(
        onResponse: (response) {
          debugPrint(response.toString());
        },
        reception: reception);
  }

  setReception() {
    resReceptionApiWrite(onResponse: (response) {
      if (response == true) {
        print("reception updated successfully");
      }
    });
  }

  readSignatureImage({required int id}) {
    resReceptionReadImageApi(
        onResponse: (response) {
          if (kDebugMode) {
            print("$response");
          }
        /*  if (response != null) {
            final data = response['datas']; // Assuming response structure is { 'datas': 'base64data' }
            if (data != null) {
              final bytes = _base64ToBytes(data);
              final image = XFile.fromData(bytes);
              images?[id] = image;
            }
          }*/
        },
        id: id);
  }
  Uint8List _base64ToBytes(String base64String) {
    return base64Decode(base64String);
  }
  createSignatureImage({required String data}) {
    resReceptionApiCreateImage(
        onResponse: (response) {
          print("$response");
        },
        data: data);
  }

  attachImageToReception({required int id, required int signature}) {
    resReceptionApiAttachImage(
      onResponse: (response) {
        print(response.toString());
          currentReception.value.image_signature?.add(result.value);


      },
      id: id,
      signature: signature,
    );
  }

  deleteImage({required int id}) {
    resReceptionApiDeleteImage(
        onResponse: (response) {
          print(" Unlink result = $response");
        },
        id: id);
  }
}
