import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/provider/otp_verification_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/view/reset_password_view.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/widget/text_widget.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpVerificationProvider>(builder: (context, provider, _) {
      return Column(
        children: [
          OTPTextField(
            length: 4,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 50,
            style: const TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              provider.setPin(pin);
              print("Completed: ${provider.pin}");
            },
            onChanged: (pin) {
              provider.setPin(pin);
              print("Completed: ${provider.pin}");
            },
          ),
          context.sizeH(5),
          ButtonWidget(
            msg: AppStrings.verify,
            fontColor: AppColors.colorWhite,
            callback: () {
              // Navigator.pushNamed(context, ResetPasswordView.routeName);
              provider.apiCallFunction(context);
            },
          ),
          context.sizeH(3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                msg: AppStrings.doNotReceiveCode,
                fontWeight: FontMixin.fontWeightRegular,
                font: FontMixin.regularFamily,
                textSize: 14,
                color: AppColors.color5E6D55,
              ),
              InkWell(
                onTap: () {
                  // <------- Resent Otp ------------? //
                  Provider.of<ForgotPassProvider>(context, listen: false)
                      .apiCallFunction(context, type: 1);
                },
                child: const Text(
                  AppStrings.resendCode,
                  style: TextStyle(
                      fontWeight: FontMixin.fontWeightMedium,
                      fontFamily: FontMixin.mediumFamily,
                      color: AppColors.color153B0E,
                      fontSize: 14,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
