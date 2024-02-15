import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/widget/text_widget.dart';
import '../../../../utils/app_constant/app_colors.dart';

class SettingTileWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback callback;
  const SettingTileWidget(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 22,
                width: 22,
                child: iconPath.svg,
              ),
              context.sizeW(2),
              TextWidget(
                msg: title ?? '',
                color: AppColors.color001E00,
                font: FontMixin.regularFamily,
                fontWeight: FontMixin.fontWeightMedium,
                textSize: 16,
              )
            ],
          ),
          context.sizeH(2.5),
          Container(
            color: AppColors.colorD2D2D2,
            width: context.screenWidth,
            height: 1,
          ),
          context.sizeH(2.5),
        ],
      ),
    );
  }
}
