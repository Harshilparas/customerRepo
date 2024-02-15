// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:deride_user/core/presentation/authentication/create_profile/view/create_profile_view.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../../../network/locator/locator.dart';
import '../../../../../utils/mixin/dev.mixin.dart';
import '../../../home/provider/home_view_provider.dart';
import '../../../home/provider/location_provider.dart';

abstract class LoginRepository {
  static loginFunction(BuildContext context, String email, String pass) async {
    ProgressDialog.showProgressDialog(context);
    final response = await ApiService().callPostApi({
      "email": email,
      "password": pass,
      "login_type": "app",
      "fcm_token":SharedPreferencesManager().deviceToken ?? '',
      "device_type": Platform.isAndroid ? "Android" : "Ios"
    }, NetworkConstant.loginEndpoint);
    if (response["success"] == 1) {
      if(response['user']['is_complete']==1){
        var sharedPreferencesManager = locator<SharedPreferencesManager>();
        sharedPreferencesManager.setUserId(response["user"]['id'].toString());
        sharedPreferencesManager.setChatToken(response["user"]['chat_token']);
        sharedPreferencesManager.setStripeCustomerId(response["user"]['stripe_customer_id']);
        Navigator.pop(context);
        context.showAnimatedToast(response["message"]);
        var locationProvider = locator<LocationProvider>();
        var homeViewProvider = locator<HomeViewProvider>();


        locationProvider.initializeMarkerBitMap();
        homeViewProvider.clearController();
        Navigator.pushNamed(context, HomeView.routeName);
        SharedPreferencesManager().seIsLogin(true);
        Provider.of<SharedPreferencesManager>(context,listen: false).setToken(response['token']);
        Dev.log("---tkn-> Set Token ${SharedPreferencesManager().token}");
        Dev.log("---chttken-> Set Token ${SharedPreferencesManager().chatToken}");
        log("---strip seccion id-> Set strip seccion id- ${SharedPreferencesManager().stripecustomerid}");

        Dev.log("----> $response" );
      }else{
        Navigator.pushNamed(context, CreateProfileView.routeName);
      }
    } else {
      Navigator.pop(context);
      FocusManager.instance.primaryFocus?.unfocus();
      context.showAnimatedToast(response["message"]);
    }
  }
}
