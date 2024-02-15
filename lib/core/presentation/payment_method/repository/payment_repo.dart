import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PaymentRepo{
  static getCard()async{
    final response = await ApiService().callPostApi({},NetworkConstant.cardList,token: SharedPreferencesManager().token);
    if(response['success'] == 1){
      return response;
    }else if(response['success']==0){
      return  response;

    }else{
      return null;
    }
  }
}
abstract class AddCardRepo{
  static addCard(BuildContext context)async{
    ProgressDialog.showProgressDialog(context);
    final response = await ApiService().callPostApi({
    }, NetworkConstant.carddetailadd,token: SharedPreferencesManager().token);
    if(response['success']==1){
    
       Navigator.pop(context);
    //========//
      return response;
    }else if(response['success']==0){
      return response;
    }else{
      return response;
    }
  }


}
abstract class RemoveCardRepo{
  static removeCard(BuildContext context,cardId)async{
    ProgressDialog.showProgressDialog(context);
    final response = await ApiService().callPostApi({
      'id':cardId
    }, NetworkConstant.cardDelete,token: SharedPreferencesManager().token);
    if(response['success']==1){
      Navigator.pop(context);
      return response;
    }else{
      return response;
    }
  }
}
abstract class AddCouponRepo{
  static addCoupon(BuildContext context)async{

    final response = await ApiService().callGetApi(NetworkConstant.getCoupons,token: SharedPreferencesManager().token);
    if(response['success']==1){

      return response;

    }else {
      return response;
    }

  }

}