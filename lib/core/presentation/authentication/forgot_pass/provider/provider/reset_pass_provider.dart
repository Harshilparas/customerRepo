import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/repository/reset_pass_repo.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassProvider extends ChangeNotifier {
  // TEXT_EDITING_CONTROLLER
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  TextEditingController get newPassController => _newPassController;

  TextEditingController get confirmPassController => _confirmPassController;

// <----------------- Validate Feild ----------->

  valiadteFeild() {
    if (_newPassController.text.trim().isEmpty) {
      return "Enter New Password";
    } else if (!isStrongPassword(_newPassController.text)) {
      return AppStrings.passShouldContain;
    } else if (_confirmPassController.text.trim().isEmpty) {
      return "Re Enter Password";
    } else if (_newPassController.text != _confirmPassController.text) {
      return "Password Does Not Match";
    } else {
      return "";
    }
  }

// <-------------------- Api call Provider -------------------> //
  apiCallFunction(BuildContext context) async {
    if (valiadteFeild() == "") {
      await ResetPassRepo.resetPassFunction(
          email: Provider.of<ForgotPassProvider>(context, listen: false)
              .emailEdt
              .text,
          pass: _confirmPassController.text,
          context: context);
    } else {
      context.showAnimatedToast(valiadteFeild().toString());
    }
  }

  // <--------------  Reset controller clear ------------ > //

  clearController() {
    newPassController.clear();
    confirmPassController.clear();
    notifyListeners();
  }  
}
