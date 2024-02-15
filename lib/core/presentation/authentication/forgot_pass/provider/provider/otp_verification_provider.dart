import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/repository/otp_verification_repo.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OtpVerificationProvider extends ChangeNotifier {
  String? _pin ='';

  String? get pin => _pin;

  // METHOD TO SET THE PIN
  setPin(String pin) {
    _pin = pin;
    notifyListeners();
  }

  // <------------- Validate Feild ------------>
  validateFeild() {
    if (_pin!.trim().isEmpty) {
      return "Enter Otp";
    } else if (_pin!.length != 4) {
      return "Otp Must Be of 4 Character";
    } else {
      return "";
    }
  }

  // <------------ Api Call  function to verify the otp ------------------> //

  apiCallFunction(BuildContext context) async {
    if (validateFeild() == "") {
      await OtpRepository.otpVerifyFunction(
          otp: _pin,
          context: context,
          email: Provider.of<ForgotPassProvider>(context, listen: false)
              .emailEdt
              .text);
    } else {
      context.showAnimatedToast(validateFeild().toString());
    }
  }
}
