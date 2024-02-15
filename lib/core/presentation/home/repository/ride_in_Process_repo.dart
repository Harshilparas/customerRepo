import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../../../network/basic/common_network.dart';
import '../../../../utils/mixin/dev.mixin.dart';

abstract class RideInProgressRepo {
  static receiptScreenRepo( orderId) async {
  //  ProgressDialog.showProgressDialog(context);
    final response = await ApiService().callGetApi( "${NetworkConstant.rideInProcess}$orderId",token: SharedPreferencesManager().token);
    if(response['success'] == 1){
      return response;
    }else{
    return   response;
    }
  }
}