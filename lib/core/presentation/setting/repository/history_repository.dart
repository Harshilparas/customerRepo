import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:flutter/material.dart';

abstract class HistoryRepo{
  // <--------- Get History ----------------> //
  static getHistory()async{
    final response = await ApiService().callGetApi(NetworkConstant.historyOrderUser,
    token: SharedPreferencesManager().token,);
    if(response['success']==1){
      return response;
    }
    else{
      return response;
    }
  }
}