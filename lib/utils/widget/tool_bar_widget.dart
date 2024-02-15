import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';

import '../app_constant/app_colors.dart';

class ToolBarWidget extends StatelessWidget {
  final String tittle;
  final Function()? back;

  const ToolBarWidget({super.key, required this.tittle, this.back});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: back??() => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_sharp,
            color: AppColors.color232323,
            size: 25,
          ),
        ),
        TextWidget(
          msg: tittle ?? '',
          font: FontMixin.mediumFamily,
          fontWeight: FontMixin.fontWeightMedium,
          color: AppColors.color001E00,
          textSize: 20,
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
class ToolBarWithOutBackWidget extends StatelessWidget {
  final String tittle;

   ToolBarWithOutBackWidget({super.key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        TextWidget(
          msg: tittle ?? '',
          font: FontMixin.mediumFamily,
          fontWeight: FontMixin.fontWeightMedium,
          color: AppColors.color001E00,
          textSize: 20,
        ),
        const SizedBox(
          width: 15,
        )
      ],
    );
  }
}
