import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../network/locator/locator.dart';
import '../../home/provider/home_view_provider.dart';
import '../../home/provider/location_provider.dart';

class MessageSentWidget extends StatelessWidget {
  const MessageSentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(alignment: Alignment.topRight, child: Icon(Icons.close)),
          Padding(
            padding: EdgeInsets.only(left: context.screenHeight * 0.04),
            child: SizedBox(
              height: context.screenHeight * 0.11,
              width: context.screenWidth * 0.4,
              child: AppImagesPath.messageSentLogo.svg,
            ).center(),
          ),
          context.sizeH(2.5),
          TextWidget(
            msg: AppStrings.messageSent,
            font: FontMixin.boldFamily,
            fontWeight: FontMixin.fontWeightBold,
            color: AppColors.color001E00,
            textSize: 24,
          ),
          context.sizeH(1),
          TextWidget(
            msg: AppStrings.yourMessageSent,
            font: FontMixin.regularFamily,
            fontWeight: FontMixin.fontWeightRegular,
            color: AppColors.color5E6D55,
            textSize: 16,
          ),
          context.sizeH(4.5),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ButtonWidget(
                msg: AppStrings.done,
                fontColor: AppColors.colorWhite,
                callback: () {
                  var locationProvider = locator<LocationProvider>();
                  var homeViewProvider = locator<HomeViewProvider>();
                  locationProvider.initializeMarkerBitMap();
                  homeViewProvider.clearController();
                  Navigator.pushNamed(context, HomeView.routeName);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
