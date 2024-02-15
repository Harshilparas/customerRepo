import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../../../network/basic/common_network.dart';
import '../../../../utils/mixin/dev.mixin.dart';
import '../view/fedback/view/submit_feedback_successfull_view.dart';

abstract class ReceiptScreenRepo {
  static receiptScreenRepo(BuildContext context, orderId) async {
  //  ProgressDialog.showProgressDialog(context);
    final response = await ApiService().callPostApi({'id':orderId,}, NetworkConstant.orderReceipt,token: SharedPreferencesManager().token);
    if(response['success'] == 1){
  //   Navigator.pop(context);
      return response;
    }else{
    return   null;
    }



  }
}
