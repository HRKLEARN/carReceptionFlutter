import 'package:flutter/foundation.dart';

class Log {
  Log(var value) {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print("===============> ${value.toString()} <=====================");
      }
    }
  }
}
