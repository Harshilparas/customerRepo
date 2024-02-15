// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:deride_user/core/presentation/authentication/create_profile/provider/create_profile_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../network/locator/locator.dart';
import '../../../home/provider/home_view_provider.dart';
import '../../../home/provider/location_provider.dart';

abstract class CreateProfileRepository {
//<--------------- Upload File and return to string url function -------------->  //
  static uploadFileFunction(File image) async {
    var response = await ApiService().uploadFile(image);
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
      var locationProvider = locator<LocationProvider>();
      var homeViewProvider = locator<HomeViewProvider>();


      locationProvider.initializeMarkerBitMap();
      homeViewProvider.clearController();
      Navigator.pushNamed(context, HomeView.routeName);
      Provider.of<CreateProfileProvider>(context, listen: false)
          .clearController();
      SharedPreferencesManager().seIsLogin(true);

      return response;
    } else {
      Navigator.pop(context);

      return null;
    }
  }
}
