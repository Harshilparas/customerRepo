// ignore_for_file: use_build_context_synchronously

import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/provider/reset_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/login/view/login_view.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ResetPassRepo {
  // <------------------ Reset pass function -------------> //
  static resetPassFunction(
      {String? email, String? pass, BuildContext? context}) async {
    ProgressDialog.showProgressDialog(context!);
    final response = await ApiService().callPostApi(
        {"email": email, "password": pass}, NetworkConstant.resetPassEndPoint);
    if (response["success"] == 1) {
      Navigator.pop(context);
      context.showAnimatedToast(response["message"]);
      Navigator.pushNamed(context, LoginView.routeName);
      Provider.of<ResetPassProvider>(context, listen: false).clearController();
      Provider.of<ForgotPassProvider>(context, listen: false).clearController();
      return response;
    } else {
      Navigator.pop(context);
      context.showAnimatedToast(response["message"]);
    }
  }
}
