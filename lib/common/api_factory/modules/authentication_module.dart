import 'dart:convert';
import 'package:car_reception_flutter/src/authentication/views/login_Screen.dart';
import 'package:car_reception_flutter/src/home/view/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:car_reception_flutter/common/api_factory/api.dart';
import 'package:car_reception_flutter/common/config/config.dart';
import 'package:car_reception_flutter/common/config/prefs/pref_utils.dart';
import 'package:car_reception_flutter/common/utils/utils.dart';
import 'package:car_reception_flutter/common/widgets/log.dart';
import 'package:car_reception_flutter/src/authentication/controllers/signin_controller.dart';
import 'package:car_reception_flutter/src/authentication/models/user_model.dart';

getVersionInfoAPI() {
  Api.getVersionInfo(
    onResponse: (response) {
      Api.getDatabases(
        serverVersionNumber: response.serverVersionInfo![0],
        onResponse: (response) {
          Log(response);
          Config.DB = response[0];
        },
        onError: (error, data) {
          handleApiError(error);
        },
      );
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

authenticationAPI(String username, String pass) {
  Api.authenticate(
    username: username,
    password: pass,
    database: Config.DB,
    onResponse: (UserModel response) {
      currentUser.value = response;
      PrefUtils.setIsLoggedIn(true);
      PrefUtils.setUser(jsonEncode(response));
      Get.offAll(() => const WelcomeScreen());
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}

logoutApi() {
  Api.destroy(
    onResponse: (response) {
      PrefUtils.clearPrefs();
      Get.offAll(() => const LoginScreen());
    },
    onError: (error, data) {
      handleApiError(error);
    },
  );
}
