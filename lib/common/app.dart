import 'dart:developer';
import 'package:car_reception_flutter/common/config/app_fonts.dart';
import 'package:car_reception_flutter/src/authentication/views/login_Screen.dart';
import 'package:car_reception_flutter/src/home/view/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:car_reception_flutter/common/api_factory/dio_factory.dart';
import 'package:car_reception_flutter/common/config/config.dart';
import 'package:car_reception_flutter/common/config/localization/translations.dart';

class App extends StatefulWidget {
  final bool isLoggedIn;

  const App(this.isLoggedIn, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var _initStateFlag = false;
  @override
  void initState() {
    super.initState();
    if (!kReleaseMode) {
      log('initState', name: '_AppState::initState');
    }
    _initStateFlag = true;

  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_initStateFlag) {
      _initStateFlag = false;
      await DioFactory.computeDeviceInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.red,
      fontFamily: AppFont.Roboto_Regular,
    ),
      title: 'PolyGarage',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Config.supportedLocales,
      home: widget.isLoggedIn ? const WelcomeScreen() : const LoginScreen(),
    );
  }
}
