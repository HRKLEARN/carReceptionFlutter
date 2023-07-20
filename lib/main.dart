import 'package:car_reception_flutter/common/api_factory/dio_factory.dart';
import 'package:car_reception_flutter/common/app.dart';
import 'package:car_reception_flutter/common/config/dependencies.dart';
import 'package:car_reception_flutter/common/config/prefs/pref_utils.dart';
import 'package:car_reception_flutter/src/reception/controller/reception_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ReceptionController());

  // Controller dependencies which we use throughout the app
  Dependencies.injectDependencies();

  DioFactory.initialiseHeaders(await PrefUtils.getToken());

  bool isLoggedIn = await PrefUtils.getIsLoggedIn();
  runApp(App(isLoggedIn));
}
