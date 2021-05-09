import 'dart:convert';

import 'package:dd_taoke_sdk/model/coupon_link_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';

class DetailBaseDataResult {
  Product? info; // 商品的基本信息
  List<Product>? similarProducts; // 相似列表,默认10条
  CouponLinkResult? couponInfo; // 领券相关

  DetailBaseDataResult({this.info, this.couponInfo, this.similarProducts});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'info': jsonEncode(info),
      'similarProducts': jsonEncode(similarProducts),
      'couponInfo': couponInfo.toString()
    };
  }
}
