import 'package:deride_user/core/presentation/setting/model/history_model.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';

class HistoryDetailsCustomerDetailsView extends StatelessWidget {
  final HistoryOrder? item;

  const HistoryDetailsCustomerDetailsView({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: context.screenWidth,
          decoration: BoxDecoration(
              color: AppColors.colorWhite,
              border: Border.all(
                color: AppColors.color5E6D55.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  height: context.screenHeight * 0.055,
                  width: context.screenHeight * 0.055,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipOval(
                      child: (item?.image == null || (item?.image?.isEmpty??false))
                          ? AppImagesPath.dummyUserImage.image()
                          : Image.network(
                              "${NetworkConstant.imageBaseUrl}${item?.image}",
                              fit: BoxFit.fill,
                            )),
                ),
                context.sizeW(3.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      msg: item?.driverName ?? "",
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 16,
                      color: AppColors.color001E00,
                    ),
                    context.sizeH(0.5),
                    Row(
                      children: [
                        SizedBox(
                          height: 15,
                          width: 15,
                          child: AppImagesPath.starIcon.svg,
                        ),
                        TextWidget(
                          msg: double.parse(((item?.rating == null
                              ? "0.0"
                              : item?.rating.toString()) ??
                              "0")).toStringAsFixed(1),
                          font: FontMixin.mediumFamily,
                          fontWeight: FontMixin.fontWeightMedium,
                          textSize: 14,
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      msg: item?.category?.category??'',
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 14,
                      color: AppColors.color5E6D55,
                    ),
                    context.sizeH(0.5),
                    TextWidget(
                        msg: item?.plateNumber??"",
                        font: FontMixin.mediumFamily,
                        fontWeight: FontMixin.fontWeightMedium,
                        textSize: 14,
                        color: AppColors.color001E00),
                  ],
                ),
              ],
            ),
          ),
        ),
        context.sizeH(2.2),

        /// pickup location row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: AppImagesPath.pickupIcon.svg,
            ),
            context.sizeW(3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    msg: AppStrings.pickupLocation,
                    font: FontMixin.mediumFamily,
                    fontWeight: FontMixin.fontWeightMedium,
                    textSize: 18,
                    color: AppColors.color001E00,
                  ),
                  context.sizeH(1),
                  TextWidget(
                    msg: item?.startAddress ?? "",
                    font: FontMixin.regularFamily,
                    fontWeight: FontMixin.fontWeightRegular,
                    textSize: 16,
                    color: AppColors.color5E6D55,
                  ),
                ],
              ),
            )
          ],
        ),
        context.sizeH(2),
        Container(
          height: 1,
          width: context.screenWidth,
          color: Colors.black.withOpacity(0.12),
        ),
        context.sizeH(2),

        /// Drop location row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: AppImagesPath.dropIcon.svg,
            ),
            context.sizeW(3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    msg: AppStrings.dropLocation,
                    font: FontMixin.mediumFamily,
                    fontWeight: FontMixin.fontWeightMedium,
                    textSize: 18,
                    color: AppColors.color001E00,
                  ),
                  context.sizeH(1),
                  TextWidget(
                    msg: item?.endAddress ?? "",
                    font: FontMixin.regularFamily,
                    fontWeight: FontMixin.fontWeightRegular,
                    textSize: 16,
                    color: AppColors.color5E6D55,
                  ),
                ],
              ),
            )
          ],
        ),
        context.sizeH(2.5),

        /// Payment type view
        Container(
          width: context.screenWidth,
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.color5E6D55.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  msg: "Payment Through",
                  font: FontMixin.mediumFamily,
                  fontWeight: FontMixin.fontWeightMedium,
                  textSize: 14,
                  color: AppColors.color001E00,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: AppImagesPath.masterCardLogo.svg,
                    ),
                    context.sizeW(2),
                    TextWidget(
                      msg: AppStrings.card,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 14,
                      color: AppColors.color5E6D55,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
