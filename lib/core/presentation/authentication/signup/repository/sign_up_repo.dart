
import 'dart:io';

import 'package:deride_user/core/presentation/authentication/create_profile/provider/create_profile_provider.dart';
import 'package:deride_user/core/presentation/authentication/create_profile/view/create_profile_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../network/basic/local_db.dart';
import '../../../../../network/basic/network_constant.dart';
import '../../../home/provider/location_provider.dart';

abstract class SignupRepository {
  static signupCall(String email, String pass, BuildContext context) async {
    ProgressDialog.showProgressDialog(context);
    var response = await ApiService().callPostApi({
      "email": email,
      "password": pass,
      "fcm_token":SharedPreferencesManager().deviceToken ?? '',
      "latitude":Provider.of<LocationProvider>(context, listen: false)
          .currentLatLng?.latitude.toString(),
      'longitude':Provider.of<LocationProvider>(context, listen: false)
          .currentLatLng?.longitude.toString(),
      "device_type": Platform.isAndroid ? "Android" : "Ios"

    }, NetworkConstant.signUpEndpoint,
   //  isPlain: true,

    );
    // ignore: use_build_context_synchronously
    var provider = Provider.of<SharedPreferencesManager>(context,listen: false);
    if (response["success"] == 1) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      context.showAnimatedToast(response["message"]);
   //   provider.setToken(response['data']["token"]);
    //  provider.setChatToken(response['data']['user']['chat_token'].toString());
      Provider.of<SharedPreferencesManager>(context, listen: false).setUserId(response['data']["user"]['id'].toString());
      Provider.of<SharedPreferencesManager>(context, listen: false).setChatToken(response['data']["user"]['chat_token'].toString());
      Provider.of<SharedPreferencesManager>(context, listen: false).setToken(response['data']['token']);



      // ignore: use_build_context_synchronously
       Navigator.pushNamed(context, CreateProfileView.routeName);
       Provider.of<CreateProfileProvider>(context,listen: false).clearController();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      context.showAnimatedToast(response["message"]);
    }
  }
}
