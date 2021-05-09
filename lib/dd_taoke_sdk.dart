import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dd_taoke_sdk/model/brand_list_model.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/network/util.dart';
import 'package:dd_taoke_sdk/params/activity_link_param.dart';
import 'package:dd_taoke_sdk/params/brand_param.dart';
import 'package:dd_taoke_sdk/params/brand_product_param.dart';
import 'package:dd_taoke_sdk/params/comment_param.dart';
import 'package:dd_taoke_sdk/params/coupons_detail_link_param.dart';
import 'package:dd_taoke_sdk/params/discount_two_param.dart';
import 'package:dd_taoke_sdk/params/high_commission_param.dart';
import 'package:dd_taoke_sdk/params/hotday_param.dart';
import 'package:dd_taoke_sdk/params/nine_nine_param.dart';
import 'package:dd_taoke_sdk/params/product_detail_param.dart';
import 'package:dd_taoke_sdk/params/product_list_param.dart';
import 'package:dd_taoke_sdk/params/shop_convert_param.dart';
import 'package:dd_taoke_sdk/params/speider_param.dart';
import 'package:dd_taoke_sdk/params/super_search_param.dart';
import 'package:dd_taoke_sdk/params/taobao_oneprice_param.dart';
import 'package:dd_taoke_sdk/params/top_param.dart';
import 'package:dd_taoke_sdk/params/wechat_param.dart';
import 'package:get/get.dart';

import 'model/activity-link_result.dart';
import 'model/brand_detail_result.dart';
import 'model/carousel_model.dart';
import 'model/coupon_link_result.dart';
import 'model/ddq_result.dart';
import 'model/detail_base_data.dart';
import 'model/discount_two_result.dart';
import 'model/halfday_result.dart';
import 'model/high_commission_result.dart';
import 'model/history_price_result.dart';
import 'model/hot_search_worlds_result.dart';
import 'model/hotday_result.dart';
import 'model/live_data_result.dart';
import 'model/nine_nine_result.dart';
import 'model/product_list_result.dart';
import 'model/product_material_result.dart';
import 'model/speider_resullt.dart';
import 'model/super_search_result.dart';
import 'model/taobao_oneprice_result.dart';
import 'model/wechat_result.dart';
import 'network/util.dart';

class DdTaokeSdk {
  DdTaokeSdk._();

  static DdTaokeSdk get instance => DdTaokeSdk._();

  factory DdTaokeSdk() => instance;

  final util = DdTaokeUtil();

  /// 获取超级分类
  Future<List<Category>> getCategorys({ApiError? error}) async {
    final response = await util.get('/categorys', error: error);
    return response.isNotEmpty ? categoryFromJson(response) : [];
  }

  /// 获取轮播图
  Future<List<Carousel>> getCarousel({ApiError? error}) async {
    final response = await util.get('/carousel-list', error: error);
    return response.isNotEmpty ? carouselFromJson(response) : [];
  }

  /// 获取品牌列表
  Future<BrandListResult?> getBrandList({required BrandListParam param, ApiError? error}) async {
    final response = await util.get('/brand-list', data: param.toJson(), error: error);
    return response.isNotEmpty ? brandListResultFromJson(response) : null;
  }

  /// 获取商品列表
  Future<ProductListResult?> getProducts({required ProductListParam param, ApiError? error}) async {
    final response = await util.get('/goods', data: param.toJson(), error: error);
    return response.isNotEmpty ? productListFromJson(response) : null;
  }

  /// 获取商品详情
  Future<Product?> getProductDetail({required ProductDetailParam param, ApiError? error}) async {
    final response = await util.get('/detail', data: param.toJson(), error: error);
    return response.isNotEmpty ? productFromJson(response) : null;
  }

  /// 获取品牌详情
  Future<BrandDetail?> getBrandDetail({required BrandProductParam param, ApiError? error}) async {
    final response = await util.get('/brand-detail', data: param.toJson(), error: error);
    return response.isNotEmpty ? brandDetailFromJson(response) : null;
  }

  /// 高效转链
  /// [taobaoGoodsId] 是淘宝的商品id ,不是大淘客的id
  Future<CouponLinkResult?> getCouponsDetail({required String taobaoGoodsId, ApiError? error}) async {
    final response =
        await util.get('/privilege-link', data: CouponsDetailParam(goodsId: taobaoGoodsId).toJson(), error: error);
    return response.isNotEmpty ? CouponLinkResult.fromJson(jsonDecode(response)) : null;
  }

  /// 获取商品详情页面所需的基本数据
  Future<DetailBaseDataResult?> getDetailBaseData({required String productId}) async {
    final response = await util.get('/product-detail-all/$productId');
    var result;

    if (response.isNotEmpty) {
      final map = jsonDecode(response);
      final info = map['detail'];
      final products = map['similarList'];
      final coupon = map['privieleLink'];

      var list = <Product>[];
      for (final item in jsonDecode(products)) {
        list.add(Product.fromJson(item));
      }

      result = DetailBaseDataResult(
          info: Product.fromJson(jsonDecode(info)),
          similarProducts: list,
          couponInfo: CouponLinkResult.fromJson(jsonDecode(coupon)));
    }

    return result;
  }

  /// 获取高佣精选商品
  Future<HighCommissionResult?> getHighCommissionProducts({required HighCommissionParam param, ApiError? error}) async {
    final url = '/high-commission';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? highCommissionResultFromJson(response) : null;
  }

  /// 获取商品的推广素材
  /// 商品精推素材
  /// [productId] 大淘客商品id或者淘宝商品id
  Future<ProductMaterialResult?> getProductMaterial({required String productId, ApiError? error}) async {
    final url = '/product-material';
    final response = await util.get(url, data: {"id": productId}, error: error);
    return (response.isNotEmpty
        ? (productMaterialResultFromJson(response).isNotEmpty ? productMaterialResultFromJson(response)[0] : null)
        : []) as FutureOr<ProductMaterialResult?>;
  }

  /// hot-search-worlds
  /// 热搜榜
  Future<List<HotSearchWorlds>> getHotSearchWorlds({ApiError? error}) async {
    final url = '/hot-search-worlds';
    final response = await util.get(url, error: error);
    return response.isNotEmpty ? hotSearchWorldsFromJson(response) : [];
  }

  /// 获取线报
  Future<Map<String, dynamic>?> getSpeiderList({required SpeiderParam param, ApiError? error}) async {
    final url = '/speider';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? jsonDecode(response) : null;
  }

  /// 线报分支 整点抢购 topic = 3
  Future<SpeiderWithTimeResult?> getSpeiderListWithTime({required SpeiderParam param, ApiError? error}) async {
    param.topic = '3';
    final result = await getSpeiderList(param: param, error: error);
    return result != null ? SpeiderWithTimeResult.fromJson(result) : null;
  }

  /// 超级搜索
  Future<SuperSearchResult?> superSearch({required SuperSearchParam param, ApiError? error}) async {
    final url = '/super-search';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? superSearchResultFromJson(response) : null;
  }

  /// 官方活动 (淘宝一元购)
  /// /taobao-oneprice_product
  Future<List<TaobaoOnePriceResult>> getTaobaoOnepriceProducts(
      {required TaobaoOnePriceParam param, ApiError? error}) async {
    final url = '/taobao-oneprice_product';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? taobaoOnePriceResultFromJson(response) : [];
  }

  /// 朋友圈文案
  Future<WechatResult?> getWechat({required WechatParam param, ApiError? error}) async {
    final url = '/wechat';
    final responst = await util.get(url, data: param.toJson(), error: error);
    return responst.isNotEmpty ? WechatResult.fromJson(jsonDecode(responst)) : null;
  }

  /// 获取榜单商品
  Future<List<Product>> getTopProducts({required TopParam param, ApiError? error}) async {
    final url = '/top';
    final response = await util.get(url, error: error, data: param.toJson());
    return response.isNotEmpty ? getProductsWithResponse(response) : [];
  }

  /// 九块九包邮
  Future<NineNineResult?> getNineNineProducts({required NineNineParam param, ApiError? error}) async {
    final url = '/nine-nine-goods';
    final response = await util.get(url, error: error, data: param.toJson());
    return response.isNotEmpty ? nineNineResultFromJson(response) : null;
  }

  /// 获取商品评论
  @Deprecated('商品评论因为采集受限所以暂时没有数据')
  Future<String?> getProductComments({required CommentParam param, ApiError? error}) async {
    final url = '/comment';
    final response = await util.get(url, error: error, data: param.toJson());
    return response;
  }

  /// 店铺转链
  Future<String> shopConvert({required ShopConvertParam param, ApiError? error}) async {
    final url = '/shop-convert';
    final response = await util.get(url, error: error, data: param.toJson());
    Get.log(response);
    return response;
  }

  /// 细分类目商品
  /// /subdivision-goods
  Future<List<Product>> getSubdivisionProducts({required String subdivisionId, ApiError? error}) async {
    final url = '/subdivision-goods';
    final response = await util.get(url, error: error, data: {'subdivisionId': subdivisionId});
    return response.isNotEmpty ? getProductsWithResponse(response) : [];
  }

  /// 折上折 商品
  /// discount-goods
  Future<DiscountTwoResult?> getDiscountTwoProduct({required DiscountTwoParam param, ApiError? error}) async {
    final url = '/discount-goods';
    final response = await util.get(url, error: error, data: param.toJson());
    return response.isNotEmpty ? discountTwoResultFromJson(response) : null;
  }

  /// 每日半价
  /// halfday-goods
  Future<HalfdayResult?> getHalfdayProducts({
    String sessions = '',
    ApiError? error,
  }) async {
    final url = '/halfday-goods';
    final response = await util.get(url, error: error, data: sessions.isNotEmpty ? {'sessions': sessions} : {});
    return response.isNotEmpty ? halfdayResultFromJson(response) : null;
  }

  /// 获取商品的历史价格
  /// goods-history
  Future<HistoryPriceResult?> getProductHistoryPrice(
      {String productId = '', String taobaoGoodsId = '', ApiError? error}) async {
    final url = '/goods-history';
    final response = await util.get(url, error: error, data: {'id': productId, 'goodsId': taobaoGoodsId});
    return response.isNotEmpty ? historyPriceResultFromJson(response) : null;
  }

  /// 直播好货
  /// live-data
  Future<LiveDataResult?> getLiveDataProducts({String date = '', String sort = '0', ApiError? error}) async {
    final url = '/live-data';
    final response = await util.get(url, data: {'date': date, 'sort': sort}, error: error);
    return response.isNotEmpty ? liveDataResultFromJson(response) : null;
  }

  /// 每日爆品
  /// hot-day
  Future<HotdayResult?> getHotDayProduct({required HotdayParam param, ApiError? error}) async {
    final url = '/hot-day';
    final response = await util.get(url, data: param.toJson(), error: error);
    return response.isNotEmpty ? hotdayResultFromJson(response) : null;
  }

  /// 咚咚抢
  /// ddq
  Future<DdqResult?> getDdq({String roundTime = '', ApiError? error}) async {
    final url = '/ddq';
    final response = await util.get(url, data: {'roundTime': roundTime}, error: error);
    return response.isNotEmpty ? ddqResultFromJson(response) : null;
  }

  /// 官方活动转链
  Future<ActivityLinkResult?> getActivityLink(ActivityLinkParam param,{ApiError? error}) async {
    final url = '/activity-link';
    final response = await util.get(url,data: param.toJson(),error: error);
    return response.isNotEmpty ? ActivityLinkResult.fromJson(jsonDecode(response)) : null;
  }

}
