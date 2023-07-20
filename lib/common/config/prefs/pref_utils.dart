import 'dart:convert';
import 'package:car_reception_flutter/common/config/prefs/pref_keys.dart';
import 'package:car_reception_flutter/src/authentication/models/user_model.dart';
import 'package:car_reception_flutter/src/reception/model/res_reception_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  PrefUtils();

  static setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(PrefKeys.token, token);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(PrefKeys.token) ?? "";
  }

  static setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(PrefKeys.isLoggedIn, isLoggedIn);
  }

  static Future<bool> getIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(PrefKeys.isLoggedIn) ?? false;
  }

  static setUser(String userData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(PrefKeys.user, userData);
  }

  static Future<UserModel> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> user =
        jsonDecode(preferences.getString(PrefKeys.user) ?? "{}");
    return UserModel.fromJson(user);
  }
  static setReception(String receptionData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(PrefKeys.reception, receptionData);
  }

  static Future<Reception> getReception() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> reception =
    jsonDecode(preferences.getString(PrefKeys.reception) ?? "{}");
    return Reception.fromJson(reception);
  }

  static deleteReceptionFromSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(PrefKeys.reception);
  }
  static clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
