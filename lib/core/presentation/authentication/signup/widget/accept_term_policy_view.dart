
import 'package:deride_user/core/presentation/setting/view/privacy_policy_view.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constant/app_strings.dart';
import '../../../../../utils/fonts.dart';
import '../../../setting/view/terms_policy_view.dart';
import '../provider/signup_provider.dart';

class AcceptTermPolicyView extends StatefulWidget {
  const AcceptTermPolicyView({super.key});

  @override
  State<AcceptTermPolicyView> createState() => _AcceptTermPolicyViewState();
}

class _AcceptTermPolicyViewState extends State<AcceptTermPolicyView> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(
      builder: (context,provider,_) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: provider.isChecked,
                checkColor: Colors.white,
                activeColor: AppColors.color40AFD2D,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                   side: BorderSide(
                   width: 2
                  )
                ),
                onChanged: (value) {
                 provider.changeCheckedValue();
                },
              ),
            ),
            Expanded(
              child: RichText(
                text:   TextSpan(
                  text: AppStrings.byCreating,
                  style: TextStyle(
                      color: AppColors.color5E6D55,
                      fontFamily: FontMixin.regularFamily,
                      fontSize: 16,
                      fontWeight: FontMixin.fontWeightRegular),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = (){
                        Navigator.pushNamed(context, TermsPolicy.routeName);},
                      text: AppStrings.termService,
                      style: const TextStyle(
                          color: AppColors.color153B0E,
                          fontFamily: FontMixin.mediumFamily,
                          fontSize: 16,
                          fontWeight: FontMixin.fontWeightMedium),
                    ),
                    const TextSpan(
                      text: "and ",
                      style: TextStyle(
                          color: AppColors.color5E6D55,
                          fontFamily: FontMixin.regularFamily,
                          fontSize: 16,
                          fontWeight: FontMixin.fontWeightRegular),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = (){
                        Navigator.pushNamed(context, PrivacyPolicyView.routeName);},

                      text: AppStrings.policy,
                      style: const TextStyle(
                          color: AppColors.color153B0E,
                          fontFamily: FontMixin.mediumFamily,
                          fontSize: 16,
                          fontWeight: FontMixin.fontWeightMedium),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
