import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../utils/mixin/dev.mixin.dart';
import '../../request/provider/socket_provider.dart';
import '../provider/receipt_provider.dart';
import '../view/fedback/view/submit_feedback_successfull_view.dart';

abstract class ReceiptRepo{
  // <-------- driver Rating ------------> //
  static receiptRepo(BuildContext context,orderId,userId,comment,rating)async{
    ProgressDialog.showProgressDialog(context);
    final response = await ApiService().callPostApi({
      'id':userId,
      'order_id':orderId,
      'type':1,
      'rating':rating,
      'review':comment

    }, NetworkConstant.orderRating,token: SharedPreferencesManager().token);
    if(response['success'] == 1){
      comment ="";
      rating=0;

      print("ggghgg${comment.toString()}");
      print('kkk${rating.toString()}');

      Provider.of<ReceiptProvider>(context,listen: false).claerContoller();
      Navigator.pop(context);

      Dev.log("----> $response" );


  //    comment ="";
      Navigator.pushNamed(
          context, SubmitFeedbackSuccessfully.routeName);

    }
    else{
      context.showAnimatedToast(response['message']);
    }
  }
}