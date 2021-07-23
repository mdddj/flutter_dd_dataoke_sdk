import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'flutter_dd_dataoke_sdk.dart';

class DdTaokeSdkWeb {
  static void registerWith(Registrar registrar) {
    final pluginInstance = DdTaokeSdkWeb();
    FlutterDdDataokeSdk.instance = pluginInstance;
  }

  /// 判断是否为微信浏览器
  bool isWeChatBrowser() {
    final ua = html.window.navigator.userAgent.toLowerCase();
    return ua.indexOf('micromessenger') != -1 && kIsWeb;
  }
}
