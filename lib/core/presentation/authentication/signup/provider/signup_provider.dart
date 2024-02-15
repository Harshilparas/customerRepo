import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/app_constant/app_strings.dart';
import '../repository/sign_up_repo.dart';

class SignupProvider extends ChangeNotifier {
// Edit Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isChecked = false;
  bool isPassVisible = false;
  bool isConfirmPassVisible = false;
  // method to change checked value
  void changeCheckedValue() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void changeIsPassStatus() {
    isPassVisible = !isPassVisible;
    notifyListeners();
  }

  void changeIsConfirmPassStatus() {
    isConfirmPassVisible = !isConfirmPassVisible;
    notifyListeners();
  }

  /// validate feild
  validateField() {
    if (emailController.text.trim().isEmpty) {
      return AppStrings.emailErrorMsgEmpty;
    } else if (!emailController.text.isValidEmail()) {
      return AppStrings.emailErrorMsg;
    } else if (passwordController.text.trim().isEmpty) {
      return AppStrings.passwordErrorMsgEmpty;
    } else if (!isStrongPassword(passwordController.text)) {
      return AppStrings.passShouldContain;
    } else if (confirmPasswordController.text.trim().isEmpty) {
      return AppStrings.confirmPasswordErrorMsgEmpty;
    } else if (passwordController.text != confirmPasswordController.text) {
      return AppStrings.passDontMatch;
    } else if (!isChecked) {
      return AppStrings.termsError;
    } else {
      return "";
    }
  }

  /// Api Call Function s
  signUpApiCallFunction(BuildContext context) async {
    if (validateField() == "") {
      await SignupRepository.signupCall(
          emailController.text, passwordController.text, context);
    } else {
     context.showAnimatedToast(validateField().toString());
    }
  }
}
