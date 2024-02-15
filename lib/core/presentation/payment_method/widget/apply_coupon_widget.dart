import 'dart:developer';

import 'package:deride_user/core/presentation/payment_method/model/coupon_model.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/text_widget.dart';

class ApplyCouponWidget extends StatelessWidget {
  final TextEditingController? controller;

  const ApplyCouponWidget({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentMethodProvider>(builder: (context, provider, _) {
      return Column(
        children: [
          Container(
            width: context.screenWidth,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.6, vertical: 10.6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.color5E6D55), // Add a border.
              borderRadius: BorderRadius.circular(10.0), // Add a border radius.
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    controller: provider.applyCouponController,
                    decoration: const InputDecoration(
                      hintText: AppStrings.applyCoupon,

                      hintStyle: TextStyle(
                          fontFamily: FontMixin.mediumFamily,
                          fontSize: 14,
                          fontWeight: FontMixin.fontWeightRegular),
                      border: InputBorder.none, // Remove the default underline.
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Available Coupons"),
                            insetPadding: const EdgeInsets.all(12),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (provider.getCoupon.isEmpty) ...{
                                    const Center(child: Text("No Data Found "))
                                  } else ...{
                                    for (int index = 0;
                                        index < provider.getCoupon.length;
                                        index++) ...{
                                      coupan(provider.getCoupon[index],provider,context)
                                    }
                                  }
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    width: context.screenWidth * 0.30,
                    height: context.screenHeight * 0.050,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius.
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                          msg: AppStrings.checkCoupon,
                          fontWeight: FontMixin.fontWeightMedium,
                          textSize: 15,
                          color: Colors.white,
                          font: FontMixin.mediumFamily,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  coupan(Coupons coupon, PaymentMethodProvider provider, BuildContext context) {
    return InkWell(
      onTap: (){
        provider.updateCardname(val :coupon);
        Navigator.pop(context);
      },
      child: SizedBox(
        height: 100,
        // width: 120,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.start,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    TextWidget(
                      msg: coupon
                          .name,
                      fontWeight: FontMixin
                          .fontWeightMedium,
                      textSize: 16,
                      color:
                      AppColors.color001E00,
                      font: FontMixin
                          .mediumFamily,
                    ),
                    TextWidget(
                      msg: coupon
                          .expiry,
                      fontWeight: FontMixin
                          .fontWeightMedium,
                      textSize: 12,
                      color:
                      AppColors.color001E00,
                      font: FontMixin
                          .mediumFamily,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextWidget(
                          msg: "Code -",
                          fontWeight: FontMixin
                              .fontWeightMedium,
                          textSize: 14,
                          color:
                          AppColors.color001E00,
                          font: FontMixin
                              .mediumFamily,
                        ),
                        TextWidget(
                          msg: coupon.code,
                          fontWeight: FontMixin
                              .fontWeightMedium,
                          textSize: 12,
                          color:
                          AppColors.color001E00,
                          font: FontMixin
                              .mediumFamily,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Amount -"),
                        Text(coupon.amount.toString()),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
