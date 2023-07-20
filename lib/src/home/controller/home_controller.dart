import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:get/get.dart';
import 'package:car_reception_flutter/common/api_factory/modules/home_api_module.dart';
import 'package:car_reception_flutter/src/home/model/res_ordre_model.dart';

class HomeController extends GetxController {
  final listOfOrdres = <Reception>[].obs;
  getOrdres() {
    resOrdreApi(
      onResponse: (response) {
        listOfOrdres.assignAll(response.receptions!);
      },
    );
  }

}
