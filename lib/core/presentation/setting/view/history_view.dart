import 'package:deride_user/core/presentation/setting/provider/history_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../network/locator/locator.dart';
import '../../home/provider/home_view_provider.dart';
import 'history_details_view.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  static const routeName = '/history';

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        locator<HomeViewProvider>().clearController();
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<HistoryProvider>(builder: (context, pro, _) {
            return  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        /// Top Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  locator<HomeViewProvider>().clearController();
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.arrow_back_sharp)),
                            TextWidget(
                              msg: AppStrings.history,
                              font: FontMixin.mediumFamily,
                              fontWeight: FontMixin.fontWeightMedium,
                              textSize: 18,
                              color: AppColors.color001E00,
                            ),
                            context.sizeW(3.5)
                          ],
                        ),
                        context.sizeH(2),
                        Container(
                          height: 1,
                          width: context.screenWidth,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                offset: const Offset(0, 3),
                                blurRadius: 4)
                          ]),
                        ),
                        context.sizeH(2),
                        pro.isHistroyLoading
                            ? const Expanded(
                          child: Center(
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator()),
                          ),
                        )
                            : pro.getHistoryOrder.isEmpty
                            ? Expanded(
                              child: Center(
                                  child: Lottie.asset(
                                      AppImagesPath.noDataAnimationPath)),
                            )
                            : Expanded(
                                child: CustomScrollView(
                                  slivers: [
                                    SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                            childCount: pro.getHistoryOrder
                                                .length, (context, index) {
                                      var model = pro.getHistoryOrder;
                                      return InkWell(
                                        onTap: () {
                                          // <------------- Navigating to history Details view ----------> //
                                          //  Navigator.pushNamed(context, HistoryDetailsView.routeName);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryDetailsView(
                                                item: model[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 7, bottom: 7),
                                          width: context.screenWidth,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                                color: AppColors.color5E6D55
                                                    .withOpacity(0.15)),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    TextWidget(
                                                      msg: formatDate(
                                                          model[index]
                                                              .orderTime),
                                                      font: FontMixin
                                                          .regularFamily,
                                                      fontWeight: FontMixin
                                                          .fontWeightRegular,
                                                      textSize: 14,
                                                      color:
                                                          AppColors.color001E00,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 6,
                                                          width: 6,
                                                          decoration:
                                                              const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColors
                                                                      .color001E00),
                                                        ),
                                                        context.sizeW(2),
                                                        TextWidget(
                                                          msg: model[index]
                                                                  .booking_status ??
                                                              "Cancelled",
                                                          font: FontMixin
                                                              .boldFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightBold,
                                                          textSize: 14,
                                                          color: model[index]
                                                                      .booking_status ==
                                                                  'Completed'
                                                              ? AppColors
                                                                  .color40AFD2D
                                                              : model[index]
                                                                          .booking_status ==
                                                                      'In Progress'
                                                                  ? AppColors
                                                                      .color001E00
                                                                  : AppColors
                                                                      .colorRed,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                width: context.screenWidth,
                                                color: AppColors.color5E6D55
                                                    .withOpacity(0.15),
                                              ),

                                              /// Origin and distance column wit fare
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    /// Pickup and Drop location column
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          /// Pickup row
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                height: context
                                                                        .screenHeight *
                                                                    0.03,
                                                                width: context
                                                                        .screenHeight *
                                                                    0.03,
                                                                child: AppImagesPath
                                                                    .pickupIcon
                                                                    .svg,
                                                              ),
                                                              context.sizeW(5),
                                                              Flexible(
                                                                child:
                                                                    TextWidget(
                                                                  msg: model[
                                                                          index]
                                                                      .startAddress,
                                                                  font: FontMixin
                                                                      .mediumFamily,
                                                                  fontWeight:
                                                                      FontMixin
                                                                          .fontWeightMedium,
                                                                  textSize: 16,
                                                                  maxLine: 1,
                                                                  color: AppColors
                                                                      .color001E00,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // Destination row
                                                          context.sizeH(2),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                height: context
                                                                        .screenHeight *
                                                                    0.03,
                                                                width: context
                                                                        .screenHeight *
                                                                    0.03,
                                                                child:
                                                                    AppImagesPath
                                                                        .dropIcon
                                                                        .svg,
                                                              ),
                                                              context.sizeW(5),
                                                              Flexible(
                                                                child:
                                                                    TextWidget(
                                                                  msg: model[
                                                                          index]
                                                                      .endAddress,
                                                                  font: FontMixin
                                                                      .mediumFamily,
                                                                  fontWeight:
                                                                      FontMixin
                                                                          .fontWeightMedium,
                                                                  textSize: 16,
                                                                  maxLine: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: AppColors
                                                                      .color001E00,
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // Total Fare Colum
                                                    Column(
                                                      children: [
                                                        TextWidget(
                                                          msg: AppStrings
                                                              .totalFare,
                                                          font: FontMixin
                                                              .mediumFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightMedium,
                                                          textSize: 14,
                                                          color: AppColors
                                                              .color5E6D55,
                                                        ),
                                                        context.sizeH(1),
                                                        TextWidget(
                                                          msg: r"$" +
                                                              model[index]
                                                                  .total
                                                                  .toString(),
                                                          font: FontMixin
                                                              .mediumFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightMedium,
                                                          textSize: 24,
                                                          color: AppColors
                                                              .color001E00,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 15),
                                                child: Container(
                                                  height: 1,
                                                  width: context.screenWidth,
                                                  color: AppColors.color5E6D55
                                                      .withOpacity(0.15),
                                                ),
                                              ),

                                              /// Ride type row
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 15),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextWidget(
                                                          msg: AppStrings
                                                              .rideType,
                                                          font: FontMixin
                                                              .regularFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightRegular,
                                                          textSize: 16,
                                                          color: AppColors
                                                              .color5E6D55,
                                                        ),
                                                        TextWidget(
                                                          msg: model[index]
                                                              .category!
                                                              .category
                                                              .toString(),
                                                          font: FontMixin
                                                              .mediumFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightMedium,
                                                          textSize: 16,
                                                          color: AppColors
                                                              .color001E00,
                                                        ),
                                                      ],
                                                    ),
                                                    context.sizeH(1),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextWidget(
                                                          msg: "Payment by",
                                                          font: FontMixin
                                                              .regularFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightRegular,
                                                          textSize: 16,
                                                          color: AppColors
                                                              .color5E6D55,
                                                        ),
                                                        TextWidget(
                                                          msg: "DebitCard",
                                                          font: FontMixin
                                                              .mediumFamily,
                                                          fontWeight: FontMixin
                                                              .fontWeightMedium,
                                                          textSize: 16,
                                                          color: AppColors
                                                              .color001E00,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }))
                                  ],
                                ),
                              )
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }

  formatDate(String? date) {
    DateTime inputDate = DateTime.parse(date ?? "");

    // Define the desired output format
    String desiredFormat = 'dd MMMM yyyy';

    // Create a DateFormat object with the desired format
    DateFormat formatter = DateFormat(desiredFormat, 'en_US');

    // Format the date to the desired format
    String formattedDate = formatter.format(inputDate);

    return formattedDate;
  }
}
