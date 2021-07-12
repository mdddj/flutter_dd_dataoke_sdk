// To parse this JSON data, do
//
//     final ddTaokeResult = ddTaokeResultFromJson(jsonString);

import 'dart:convert';

import 'dart:developer';

DdTaokeResult ddTaokeResultFromJson(String str) => DdTaokeResult.fromJson(json.decode(str));

String ddTaokeResultToJson(DdTaokeResult data) => json.encode(data.toJson());

class DdTaokeResult {
  DdTaokeResult({this.state, this.message, this.data, this.errors});

  int? state;
  String? message;
  String? data;
  List<ErrorRoot>? errors;

  factory DdTaokeResult.fromJson(Map<String, dynamic> json) {
    var _errors = <ErrorRoot>[];
    if (json['data'] is List<dynamic>) {
      _errors = List<ErrorRoot>.from((json['data'] as List<dynamic>).map((e) => ErrorRoot.fromJson(e))).toList();
    }

    return DdTaokeResult(
        state: json["state"], message: json["message"], data: json["data"] is Map<String, dynamic> ? jsonEncode(json['data']) : (json['data'] is String ? json['data'] : ''), errors: _errors);
  }

  Map<String, dynamic> toJson() => {"state": state, "message": message, "data": data, 'errors': errors.toString()};
}

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}

class FFConvert {
  FFConvert._();

  static T? Function<T extends Object?>(dynamic value) convert = <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final String valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

class ErrorRoot {
  ErrorRoot({
    required this.codes,
    required this.arguments,
    required this.defaultMessage,
    required this.objectName,
    required this.field,
    required this.rejectedValue,
    required this.bindingFailure,
    required this.code,
  });

  factory ErrorRoot.fromJson(Map<String, dynamic> jsonRes) {
    final List<String>? codes = jsonRes['codes'] is List ? <String>[] : null;
    if (codes != null) {
      for (final dynamic item in jsonRes['codes']!) {
        if (item != null) {
          tryCatch(() {
            codes.add(asT<String>(item)!);
          });
        }
      }
    }

    final List<Arguments> arguments = jsonRes['arguments'] is List ? <Arguments>[] : <Arguments>[];
    for (final dynamic item in jsonRes['arguments']!) {
      if (item != null) {
        tryCatch(() {
          arguments.add(Arguments.fromJson(asT<Map<String, dynamic>>(item)!));
        });
      }
    }
    return ErrorRoot(
      codes: codes!,
      arguments: arguments,
      defaultMessage: asT<String>(jsonRes['defaultMessage'])!,
      objectName: asT<String>(jsonRes['objectName'])!,
      field: asT<String>(jsonRes['field'])!,
      rejectedValue: asT<Object>(jsonRes['rejectedValue'])!,
      bindingFailure: asT<bool>(jsonRes['bindingFailure'])!,
      code: asT<String>(jsonRes['code'])!,
    );
  }

  List<String> codes;
  List<Arguments> arguments;
  String defaultMessage;
  String objectName;
  String field;
  Object rejectedValue;
  bool bindingFailure;
  String code;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'codes': codes,
        'arguments': arguments,
        'defaultMessage': defaultMessage,
        'objectName': objectName,
        'field': field,
        'rejectedValue': rejectedValue,
        'bindingFailure': bindingFailure,
        'code': code,
      };

  ErrorRoot clone() => ErrorRoot.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}

class Arguments {
  Arguments({
    required this.codes,
    required this.arguments,
    required this.defaultMessage,
    required this.code,
  });

  factory Arguments.fromJson(Map<String, dynamic> jsonRes) {
    final List<String>? codes = jsonRes['codes'] is List ? <String>[] : null;
    if (codes != null) {
      for (final dynamic item in jsonRes['codes']!) {
        if (item != null) {
          tryCatch(() {
            codes.add(asT<String>(item)!);
          });
        }
      }
    }
    return Arguments(
      codes: codes!,
      arguments: asT<Object>(jsonRes['arguments'])!,
      defaultMessage: asT<String>(jsonRes['defaultMessage'])!,
      code: asT<String>(jsonRes['code'])!,
    );
  }

  List<String> codes;
  Object arguments;
  String defaultMessage;
  String code;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'codes': codes,
        'arguments': arguments,
        'defaultMessage': defaultMessage,
        'code': code,
      };

  Arguments clone() => Arguments.fromJson(asT<Map<String, dynamic>>(jsonDecode(jsonEncode(this)))!);
}
