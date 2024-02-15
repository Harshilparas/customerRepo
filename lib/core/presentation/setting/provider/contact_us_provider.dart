import 'package:deride_user/core/presentation/setting/repository/contact_us_repo.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/material.dart';

class ContactUsProvider extends ChangeNotifier {
  // <------------------ TEXTEDITING CONTROLLER ---------------> //
  TextEditingController emailEdt = TextEditingController();
  TextEditingController subjectEdt = TextEditingController();
  TextEditingController messageEdt = TextEditingController();

  // <-------------------- VALIDAING FEILDS ------------------> //

  validateField() {
    if (emailEdt.text.trim().isEmpty) {
      return AppStrings.emailErrorMsgEmpty;
    } else if (!emailEdt.text.isValidEmail()) {
      return AppStrings.emailErrorMsg;
    }
    // else if (subjectEdt.text.trim().isEmpty) {
    //   return "Enter Subject";
    // }
    else if (messageEdt.text.trim().isEmpty) {
      return "Enter Message";
    } else {
      return "";
    }
  }

  // <---------------  Function to call api after validting the fields ---------->  //
  apiCallContactUs(BuildContext context) {
    if (validateField() == "") {
      final response = ContactusRepository.contactUsFunction(
          context: context,
          body: {
            'email': emailEdt.text,
            "message": messageEdt.text,
            'type': '1'
          });
    } else {
      context.showAnimatedToast(validateField().toString());
    }
  }
}
