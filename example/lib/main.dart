import 'package:dd_taoke_sdk/constant/sort.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/jd_api.dart';
import 'package:dd_taoke_sdk/model/jd/jd_req_param.dart';
import 'package:dd_taoke_sdk/network/util.dart';
import 'package:dd_taoke_sdk/params/activity_link_param.dart';
import 'package:dd_taoke_sdk/params/brand_param.dart';
import 'package:dd_taoke_sdk/params/brand_product_param.dart';
import 'package:dd_taoke_sdk/params/comment_param.dart';
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
import 'package:dd_taoke_sdk/public_api.dart';
import 'component/buttom.dart';
import 'component/input_model.dart';
import 'test/hotday_page.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/json_result_page.dart';

void main() {
  // final proxy = '192.168.199.68:2333';
  DdTaokeUtil.instance.init('http://192.168.100.15', '80', proxy: '', onStart: (dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (cert, host, port) {
        return true;
      };
    };
  },debug: false,printParams: true); // 我测试用的
  // DdTaokeUtil.instance.init('http://itbug.shop', '80', proxy: ''); // 服务器的接口
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('接口'),
        actions: [
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Get.to(() => HotDayPage());
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MyButton('超级分类', onTap: () async {
              final resut = await DdTaokeSdk.instance.getCategorys();
              toJsonView(resut);
            }),
            MyButton('轮播图', onTap: () async {
              final resut = await DdTaokeSdk.instance.getCarousel();
              toJsonView(resut);
            }),
            MyButton('品牌列表', onTap: () async {
              final result = await DdTaokeSdk.instance.getBrandList(param: BrandListParam(cid: '2', pageId: '1', pageSize: '20'));

              toJsonView(result);
            }),
            MyButton('商品列表', onTap: () async {
              final result = await DdTaokeSdk.instance.getProducts(param: ProductListParam(pageId: '1'));
              toJsonView(result);
            }),
            MyButton('商品详情', onTap: () async {
              final result = await DdTaokeSdk.instance.getProductDetail(param: ProductDetailParam(id: '35685974'));
              toJsonView(result);
            }),
            MyButton('获取品牌商品', onTap: () async {
              final result = await DdTaokeSdk.instance.getBrandDetail(param: BrandProductParam(brandId: '7951745', pageSize: '20', pageId: '1'));
              toJsonView(result);
            }),
            MyButton('获取详情页面所需数据', onTap: () async {
              final result = await DdTaokeSdk.instance.getDetailBaseData(productId: '35685974');
              toJsonView(result);
            }),
            MyButton('高效转链', onTap: () async {
              await Get.dialog<String>(InputDialog(
                title: '请输入淘宝商品id',
              )).then((value) async {
                if (!GetUtils.isNullOrBlank(value)) {
                  final result = await DdTaokeSdk.instance.getCouponsDetail(taobaoGoodsId: value);
                  toJsonView(result);
                }
              });
            }),
            MyButton('高佣精选商品', onTap: () async {
              final result = await DdTaokeSdk.instance.getHighCommissionProducts(param: HighCommissionParam(pageId: '1', pageSize: '20'));
              toJsonView(result);
            }),
            MyButton('获取商品的推广素材数据', onTap: () async {
              final result = await DdTaokeSdk.instance.getProductMaterial(productId: '32448990');
              toJsonView(result);
            }),
            MyButton('获取热搜榜', onTap: () async {
              final result = await DdTaokeSdk.instance.getHotSearchWorlds();
              toJsonView(result);
            }),
            MyButton('获取线报列表', onTap: () async {
              final result = await DdTaokeSdk.instance.getSpeiderList(param: SpeiderParam(pageId: '2', pageSize: '10', topic: '1'));
              toJsonView(result);
            }),
            MyButton('超级搜索', onTap: () async {
              final result = await DdTaokeSdk.instance.superSearch(
                  param: SuperSearchParam(
                keyWords: '辣条',
                pageSize: '1',
                type: '0',
                pageId: '1',
              ));
              toJsonView(result);
            }),
            MyButton('淘宝官方活动(一元购)', onTap: () async {
              final result = await DdTaokeSdk.instance.getTaobaoOnepriceProducts(param: TaobaoOnePriceParam(pageId: '1'));
              toJsonView(result);
            }),
            MyButton('朋友圈文案商品', onTap: () async {
              final result = await DdTaokeSdk.instance.getWechat(param: WechatParam(pageId: '1', pageSize: '10'));
              toJsonView(result);
            }),
            MyButton('获取榜单商品', onTap: () async {
              final result = await DdTaokeSdk.instance.getTopProducts(param: TopParam(pageId: '1', rankType: '1'));
              toJsonView(result);
            }),
            MyButton('九块九包邮', onTap: () async {
              final result = await DdTaokeSdk.instance.getNineNineProducts(param: NineNineParam(pageId: '1', nineCid: '-1', pageSize: '20'));
              toJsonView(result);
            }),
            MyButton('获取评论(暂无返回数据)', onTap: () async {
              final result = await DdTaokeSdk.instance.getProductComments(param: CommentParam(id: '32731926'));
              toJsonView(result);
            }),
            MyButton('店铺转链', onTap: () async {
              final result = await DdTaokeSdk.instance.shopConvert(param: ShopConvertParam(sellerId: '', shopName: null, pid: null));
              toJsonView(result);
            }),
            MyButton('获取细分类目商品', onTap: () async {
              final result = await DdTaokeSdk.instance.getSubdivisionProducts(subdivisionId: '249');
              toJsonView(result);
            }),
            MyButton('折上折', onTap: () async {
              final result = await DdTaokeSdk.instance.getDiscountTwoProduct(param: DiscountTwoParam(pageId: '1', pageSize: '10', sort: DdSort.defaultSort));
              toJsonView(result);
            }),
            MyButton('每日半价', onTap: () async {
              final result = await DdTaokeSdk.instance.getHalfdayProducts();
              toJsonView(result);
            }),
            MyButton('获取商品历史价格', onTap: () async {
              final result = await DdTaokeSdk.instance.getProductHistoryPrice(productId: '32731926');
              toJsonView(result);
            }),
            MyButton('直播好货', onTap: () async {
              final result = await DdTaokeSdk.instance.getLiveDataProducts();
              toJsonView(result);
            }),
            MyButton('每日爆品', onTap: () async {
              final result = await DdTaokeSdk.instance.getHotDayProduct(param: HotdayParam(pageId: '1', pageSize: '10'));
              toJsonView(result);
            }),
            MyButton('咚咚抢', onTap: () async {
              final result = await DdTaokeSdk.instance.getDdq();
              toJsonView(result);
            }),
            MyButton('获取线报(时间段抢购)', onTap: () async {
              final result = await DdTaokeSdk.instance.getSpeiderListWithTime(param: SpeiderParam());
              toJsonView(result);
            }),
            MyButton('活动转链', onTap: () async {
              final activityId = await Get.dialog<String>(InputDialog(
                title: '请输入活动id',
              ));
              if (activityId != null) {
                final result = await DdTaokeSdk.instance.getActivityLink(ActivityLinkParam(promotionSceneId: activityId));
                toJsonView(result);
              }
            }),
            MyButton('搜索建议', onTap: () async {
              final resul = await DdTaokeSdk.instance.getSuggest();
              toJsonView(resul);
            }),
            MyButton('京东9块9', onTap: () async {
             final products =  await DdTaokeSdk.instance.jdNinesList(5, 20, 0);
             toJsonView(products);
            }),
            MyButton('京东产品详情', onTap: () async {
              final products =  await DdTaokeSdk.instance.jdDetail('10327875287');
              toJsonView(products);
            }),
            MyButton('京东实时榜单', onTap: () async {
              final products =  await DdTaokeSdk.instance.jdPhb(20, 20);
              toJsonView(products);
            }),
            MyButton('京东大牌折扣商品', onTap: () async {
              final products =  await DdTaokeSdk.instance.jdDpzk(1, 20);
              toJsonView(products);
            }),
            MyButton('用户注册测试', onTap: (){
              PublicApi.req.register('diandian', '1234567', 'https://static.saintic.com/picbed/huang/2021/08/17/1629169985486.jpg',otherDataHandle: (data){
                print(data);
              },apiError: (code,msg,data){
                print(code);
                print(msg);
                print(data);
              }).then((value) {
                if(value){
                  print('注册成功');
                }
              });
            }),
            MyButton('登录测试', onTap: (){
              PublicApi.req.login('diandian', '1234567',tokenHandle: (token){
                print('登录获取的token是:$token');
              },loginFail: (msg){
                print('登录失败:$msg');
              });
            })
            ,
            MyButton('获取系统预设头像', onTap: ()async{
             final result = await PublicApi.req.getAvaPics();
             toJsonView(result);
            }),
            MyButton('创建游戏房间', onTap: (){
              PublicApi.req.createRoom(46, '梁典典进');
            }),
            MyButton('获取全部的游戏房间', onTap: () async {
              final result = await PublicApi.req.getAllRoom();
              print('获取到房间数量:${result.length}');
            }),
            MyButton('获取当前在线总人数', onTap: (){
              PublicApi.req.getInlineUserCount();
            }),
            MyButton('获取京东商品', onTap: ()async{

             final result= await JdApi.instance.getProducts(JdReqParam(eliteId: 2));
             toJsonView(result);
              
            }),
            MyButton('京东商品查询', onTap: ()async{

              final result= await JdApi.instance.searchProducts(error: (c,m,d){
                print(c);
                print(m);
                print(d);
              },params: {'keyword':'辣条'});
              toJsonView(result);

            })
          ],
        ),
      ),
    );
  }
}
