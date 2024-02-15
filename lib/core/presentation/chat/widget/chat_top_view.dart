import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../network/basic/network_constant.dart';
import '../../home/provider/ride_in_Progress_provider.dart';

class ChatTopView extends StatefulWidget {
  const ChatTopView({super.key});

  @override
  State<ChatTopView> createState() => _ChatTopViewState();
}

class _ChatTopViewState extends State<ChatTopView> {
  void navigate() {
 /*   navigatorKey.currentState!
        .push(MaterialPageRoute(builder: ((context) => const CarReceiptScreen())));*/
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Consumer2<SocketProvider,RideInProgressProvider>(builder: (context, pro,rideInProgressProvider, _) {
        final driverData = pro.driverDetailModel?.data;
        final driverDetails =
            rideInProgressProvider.rideInProgressModel?.driverDetails;
        final useOld = driverData?.id != null;
        final driverName = useOld ? driverData?.name : driverDetails?.name;

        final driverPhoto =
        useOld ? driverData?.profile_photo : driverDetails?.profilePhoto;
        return Row(
          children: [
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
               /* Future.delayed(const Duration(seconds: 5), navigate);*/
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: AppColors.color15141F,
              ),
            ),
            context.sizeW(3),
            Container(
              height: context.screenHeight * 0.065,
              width: context.screenHeight * 0.065,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(child: Image.network(
        '${NetworkConstant.imageBaseUrl}$driverPhoto',
        fit: BoxFit.fill,
        /*Image.asset(AppImagesPath.dummyUserImage*/)),
            ),
            context.sizeW(3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  msg: driverName,
                  font: FontMixin.mediumFamily,
                  fontWeight: FontMixin.fontWeightMedium,
                  textSize: 18,
                  color: AppColors.color001E00,
                ),
                TextWidget(
                  msg: AppStrings.activeNow,
                  font: FontMixin.regularFamily,
                  fontWeight: FontMixin.fontWeightRegular,
                  textSize: 14,
                  color: AppColors.color5E6D55,
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
