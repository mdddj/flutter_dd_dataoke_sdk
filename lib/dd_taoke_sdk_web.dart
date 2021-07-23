import 'dart:async';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_dd_dataoke_sdk.dart';

/// A web implementation of the DdTaokeSdk plugin.
class DdTaokeSdkWeb {
  static void registerWith(Registrar registrar) {
    final pluginInstance = DdTaokeSdkWeb();
    FlutterDdDataokeSdk.instance = pluginInstance;
  }

  /// 判断是否为微信浏览器
  Future<bool> isWeChatBrowser() async {
    if (kIsWeb) {
      final ua = html.window.navigator.userAgent.toLowerCase();
      if(ua.indexOf('micromessenger')!=-1){
        return true;
      }
      return false;
    }
    return false;
  }
}
