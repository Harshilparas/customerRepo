import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/provider/reset_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/login/view/login_view.dart';
import 'package:deride_user/core/presentation/authentication/signup/provider/signup_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constant/app_strings.dart';
import '../../../../../utils/widget/button_widget.dart';
import '../../../../../utils/widget/text_feild_widget.dart';
import '../../../../../utils/widget/text_widget.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  static const routeName = '/resetPass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(20.0),
          child: Consumer2(builder: (context,ResetPassProvider provider,SignupProvider proSignUp, _) {
            return SingleChildScrollView(
         
                child: Column(
                  children: [
                    context.sizeH(2),
                    SizedBox(
                      height: context.screenHeight * 0.25,
                      width: context.screenHeight * 0.25,
                      child: AppImagesPath.resetPassLogo.svg,
                    ).center(),
                    context.sizeH(5),
                    TextWidget(
                      msg: AppStrings.resetPassHeading,
                      textSize: 25,
                      font: FontMixin.boldFamily,
                      fontWeight: FontMixin.fontWeightBold,
                      color: AppColors.color001E00,
                    ),
                    context.sizeH(1),
                    TextWidget(
                      msg: AppStrings.resetPassSubHeading,
                      textSize: 15,
                      font: FontMixin.regularFamily,
                      fontWeight: FontMixin.fontWeightRegular,
                      color: AppColors.color5E6D55,
                      textAlign: TextAlign.center,
                    ),
                    context.sizeH(3),
                    CommonTextfeild(
                      tittle: AppStrings.newPass,
                      msg: "Enter New Password",
                      color: Colors.black,
                      isEnable: true,
                      textSize: 15,
                      editController: provider.newPassController,
                      backImage: "",
                      isPassword: true,
                      obscureText: proSignUp.isPassVisible,
                      isDropDown: false,
                      onChange: () {
                        // <-------------- Change the status of pass   visible ------------> //
                        proSignUp.changeIsPassStatus();
                      },
                    ),
                    CommonTextfeild(
                      tittle: AppStrings.confirmPass,
                      msg: "Re Enter Password",
                      color: Colors.black,
                      isEnable: true,
                      textSize: 15,
                      editController: provider.confirmPassController,
                      backImage: "",
                      isPassword: true,
                      obscureText: proSignUp.isConfirmPassVisible,
                      isDropDown: false,
                      onChange: () {
                        // <-------------- Change the status of pass   visible ------------> //
                        proSignUp.changeIsConfirmPassStatus();
                      },
                    ),
                    context.sizeH(3),
                    ButtonWidget(
                      msg: AppStrings.resetPassHeading,
                      fontColor: AppColors.colorWhite,
                      callback: () {
                        // Navigator.pushNamed(context, LoginView.routeName);
                        provider.apiCallFunction(context);
                      },
                    )
                  ],
                )
        
            );
          }),
        ),
      ),
    );
  }
}
