## 购物app通用接口 flutter 版本
仅供学习使用,可以直接运行例子

[![pub](https://badgen.net/pub/v/dd_taoke_sdk)](https://pub.dev/packages/dd_taoke_sdk)



# 1.初始化
在main函数中添加如下代码
```dart
 DdTaokeUtil.instance.init('http://itbug.shop', '8088',proxy: '');
```

# 2.使用

```dart

void main() {
  // final proxy = '192.168.199.68:2333';
  // DdTaokeUtil.instance.init('http://192.168.199.68', '8088', proxy: '');
  DdTaokeUtil.instance.init('http://itbug.shop', '8088', proxy: '');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('接口')),
      body: SingleChildScrollView(
        child: Wrap(
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
              final result = await DdTaokeSdk.instance.getBrandList(
                  param: BrandListParam(cid: '2', pageId: '1', pageSize: '20'));
              toJsonView(result);
            }),
            MyButton('商品列表', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getProducts(param: ProductListParam(pageId: '1'));
              toJsonView(result);
            }),
            MyButton('商品详情', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getProductDetail(param: ProductDetailParam(id: '32731926'));
              toJsonView(result);
            }),
            MyButton('获取品牌商品', onTap: () async {
              final result = await DdTaokeSdk.instance.getBrandDetail(
                  param: BrandProductParam(
                      brandId: '3424764', pageSize: '20', pageId: "1"));
              toJsonView(result);
            }),
            MyButton('获取详情页面所需数据', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getDetailBaseData(productId: '32448990');
              toJsonView(result);
            }),
            MyButton('高效转链', onTap: () async {
              Get.dialog<String>(InputDialog(
                title: '请输入淘宝商品id',
              )).then((value) async {
                if (!GetUtils.isNullOrBlank(value)) {
                  final result = await DdTaokeSdk.instance
                      .getCouponsDetail(taobaoGoodsId: value);
                  toJsonView(result);
                }
              });
            }),
            MyButton('高佣精选商品', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getHighCommissionProducts(
                  param: HighCommissionParam(pageId: '1', pageSize: '20'));
              toJsonView(result);
            }),
            MyButton('获取商品的推广素材数据', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getProductMaterial(productId: '32448990');
              toJsonView(result);
            }),
            MyButton('获取热搜榜', onTap: () async {
              final result = await DdTaokeSdk.instance.getHotSearchWorlds();
              toJsonView(result);
            }),
            MyButton('获取线报列表', onTap: () async {
              final result = await DdTaokeSdk.instance.getSpeiderList(
                  param: SpeiderParam(pageId: '2', pageSize: '10', topic: '1'));
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
              final result = await DdTaokeSdk.instance
                  .getTaobaoOnepriceProducts(
                  param: TaobaoOnePriceParam(pageId: '1'));
              toJsonView(result);
            }),
            MyButton('朋友圈文案商品', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getWechat(param: WechatParam(pageId: '1', pageSize: '10'));
              toJsonView(result);
            }),
            MyButton('获取榜单商品', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getTopProducts(param: TopParam(pageId: '1', rankType: '1'));
              toJsonView(result);
            }),
            MyButton('九块九包邮', onTap: () async {
              final result = await DdTaokeSdk.instance.getNineNineProducts(
                  param: NineNineParam(
                      pageId: '1', nineCid: '-1', pageSize: '20'));
              toJsonView(result);
            }),
            MyButton('获取评论(暂无返回数据)', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getProductComments(param: CommentParam(id: '32731926'));
            }),
            MyButton('店铺转链', onTap: () async {
              final result = await DdTaokeSdk.instance.shopConvert(
                  param: ShopConvertParam(
                      sellerId: '', shopName: null, pid: null));
            }),
            MyButton('获取细分类目商品', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getSubdivisionProducts(subdivisionId: '249');
              toJsonView(result);
            }),
            MyButton('折上折', onTap: () async {
              final result = await DdTaokeSdk.instance.getDiscountTwoProduct(
                  param: DiscountTwoParam(
                      pageId: '1', pageSize: '10', sort: DdSort.defaultSort));
              toJsonView(result);
            }),
            MyButton('每日半价', onTap: () async {
              final result = await DdTaokeSdk.instance.getHalfdayProducts();
              toJsonView(result);
            }),
            MyButton('获取商品历史价格', onTap: () async {
              final result = await DdTaokeSdk.instance
                  .getProductHistoryPrice(productId: '32731926');
              toJsonView(result);
            }),
            MyButton('直播好货', onTap: () async {
              final result = await DdTaokeSdk.instance.getLiveDataProducts();
              toJsonView(result);
            }),
            MyButton('每日爆品', onTap: () async {
              final result = await DdTaokeSdk.instance.getHotDayProduct(
                  param: HotdayParam(pageId: '1', pageSize: '10'));
              toJsonView(result);
            }),
            MyButton('咚咚抢', onTap: () async {
              final result = await DdTaokeSdk.instance.getDdq();
              toJsonView(result);
            })
          ],
        ),
      ),
    );
  }
}



```

```
![img_1.png](img_1.png)
flutter packages pub publish --server=https://pub.dartlang.org
```