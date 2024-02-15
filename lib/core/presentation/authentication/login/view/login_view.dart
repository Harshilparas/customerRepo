import 'package:deride_user/core/presentation/authentication/forgot_pass/view/forgot_pass_view.dart';
import 'package:deride_user/core/presentation/authentication/login/provider/login_provider.dart';
import 'package:deride_user/core/presentation/authentication/signup/provider/signup_provider.dart';
import 'package:deride_user/core/presentation/authentication/signup/view/signup_view.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/fonts.dart';
import '../../../../../utils/widget/text_widget.dart';
import '../../../home/provider/location_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {

    super.initState();
    Provider.of<LocationProvider>(context, listen: false)
        .getUserCurrentLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Consumer<LoginProvider>(builder: (context, provider, _) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    context.sizeH(2),
                    SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.height * 0.12,
                            child: AppImagesPath.logoPath.image())
                        .center(),
                    context.sizeH(2.0),
                    TextWidget(
                      msg: AppStrings.loginHeading,
                      color: AppColors.color001E00,
                      font: FontMixin.boldFamily,
                      fontWeight: FontMixin.fontWeightBold,
                      maxLine: 1,
                      textSize: 25,
                    ),
                    context.sizeH(0.5),
                    TextWidget(
                      msg: AppStrings.loginSubHeading,
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
                    Consumer<SignupProvider>(builder: (context, proSignUp, _) {
                      return CommonTextfeild(
                        tittle: AppStrings.password,
                        msg: "Enter Password",
                        color: Colors.black,
                        textSize: 15,
                        editController: provider.passwordController,
                        backImage: "",
                        isPassword: true,
                        obscureText: proSignUp.isPassVisible,
                        isDropDown: false,
                        onChange: () {
                          proSignUp.changeIsPassStatus();
                        },
                      );
                    }),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Provider.of<LocationProvider>(context, listen: false)
                              .getUserCurrentLocation(context);
                          Navigator.pushNamed(
                              context, ForgotPassView.routeName);
                          LoginProvider().clearController();
                        },
                        child: TextWidget(
                          msg: AppStrings.forgotPassword,
                          color: AppColors.color153B0E,
                          fontWeight: FontMixin.fontWeightMedium,
                          font: FontMixin.mediumFamily,
                          textSize: 16,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    context.sizeH(2.5),

                    /// login button
                    ButtonWidget(
                        msg: AppStrings.login,
                        fontColor: AppColors.colorWhite,
                        callback: () {
                          provider.loginApiCall(context);
                          // Navigator.pushNamed(context, HomeView.routeName);
                        }),
                    context.sizeH(2),
                    TextWidget(
                      msg: AppStrings.orLoginWith,
                      textSize: 16,
                      font: FontMixin.regularFamily,
                      fontWeight: FontMixin.fontWeightRegular,
                    ),
                    context.sizeH(2),
                    ButtonWidget(
                        bgBolor: AppColors.colorF2F7F2,
                        msg: AppStrings.loginWithFacebook,
                        widget: Image.asset(
                          AppImagesPath.facebookIcon,
                          height: MediaQuery.of(context).size.height * 0.04,
                        )),
                    context.sizeH(2),
                    ButtonWidgetActions(
                        msg: AppStrings.notMember,
                        bgBolor: AppColors.colorF2F7F2,
                        widget: SvgPicture.asset(
                          AppImagesPath.alreadyMemberIcon,
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        callback: () {
                          Navigator.pushNamed(context, SignupView.routeName);
                          LoginProvider().clearController();
                        }),
                    context.sizeH(4.5),
                  ]);
            }),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextWidget(
          msg: AppStrings.skipNow,
          color: AppColors.color5E6D55,
          fontWeight: FontMixin.fontWeightMedium,
          font: FontMixin.mediumFamily,
          textSize: 16,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
