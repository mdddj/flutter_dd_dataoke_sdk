import 'dart:convert' show json;

import 'package:dd_taoke_sdk/model/product.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class WechatResult {
  WechatResult({
    this.totalNum,
    this.list,
    this.pageId,
  });

  factory WechatResult.fromJson(Map<String, dynamic>? jsonRes) {
    if (jsonRes == null) {
      return null!;
    }
    final List<Product>? list = jsonRes['list'] is List ? <Product>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']) {
        if (item != null) {
          list.add(Product.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }

    return WechatResult(
      totalNum: asT<int>(jsonRes['totalNum']),
      list: list,
      pageId: asT<String>(jsonRes['pageId']),
    );
  }

  int? totalNum;
  List<Product>? list;
  String? pageId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'totalNum': totalNum,
        'list': list,
        'pageId': pageId,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
