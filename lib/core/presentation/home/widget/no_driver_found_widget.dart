import 'dart:io';

import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoDriverFoundWidget extends StatelessWidget {
  const NoDriverFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: context.screenHeight * 0.15,
              width: context.screenHeight * 0.6,
              child: Lottie.asset('assets/animation/Animation - 1700802019987.json'),
            ),
            context.sizeH(2),
            TextWidget(
              msg: 'OOPS ! Unable Find the Driver',
              color: AppColors.color001E00,
              textSize: 18,
              fontWeight: FontMixin.fontWeightMedium,
              font: FontMixin.mediumFamily,
            ),
            context.sizeH(5),
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    callback: (){
                        Provider.of<SocketProvider>(context,listen: false).tryAgainBooking(context);
                    },
                    msg: "Try Again",
                    fontColor: Colors.white,
                  ),
                ),
                context.sizeW(2.5),
                Expanded(
                  child: ButtonWidget(
                    callback: () async {
                //      Navigator.pop(context);
                      Provider.of<SocketProvider>(context,listen: false).cancelBooking(context);
                    },
                    msg: "Go Back",
                    fontColor: Colors.white,
                    bgBolor: AppColors.color001E00,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
