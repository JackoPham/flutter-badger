import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBadger {
  static const MethodChannel _channel = MethodChannel('tuna/flutter_badger');

  static void updateBadgeCount(int count) {
    _channel.invokeMethod('updateBadgeCount', {"count": count});
  }

  static void removeBadge() {
    _channel.invokeMethod('removeBadge');
  }

  static Future<bool> isAppBadgeSupported() async {
    bool? appBadgeSupported =
        await _channel.invokeMethod('isAppBadgeSupported');
    return appBadgeSupported ?? false;
  }
}
