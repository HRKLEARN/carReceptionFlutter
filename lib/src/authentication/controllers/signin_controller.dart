import 'package:get/get.dart';
import 'package:car_reception_flutter/common/config/prefs/pref_utils.dart';
import 'package:car_reception_flutter/src/authentication/models/user_model.dart';

var currentUser = UserModel().obs;

class SignInController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    currentUser.value = await PrefUtils.getUser();
  }
}
