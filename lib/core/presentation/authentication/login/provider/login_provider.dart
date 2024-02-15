
import 'package:deride_user/core/presentation/authentication/login/repository/login_repo.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  static final LoginProvider _loginProvider = LoginProvider.internal();

  factory LoginProvider() {
    return _loginProvider;
  }

  LoginProvider.internal();



  // Text editing controller
  final TextEditingController emailController = TextEditingController(text:
  kDebugMode?
  // "deryde@gmail.com"
  "user01@yopmail.com"
      :"");
  final TextEditingController passwordController = TextEditingController(text:
  kDebugMode?
  // "A123456a@"
  "Test@1234"
      :
  "");

  valiadteFeild() {
    if (emailController.text.trim().isEmpty) {
      return AppStrings.emailErrorMsgEmpty;
    } else if (!emailController.text.isValidEmail()) {
      return AppStrings.emailErrorMsg;
    } else if (passwordController.text.isEmpty) {
      return AppStrings.passwordErrorMsgEmpty;
    } else {
      return "";
    }
  }

  // Login Api Call
  loginApiCall(
    BuildContext context,
  ) async {
    if (valiadteFeild() == "") {
      await LoginRepository.loginFunction(
          context, emailController.text, passwordController.text);
    } else {
      context.showAnimatedToast(valiadteFeild().toString());
    }
  }

    // <---------------  CLEAR TEXTEDITING CONTROLLER ---------------> //

  clearController() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
