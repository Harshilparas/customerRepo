// ignore_for_file: use_build_context_synchronously

import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/view/otp_verification_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/widgets.dart';

abstract class ForgotPassRepository {
// <----------------Function to call forgot pass api -----------------> //
  static forgotPassFunction(
      {String? email, BuildContext? context, int type = 0}) async {
    ProgressDialog.showProgressDialog(context!);

    final response = await ApiService().callPostApi(
        {"email": email, "type": "User"}, NetworkConstant.forgotPassEndPoint);
    if (response["success"] == 1) {
      Navigator.pop(context);
      context.showAnimatedToast(response['message']);
      if (type == 0) {
        Navigator.pushNamed(context, OtpVerificationView.routeName);
      }
      return response;
    } else {
      Navigator.pop(context);
      context.showAnimatedToast(response['message']);
    }
  }
}
