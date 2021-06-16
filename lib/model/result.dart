// To parse this JSON data, do
//
//     final ddTaokeResult = ddTaokeResultFromJson(jsonString);

import 'dart:convert';

DdTaokeResult ddTaokeResultFromJson(String str) => DdTaokeResult.fromJson(json.decode(str));

String ddTaokeResultToJson(DdTaokeResult data) => json.encode(data.toJson());

class DdTaokeResult {
  DdTaokeResult({
    this.state,
    this.message,
    this.data,
  });

  int? state;
  String? message;
  String? data;

  factory DdTaokeResult.fromJson(Map<String, dynamic> json) => DdTaokeResult(
    state: json["state"],
    message: json["message"],
    data: json["data"] is Map<String,dynamic> ? jsonEncode(json['data']) : json['data'],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "message": message,
    "data": data,
  };
}
