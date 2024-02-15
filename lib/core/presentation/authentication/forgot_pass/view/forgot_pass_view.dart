import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/view/otp_verification_view.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constant/app_strings.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/widget/text_feild_widget.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({super.key});

  static const routeName = '/forgot_pass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Consumer<ForgotPassProvider>(builder: (context, pro, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  context.sizeH(2),
                  SizedBox(
                    height: context.screenHeight * 0.3,
                    width: context.screenHeight * 0.3,
                    child: AppImagesPath.forgotPassLogo.svg,
                  ).center(),
                  TextWidget(
                    msg: AppStrings.forgotPass,
                    fontWeight: FontMixin.fontWeightBold,
                    font: FontMixin.boldFamily,
                    color: AppColors.color001E00,
                    textSize: 25,
                  ),
                  context.sizeH(1),
                  TextWidget(
                    msg: AppStrings.forgotPassSubHeading,
                    fontWeight: FontMixin.fontWeightRegular,
                    font: FontMixin.regularFamily,
                    color: AppColors.color5E6D55,
                    textSize: 15,
                  ),
                  context.sizeH(4),
                  CommonTextfeild(
                    tittle: AppStrings.email,
                    msg: "Enter Email",
                    color: Colors.black,
                    isEnable: true,
                    textSize: 15,
                    editController: pro.emailEdt,
                    backImage: "",
                    isPassword: false,
                    isDropDown: false,
                  ),
                  context.sizeH(2),
                  ButtonWidget(
                    msg: AppStrings.submit,
                    fontColor: AppColors.colorWhite,
                    callback: () {
                      // Navigator.pushNamed(context, OtpVerificationView.routeName);
                      pro.apiCallFunction(context);
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
