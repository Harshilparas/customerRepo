

import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_image_strings.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/text_widget.dart';

class AverageRatingWidget extends StatelessWidget {
  final String rating;
  final String totalReview;
  AverageRatingWidget({super.key,required this.rating,required this.totalReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.color0F40AF2D,
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          TextWidget(
            msg: double.tryParse(rating??"0")?.toStringAsFixed(1)??'0',
            textAlign: TextAlign.center,
            color: AppColors.secondary,
            textSize: 34,
            font: FontMixin.mediumFamily,
          ),
          context.sizeW(3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IgnorePointer(
                child: RatingBar.builder(
                  initialRating: double.parse(rating),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                  itemBuilder: (context, _) => AppImagesPath.starIcon.svg,
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              context.sizeH(1),
              TextWidget(
                msg: 'Based On ${totalReview} Reviews',
                textAlign: TextAlign.center,
                color: AppColors.color5E6D55,
                textSize: 12,
                font: FontMixin.mediumFamily,
              ),
            ],
          )
        ],
      ),
    );
  }
}