

import 'model/jd/jd_req_param.dart';
import 'network/util.dart';

class JdApi {

  JdApi._();
  factory JdApi()=> JdApi._();
  static JdApi get instance => JdApi._();

  final util = DdTaokeUtil();


  /// 加载产品列表
  Future<String> getProducts(JdReqParam jdReqParam) async {
  return await util.get(_jdurl('products'),data: jdReqParam.toJson(),isTaokeApi: false);
  }


  String _jdurl(String url){
    return '/api/jd/$url';
  }

}