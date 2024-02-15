import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/receipt/model/receipt_model.dart';
import 'package:deride_user/core/presentation/receipt/provider/receipt_provider.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/receipt/view/fedback/view/submit_feedback_successfull_view.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../network/basic/network_constant.dart';
import '../../../../home/models/customer_receipt_model.dart';

class SubmitFeedbackView extends StatelessWidget {
  final ReceiptModel? item;

  SubmitFeedbackView({super.key, this.item});

  static const routeName = '/submitFeedback';
  final foucusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer<SocketProvider>(builder: (context, rating, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              height: context.screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ToolBarWidget(tittle: ""),
                    context.sizeH(2),

                    Container(
                      height: context.screenHeight * 0.16,
                      width: context.screenHeight * 0.16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.color63BA6B1A.withOpacity(0.1)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipOval(
                            child: Image.network(
                          "${NetworkConstant.imageBaseUrl}${item?.orderReceipt?.image}",
                          fit: BoxFit.fill,
                        )),
                        /*    ClipOval(child:rating.driverDetailModel?.data?.profilePhoto!=null?
                              Image.network("${NetworkConstant.imageBaseUrl}${rating.driverDetailModel?.data?.profilePhoto
                              }",fit: BoxFit.fill,): AppImagesPath.dummyUserImage.image()),*/
                      ),
                    ),
                    context.sizeH(1),
                    TextWidget(
                      msg: item?.orderReceipt?.userName ?? "",
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 18,
                      color: AppColors.color001E00,
                    ),
                    context.sizeH(0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          msg: "Sedan  ",
                          font: FontMixin.mediumFamily,
                          fontWeight: FontMixin.fontWeightMedium,
                          textSize: 12,
                          color: AppColors.color5E6D55,
                        ),
                        TextWidget(
                          msg: item?.orderReceipt?.plateNumber ?? "",
                          font: FontMixin.mediumFamily,
                          fontWeight: FontWeight.w300,
                          textSize: 12,
                          color: AppColors.color001E00,
                        ),
                      ],
                    ),
                    context.sizeH(2.5),
                    // Rate Your Passenger Text
                    TextWidget(
                      msg: AppStrings.rateYourPassenger,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 24,
                      color: AppColors.color001E00,
                    ),
                    context.sizeH(2.5),
                    TextWidget(
                      msg: AppStrings.yourFeedBackWillWork,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 17,
                      color: AppColors.color5E6D55,
                      textAlign: TextAlign.center,
                    ),
                    context.sizeH(3),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: RatingBar(
                        initialRating:
                            Provider.of<ReceiptProvider>(context, listen: false)
                                .rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        glow: false,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 3.0),
                        ratingWidget: RatingWidget(
                            full: SvgPicture.asset(
                              AppImagesPath.starIcon,
                              color: AppColors.colorFFCC00,
                              height: 30,
                            ),
                            half: SvgPicture.asset(AppImagesPath.starIcon),
                            empty: SvgPicture.asset(
                              AppImagesPath.starIcon,
                              color: const Color(0xffEFEFF4),
                              height: 20,
                            )),
                        onRatingUpdate: (rating) {
                          Provider.of<ReceiptProvider>(context, listen: false)
                              .updateRating(rating);
                        },
                      ),
                    ),
                    context.sizeH(2.5),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).requestFocus(foucusNode);
                      },
                      child: Container(
                        height: context.screenHeight * 0.18,
                        width: context.screenWidth,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.colorEDF3ED),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: context.screenHeight * 0.015,
                              left: 20,
                              right: 20),
                          child: TextField(
                            controller: Provider.of<ReceiptProvider>(context,
                                    listen: false)
                                .comment,
                            textAlign: TextAlign.start,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                // helperText: "Additional comments...",
                                hintText: "Additional comments...",
                                hintStyle: TextStyle(
                                    fontFamily: FontMixin.regularFamily,
                                    fontWeight: FontMixin.fontWeightRegular,
                                    color:
                                        AppColors.color5E6D55.withOpacity(0.5),
                                    fontSize: 17),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                hintMaxLines: 5,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    context.sizeH(10),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonWidget(
                        msg: AppStrings.submit,
                        fontColor: AppColors.colorWhite,
                        bgBolor: AppColors.color001E00,
                        callback: () {
                          Provider.of<SocketProvider>(context, listen: false)
                              .removeItem();
                          print("kk");
                          Provider.of<ReceiptProvider>(context, listen: false)
                              .addRating(
                            context,
                            item?.orderReceipt?.id,
                            item?.orderReceipt?.driverId,
                          );
                          // <--------------------- Navigate to submit feedback success screen ------> //

                          /*  Navigator.pushNamed(
                                context, SubmitFeedbackSuccessfully.routeName);*/
                        },
                      ),
                    ),
                    context.sizeH(2),
                    ButtonWidget(
                      msg: AppStrings.skip,
                      fontColor: AppColors.colorWhite,
                      callback: () {
                        Provider.of<SocketProvider>(context, listen: false)
                            .removeItem();
                        Navigator.pushNamedAndRemoveUntil(context, HomeView.routeName,(route) => false);
                        //   Navigator.pushNamed(context, ReceiptScreen.routeName);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
