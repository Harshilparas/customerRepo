import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';

abstract class RequestRepo {
  // <-------- Get Vechile Price Catergory ------------> //
  static getVechilePriceCat(Map<String, dynamic> body) async {
    final response = await ApiService()
        .callPostApi(body, NetworkConstant.priceCategoryVechile, isPlain: false);
    if (response["success"] == true) {
      return response;
    } else {
      return response;
    }
  }
}
