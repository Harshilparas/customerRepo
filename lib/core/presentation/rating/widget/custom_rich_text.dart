import 'package:flutter/material.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/fonts.dart';

class CustomRichText extends StatelessWidget {
  final String? name;
  final String? Subname;

  const CustomRichText({Key? key, this.name,this.Subname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: name,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontMixin.fontWeightRegular,
            color: AppColors.color001E00,
            fontFamily:FontMixin.mediumFamily),
        children:  [
          TextSpan(
            text:Subname,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color:  AppColors.color001E00,
            ),
          )
        ],
      ),
    );
  }
}