import 'package:flutter/widgets.dart';

class Config {
  Config._();

  ///Odoo URLs
  static const String OdooDevURL = "http://51.255.46.47:8055/";
  static const String OdooProdURL = "http://51.255.46.47:8055/";
  static const String OdooUATURL = "http://51.255.46.47:8055/";

  /// SelfSignedCert:
  static const selfSignedCert = false;

  /// API Config
  static const timeout = Duration(seconds: 60);
  static const logNetworkRequest = true;
  static const logNetworkRequestHeader = true;
  static const logNetworkRequestBody = true;
  static const logNetworkResponseHeader = false;
  static const logNetworkResponseBody = true;
  static const logNetworkError = true;

  /// Localization Config
  static const supportedLocales = <Locale>[Locale('en', ''), Locale('fr', '')];

  /// Common Const
  static const actionLocale = 'locale';
  static const int SIGNUP = 0;
  static const int SIGNIN = 1;
  static const String CURRENCY_SYMBOL = "€";
  static String FCM_TOKEN = "";
  static String DB = "";
}
