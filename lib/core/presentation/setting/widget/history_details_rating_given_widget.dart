import 'dart:developer';

import 'package:deride_user/core/presentation/setting/model/history_model.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingGivenView extends StatefulWidget {
  final HistoryOrder? item;
  const RatingGivenView({super.key, this.item});

  @override
  State<RatingGivenView> createState() => _RatingGivenViewState();
}

class _RatingGivenViewState extends State<RatingGivenView> {
  List<RatingList> givenRatins = [];
  List<RatingList> takenRatins = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getData();

        log(takenRatins.length.toString());
        log(givenRatins.length.toString());

        setState(() {
          log(widget.item.toString());
        });
      },
    );

    super.initState();
  }

  getData() {
    if (widget.item?.ratingList != null &&
        widget.item!.ratingList!.isNotEmpty) {
      for (var element in widget.item!.ratingList!) {
        if (element.type == 1) {
          givenRatins.add(element);
        } else if (element.type == 2) {
          takenRatins.add(element);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        givenRatins.isEmpty
            ? SizedBox()
            : TextWidget(
                msg: AppStrings.ratingGiven,
                font: FontMixin.mediumFamily,
                fontWeight: FontMixin.fontWeightMedium,
                textSize: 16,
                color: AppColors.color001E00,
              ),
        context.sizeH(2.5),
        givenRatins.isEmpty
            ? SizedBox()
            : ListView.builder(
                itemCount: givenRatins.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorF2F7F2),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                itemSize: 20,
                                ignoreGestures: true,
                                glow: true,
                                initialRating: double.parse(
                                    givenRatins[index].rating.toString() ?? ""),
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              context.sizeW(2),
                              TextWidget(
                                msg: "(${double.tryParse(givenRatins[index].rating??"0")})",
                                font: FontMixin.mediumFamily,
                                fontWeight: FontMixin.fontWeightMedium,
                                textSize: 16,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              TextWidget(
                                  msg: givenRatins[index].givenTime,
                                  font: FontMixin.regularFamily,
                                  fontWeight: FontMixin.fontWeightRegular,
                                  textSize: 12,
                                  color: AppColors.color5E6D55),
                            ],
                          ),
                          context.sizeH(2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                  msg: givenRatins[index].review,
                                  font: FontMixin.regularFamily,
                                  fontWeight: FontMixin.fontWeightRegular,
                                  textSize: 14,
                                  textAlign: TextAlign.right,
                                  color: AppColors.color001E00),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        context.sizeH(2),
        takenRatins.isEmpty
            ? SizedBox()
            : TextWidget(
                msg: AppStrings.ratingReceived,
                font: FontMixin.mediumFamily,
                fontWeight: FontMixin.fontWeightMedium,
                textSize: 16,
                color: AppColors.color001E00,
              ),
        context.sizeH(2.5),
        takenRatins.isEmpty
            ? SizedBox()
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: takenRatins.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: context.screenWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.colorF2F7F2),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              RatingBar.builder(
                                itemSize: 20,
                                ignoreGestures: true,
                                glow: true,
                                initialRating: double.parse(
                                    takenRatins[index].rating.toString() ?? ""),
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),

                              // RatingBar(
                              //     ignoreGestures: true,
                              //     updateOnDrag: false,
                              //     itemCount: 5,
                              //     itemSize: 20,
                              //     ratingWidget: RatingWidget(
                              //         full: AppImagesPath.starIcon.svg,
                              //         half: AppImagesPath.starIcon.svg,
                              //         empty: AppImagesPath.starIcon.svg),
                              //     onRatingUpdate: (v) {}),
                              context.sizeW(2),
                              TextWidget(
                                msg: "(${takenRatins[index].rating})",
                                font: FontMixin.mediumFamily,
                                fontWeight: FontMixin.fontWeightMedium,
                                textSize: 16,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              TextWidget(
                                  msg: takenRatins[index].givenTime,
                                  font: FontMixin.regularFamily,
                                  fontWeight: FontMixin.fontWeightRegular,
                                  textSize: 12,
                                  color: AppColors.color5E6D55),
                            ],
                          ),
                          context.sizeH(2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                  msg: takenRatins[index].review,
                                  font: FontMixin.regularFamily,
                                  fontWeight: FontMixin.fontWeightRegular,
                                  textSize: 14,
                                  color: AppColors.color001E00),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
      ],
    );
  }
}
