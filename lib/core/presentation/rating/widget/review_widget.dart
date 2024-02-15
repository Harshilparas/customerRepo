import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_image_strings.dart';
import '../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/text_widget.dart';

class ReviewWidget extends StatelessWidget {
 final String ? name;
 final String ? image;
 final String ? date;
 final String ? rating;
 final String ? description;

  const ReviewWidget({Key? key,this.name,this.date,this.description,this.rating,this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width:context.screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50), // Image border
                child: SizedBox(
                  height: 37.7,
                  width: 37.7,
                  child: Image.network('https://php.parastechnologies.in/de-ride/public/${image??""}', fit: BoxFit.cover),
                ),
              ),
              context.sizeW(2.5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      msg: name,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      color: AppColors.color001E00,
                      textSize: 16,
                    ),
                    TextWidget(
                      msg: DateFormat('dd MMMM yyyy').format(DateTime.parse(date.toString())),
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightRegular,
                      color: AppColors.color5E6D55,
                      textSize: 10,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFE6B045), size: 20),
                  TextWidget(
                    msg: rating,
                    color: AppColors.secondary,
                    textSize: 16,
                    font: FontMixin.mediumFamily,
                  ),
                ],
              )
            ],
          ),
        ),
        context.sizeH(1.5),
        TextWidget(
          msg: description,
          font: FontMixin.mediumFamily,
          fontWeight: FontMixin.fontWeightRegular,
          color: AppColors.color001E00,
          textSize: 12,
        ),
        context.sizeH(2.5)
      ],
    );
  }
}
