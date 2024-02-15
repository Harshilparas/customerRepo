import 'package:deride_user/core/presentation/authentication/forgot_pass/repository/forgot_pass_repo.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/material.dart';

class ForgotPassProvider extends ChangeNotifier {
// <------------Textediting Controller --------------> //

  TextEditingController emailEdt = TextEditingController();

// <----------------- Validting Feild ----------------> //

  validateFeild() {
    if (emailEdt.text.trim().isEmpty) {
      return AppStrings.emailErrorMsgEmpty;
    } else if (!emailEdt.text.isValidEmail()) {
      return AppStrings.emailErrorMsg;
    } else {
      return '';
    }
  }

  // <--------------  Api Call Function ----------> //
  void apiCallFunction(BuildContext context, {int type = 0}) async {
    if (validateFeild() == "") {
      await ForgotPassRepository.forgotPassFunction(
          email: emailEdt.text, context: context, type: type);
    } else {
      context.showAnimatedToast(validateFeild().toString());
    }
  }

  // <---------------- Clear controller ----------. //

  void clearController() {
    emailEdt.clear();
    notifyListeners();
  }
}
