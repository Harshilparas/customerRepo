// ignore_for_file: use_build_context_synchronously

import 'package:deride_user/core/presentation/authentication/create_profile/provider/create_profile_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/setting/view/setting_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileRepo {
// <--------- Get profile ----------------> //
  static getProfile() async {
    final response = await ApiService().callGetApi(
        NetworkConstant.getProfileEndPoint,
        token: SharedPreferencesManager().token);
    if (response["success"] == 1) {
      return response;
    } else {
      return null;
    }
  }

  // <-------------------  Personal Details Function -----------------------> //
  static personalDetailFunction(
      Map<String, dynamic> body, BuildContext context) async {
    var provider = Provider.of<CreateProfileProvider>(context, listen: false);
    ProgressDialog.showProgressDialog(context);
    var response = await ApiService().callPostApi(
      body,
      NetworkConstant.createProfileEndPoint,
      token: SharedPreferencesManager().token,
    );
    if (response["success"] == 1) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Navigator.pushNamed(context, SettingView.routeName);

      return response;
    } else {
      Navigator.pop(context);

      return null;
    }
  }
}
