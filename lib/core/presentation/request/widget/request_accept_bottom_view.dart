import 'package:deride_user/core/presentation/chat/view/chat_view.dart';
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/rating/view/review_view.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../home/provider/ride_in_Progress_provider.dart';
import '../../rating/provider/rating_provider.dart';

class HomeBookingAcceptBottomView extends StatefulWidget {
  const HomeBookingAcceptBottomView({super.key});

  @override
  State<HomeBookingAcceptBottomView> createState() =>
      _HomeBookingAcceptBottomViewState();
}

class _HomeBookingAcceptBottomViewState
    extends State<HomeBookingAcceptBottomView> {
  @override
  Widget build(BuildContext ctx) {
    return Consumer<SocketProvider>(builder: (context, socketPro, _) {
      return Consumer<RideInProgressProvider>(
          builder: (context, rideInProgressProvider, _) {
        final driverData = socketPro.driverDetailModel?.data;
        final driverDetails =
            rideInProgressProvider.rideInProgressModel?.driverDetails;
        final useOld = driverData?.id != null;
        final driverId = useOld ? driverData?.driverID : driverDetails?.id;
        final driverPhoto =
            useOld ? driverData?.profile_photo : driverDetails?.profilePhoto;
        final driverName = useOld ? driverData?.name : driverDetails?.name;
        final driverRating =
            useOld ? driverData?.DriverRating : driverDetails?.rating;
        final carModel =
            useOld ? driverData?.car_model : driverDetails?.carModel;
        final plateNumber =
            useOld ? driverData?.plate_number : driverDetails?.plateNumber;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      msg: socketPro.reachedLocation,
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 18,
                      maxLine: 1,
                      color: AppColors.color001E00,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  socketPro.reachedLocation ==
                          "Driver has reached your location"
                      ? Container(
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: TextWidget(
                              msg: getTime(socketPro.seconds),
                              font: FontMixin.mediumFamily,
                              fontWeight: FontMixin.fontWeightMedium,
                              textSize: 12,
                              color: AppColors.colorWhite,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Container(
              height: 1,
              width: context.screenWidth,
              color: AppColors.color5E6D55.withOpacity(0.15),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                onTap: () {
                  // Provider.of<HomeViewProvider>(context,listen: false).changeAnotherStep(true);
                  //     Navigator.pushNamed(context, ReviewScreen.routeName);
                  Provider.of<RatingProvider>(context, listen: false)
                      .ratingListMethod(driverId);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReviewScreen()));
                },
                child: Row(
                  children: [
                    Container(
                      height: context.screenHeight * 0.055,
                      width: context.screenHeight * 0.055,
                      // ignore: prefer_const_constructors
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: ClipOval(
                          child: Image.network(
                        "${NetworkConstant.imageBaseUrl}$driverPhoto",
                        fit: BoxFit.fill,
                      )),
                    ),
                    context.sizeW(5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextWidget(
                                  msg: driverName ?? "",
                                  font: FontMixin.mediumFamily,
                                  fontWeight: FontMixin.fontWeightMedium,
                                  textSize: 16,
                                  maxLine: 1,
                                  color: AppColors.color001E00,
                                ),
                              ),
                            ],
                          ),
                          context.sizeH(1),
                          Row(
                            children: [
                              SizedBox(
                                height: 15,
                                width: 15,
                                child: AppImagesPath.starIcon.svg,
                              ),
                              context.sizeW(1),
                              TextWidget(
                                msg: driverRating.toString()=="0"?"":double.tryParse(
                                            driverRating.toString())
                                        ?.toStringAsFixed(1) ??
                                    "",
                                font: FontMixin.mediumFamily,
                                fontWeight: FontMixin.fontWeightMedium,
                                textSize: 15,
                                color: AppColors.color153B0E,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Distance column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                          msg: carModel ?? "",
                          font: FontMixin.regularFamily,
                          fontWeight: FontMixin.fontWeightRegular,
                          textSize: 12,
                          color: AppColors.color5E6D55,
                        ),
                        context.sizeH(1),
                        TextWidget(
                          msg: plateNumber ?? "",
                          font: FontMixin.mediumFamily,
                          fontWeight: FontMixin.fontWeightMedium,
                          textSize: 14,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      msg: AppStrings.callNow,
                      fontColor: AppColors.colorWhite,
                      height: context.screenHeight * 0.052,
                      widget: SvgPicture.asset(
                        AppImagesPath.callIcon,
                        height: 20,
                        color: AppColors.colorWhite,
                      ),
                      callback: () {
                        Provider.of<HomeViewProvider>(context, listen: false)
                            .launchPhone(number: "21515151");
                      },
                    ),
                  ),
                  context.sizeW(5),
                  Expanded(
                    child: Consumer<SocketProvider>(builder: (context, pro, _) {
                      return ButtonWidget(
                        msg: AppStrings.message,
                        fontColor: AppColors.colorWhite,
                        bgBolor: AppColors.color001E00,
                        height: context.screenHeight * 0.052,
                        widget: Stack(
                          children: [
                            SvgPicture.asset(
                              AppImagesPath.messageIcon,
                              height: 20,
                              color: AppColors.colorWhite,
                            ),
                            Visibility(
                              visible: Provider.of<SocketProvider>(context).unreadCount == "0"
                                  ? false
                                  : true,
                              child: Positioned(
                                  right: 0.0,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        callback: () {
                          //  pro.changeAnotherStep(true);
                          //  Navigator.pushNamed(context, ChatView.routeName);
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatView()));
                          navigatorKey.currentState!
                              .pushNamed(ChatView.routeName);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        );
      });
    });
  }

  getTime(int seconds) {
    var minutes = seconds ~/ 60;
    var remainderSeconds = seconds % 60;
    return '$minutes:${remainderSeconds.toString().padLeft(2, '0')}';
  }
}
