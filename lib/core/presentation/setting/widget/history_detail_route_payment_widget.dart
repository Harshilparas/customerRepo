import 'package:deride_user/core/presentation/setting/model/history_model.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';

class RoutePaymentWidget extends StatelessWidget {
  final HistoryOrder? item;

  const RoutePaymentWidget({
    super.key,
    this.item,
  });

  @override
  Widget build(BuildContext context) {
    Dev.log("item?.paymentStatus>>>${item?.paymentStatus}");
    bool   paymentIsComplete=item?.paymentStatus==1;
    return Column(
      children: [
        Container(
          width: context.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.color40AFD2D.withOpacity(0.06)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                routeRow("Distance", "${item?.distance ?? ""}KM", context),
                context.sizeH(2),
                /*   routeRow("Time Taken", "${timeTaken}", context),
                context.sizeH(2),*/
                routeRow(
                    "Cab Type",
                    "${item?.category?.category ?? ""}( ${item?.category?.seat ?? ""} Persons)",
                    context),
                context.sizeH(2),
                routeRow("Price", "\$${item?.category?.priceKm ?? ""}", context),
                context.sizeH(2),
                // routeRow("Tip", "\$${item?.tip ?? ""}", context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      msg: "Total",
                      color: AppColors.color001E00,
                      textSize: 16,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                    ),
                    TextWidget(
                      msg: '\$${getAmount(item)}',
                      color: AppColors.color001E00,
                      textSize: 16,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: context.screenHeight * 0.048,
          width: context.screenWidth,
          color: (paymentIsComplete?AppColors.color40AFD2D:AppColors.colorFF3B30).withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  msg: "Payment ${paymentIsComplete?"Complete":"Pending"}",
                  font: FontMixin.mediumFamily,
                  fontWeight: FontMixin.fontWeightMedium,
                  textSize: 14,
                  color: Colors.black,
                ),
                TextWidget(
                  msg: "\$${getAmount(item)}",
                  font: FontMixin.boldFamily,
                  fontWeight: FontMixin.fontWeightBold,
                  textSize: 14,
                  color: AppColors.color080809,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  //widget
  Widget routeRow(String? msg1, String? msg2, context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              msg: msg1,
              color: AppColors.color5E6D55,
              textSize: 16,
              font: FontMixin.regularFamily,
              fontWeight: FontMixin.fontWeightRegular,
            ),
            TextWidget(
              msg: msg2,
              color: AppColors.color001E00,
              textSize: 16,
              font: FontMixin.mediumFamily,
              fontWeight: FontMixin.fontWeightMedium,
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: AppColors.color40AFD2D.withOpacity(0.12),
        )
      ],
    );
  }

  String getAmount(HistoryOrder? item) {
    return ((double.tryParse(item?.total.toString()??"0.0")??0) + (double.tryParse(item?.tip.toString()??"0.0")??0)).toStringAsFixed(2) ;
  }
}
