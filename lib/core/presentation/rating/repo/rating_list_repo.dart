import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';

abstract class RaingListRepo{
  static getRatingList(id)async{
final response = await ApiService().callPostApi({
  'type':1,
  'id':id,}, NetworkConstant.ratingList,token: SharedPreferencesManager().token);

if(response['success']==1){
  return response;
}else{
  return response;
}
  }
}