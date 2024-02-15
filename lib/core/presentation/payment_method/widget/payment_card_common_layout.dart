import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/text_widget.dart';

class PaymentCardCommonLayout extends StatelessWidget {
  Widget ?radioButton;
  Widget ?imageName;
  String ?msg;
  PaymentCardCommonLayout({Key? key,this.radioButton,this.msg,this.imageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: context.screenHeight * 0.06,
                width: context.screenHeight * 0.06,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.color48BF5B33.withOpacity(
                        0.2)),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: imageName,
                ),
              ),
              context.sizeW(2.3),
              TextWidget(
                msg: msg!,
                fontWeight: FontMixin.fontWeightMedium,
                textSize: 16,
                color: AppColors.color001E00,
                font: FontMixin.mediumFamily,
              ),
            ],
          ),
          radioButton!
          // Transform.scale(
          //   scale: 1.5,
          //   child: Radio(
          //       activeColor: AppColors.color153B0E,
          //       value: type,
          //       groupValue: provider.radioButtonValue,
          //       onChanged: (v) {
          //         provider.changeRadioValue(v!);
          //       }),
          // ),
        ],
      ),
    );
  }
}
