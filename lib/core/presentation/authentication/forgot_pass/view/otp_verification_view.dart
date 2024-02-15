import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/provider/otp_verification_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/widget/otp_form.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constant/app_image_strings.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});
  static const routeName = '/otpVerification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<OtpVerificationProvider>(builder: (context, pro, _) {
            return Column(
              children: [
                context.sizeH(2),
                SizedBox(
                  height: context.screenHeight * 0.25,
                  width: context.screenHeight * 0.25,
                  child: AppImagesPath.otpVerificationLogo.svg,
                ).center(),
                context.sizeH(5),
                TextWidget(
                  msg: AppStrings.otpVerification,
                  textSize: 25,
                  font: FontMixin.boldFamily,
                  fontWeight: FontMixin.fontWeightBold,
                  color: AppColors.color001E00,
                ),
                context.sizeH(1),
                TextWidget(
                  msg: AppStrings.otpVerificationSubHeading,
                  textSize: 15,
                  font: FontMixin.regularFamily,
                  fontWeight: FontMixin.fontWeightRegular,
                  color: AppColors.color5E6D55,
                  textAlign: TextAlign.center,
                ),
                context.sizeH(1),
                TextWidget(
                  msg: Provider.of<ForgotPassProvider>(context, listen: false)
                          .emailEdt
                          .text ??
                      '',
                  textSize: 15,
                  font: FontMixin.mediumFamily,
                  fontWeight: FontMixin.fontWeightMedium,
                  color: AppColors.color153B0E,
                ),
                context.sizeH(2),
                const OtpForm()
              ],
            );
          }),
        ),
      ),
    );
  }
}
