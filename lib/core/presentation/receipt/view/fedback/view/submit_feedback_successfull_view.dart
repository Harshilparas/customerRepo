import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';

import '../../../../home/view/home_view.dart';

class SubmitFeedbackSuccessfully extends StatelessWidget {
  const SubmitFeedbackSuccessfully({super.key});
  static const routeName =  '/submitFeedbackSuccessfully'; 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                ToolBarWithOutBackWidget(tittle: ""),
                context.sizeH(25),
                SizedBox(
                  height: context.screenHeight * 0.1,
                  child: AppImagesPath.successLogo.svg,
                ),
                context.sizeH(3),
                TextWidget(
                  msg: AppStrings.ratingSubmitted,
                  font: FontMixin.mediumFamily,
                  fontWeight: FontMixin.fontWeightMedium,
                  color: AppColors.color001E00,
                  textSize: 24,
                ),
                context.sizeH(1),
                TextWidget(
                  msg: "your rating has been submitted",
                  font: FontMixin.regularFamily,
                  fontWeight: FontMixin.fontWeightRegular,
                  color: AppColors.color5E6D55,
                  textSize: 14,
                ),
                context.sizeH(1),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ButtonWidget(
                   msg: AppStrings.done,
                   bgBolor: AppColors.color001E00,
                   callback: (){
                     Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName,(route) => false);
                 //   Navigator.pushNamed(context, ReceiptScreen.routeName);
                   },
                   fontColor: AppColors.colorWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
