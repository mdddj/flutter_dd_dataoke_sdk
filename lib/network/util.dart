import 'package:dd_taoke_sdk/model/result.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DdTaokeUtil {
  DdTaokeUtil._();

  static DdTaokeUtil get instance => DdTaokeUtil._();

  factory DdTaokeUtil() => instance;

  static Dio? dio;
  final tkApi = '/tkapi/api/v1/dtk/apis';
  static var _ip = '';
  static var _port = '';
  static var _proxy = '';

  /// 初始化服务器地址和端口
  void init(String host, String port, {String? proxy}) {
    _ip = host;
    _port = port;
    if (proxy != null) _proxy = proxy;
  }

  ///发起http请求
  ///
  ///url 接口地址
  ///
  ///data 查询参数
  ///
  ///error 请求错误回传
  ///
  Future<String> get(String url,
      {Map<String, dynamic>? data, ApiError? error}) async {
    var _dio = createInstance()!;
    if (_proxy.isNotEmpty) addProxy(_dio, _proxy);

    try {
      final response = await _dio.get<String>(url, queryParameters: data);
      if (response.statusCode == 200 && response.data != null) {
        final result = ddTaokeResultFromJson(response.data!);
        if (result.state == 200) {
          if (result.data != null) {
            return result.data!;
          }
          return '';
        } else {
          errorHandle(error, result.state, result.message);
          return '';
        }
      }
    } on DioError catch (e) {
      if (e.response != null) {
        errorHandle(error, e.response!.statusCode, e.response!.statusMessage);
      }
      errorHandle(error, 500, '${e.toString()}');
    }

    return '';
  }

  /// 请求没有正常执行
  void errorHandle(ApiError? error, int? code, String? message) {
    if (error != null) {
      error(code, message);
    } else {
      print('请求失败:code=$code.message=$message');
    }
  }

  /// 创建dio实例
  Dio? createInstance() {
    if (dio == null) {
      final url = '$_ip:$_port$tkApi';
      BaseOptions options = BaseOptions(baseUrl: url, connectTimeout: 20000);
      dio = Dio(options);
    }
    return dio;
  }
}

typedef ApiError = void Function(int? stateCode, String? message);

void addProxy(Dio dio, String ip) {
  var client;
  if (ip.isNotEmpty) {
    if (kIsWeb) {
    } else {
      client = dio.httpClientAdapter as DefaultHttpClientAdapter;
      client.onHttpClientCreate = (_client) {
        _client.findProxy = (uri) {
          return "PROXY $ip";
        };
      };
    }
  }
}
