// ignore_for_file: use_build_context_synchronously

import 'package:deride_user/core/presentation/authentication/forgot_pass/view/reset_password_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/material.dart';

abstract class OtpRepository {
// <--------------Verify Otp Function ---------------> //
  static otpVerifyFunction(
      {String? otp, BuildContext? context, String? email}) async {
    ProgressDialog.showProgressDialog(context!);

    final response = await ApiService().callPostApi({
      "email": email,
      "type": "User",
      "otp": otp,
    }, NetworkConstant.verifyOtp);

    if (response["success"] == 1) {
      Navigator.pop(context);
      context.showAnimatedToast(response["message"]);
      Navigator.pushNamed(context, ResetPasswordView.routeName);
      return response;
    } else {
      Navigator.pop(context);
      context.showAnimatedToast(response["message"]);
    }
  }
}
