import 'package:deride_user/core/presentation/authentication/create_profile/view/create_profile_view.dart';
import 'package:deride_user/core/presentation/authentication/login/view/login_view.dart';
import 'package:deride_user/core/presentation/authentication/signup/provider/signup_provider.dart';
import 'package:deride_user/core/presentation/authentication/signup/widget/accept_term_policy_view.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/app_constant/app_image_strings.dart';
import '../../../../../utils/app_constant/app_strings.dart';
import '../../../../../utils/fonts.dart';
import '../../../../../utils/widget/text_feild_widget.dart';
import '../../../../../utils/widget/text_widget.dart';
import '../../../setting/view/terms_policy_view.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Consumer<SignupProvider>(builder: (context, provider, _) {
              return Column(
                children: [
                  context.sizeH(2),
                  const ToolBarWidget(tittle: ""),
                  SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.height * 0.12,
                          child: AppImagesPath.logoPath.image())
                      .center(),
                  context.sizeH(2.0),
                  TextWidget(
                    msg: AppStrings.signupHeading,
                    color: AppColors.color001E00,
                    font: FontMixin.boldFamily,
                    fontWeight: FontMixin.fontWeightBold,
                    maxLine: 1,
                    textSize: 25,
                  ),
                  context.sizeH(0.5),
                  TextWidget(
                    msg: AppStrings.signupSubHeading,
                    color: AppColors.color5E6D55,
                    font: FontMixin.regularFamily,
                    fontWeight: FontMixin.fontWeightRegular,
                    textSize: 15,
                    textAlign: TextAlign.center,
                  ),
                  context.sizeH(5.0),
                  CommonTextfeild(
                    tittle: AppStrings.email,
                    msg: "Enter Email",
                    color: Colors.black,
                    textSize: 15,
                    editController: provider.emailController,
                    backImage: "",
                    isPassword: false,
                    isDropDown: false,
                  ),
                  CommonTextfeild(
                    tittle: AppStrings.password,
                    msg: "Enter Password",
                    color: Colors.black,
                    textSize: 15,
                    editController: provider.passwordController,
                    backImage: "",
                    isPassword: true,
                    obscureText: provider.isPassVisible,
                    isDropDown: false,
                    onChange: () {
                      provider.changeIsPassStatus();
                    },
                  ),
                  CommonTextfeild(
                    tittle: AppStrings.confirmPass,
                    msg: "Enter Password",
                    color: Colors.black,
                    textSize: 15,
                    editController: provider.confirmPasswordController,
                    backImage: "",
                    isPassword: true,
                    obscureText: provider.isConfirmPassVisible,
                    isDropDown: false,
                    onChange: () {
                      provider.changeIsConfirmPassStatus();
                    },
                  ),
                  InkWell(
                      onTap: (){

                      },
                      child:  AcceptTermPolicyView()),
                  context.sizeH(2.5),
                  ButtonWidget(
                    msg: AppStrings.signup,
                    fontColor: AppColors.colorWhite,
                    callback: () {
                      provider.signUpApiCallFunction(context);
                      // Navigator.pushNamed(context, CreateProfileView.routeName);
                    },
                  ),
                  context.sizeH(2.5),
                  ButtonWidgetActions(
                    msg: AppStrings.alreadyMember,
                    bgBolor: AppColors.colorF2F7F2,
                    widget: SvgPicture.asset(
                      AppImagesPath.alreadyMemberIcon,
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    callback: () {
                      Navigator.pushNamed(context, LoginView.routeName);
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
