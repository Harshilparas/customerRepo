// ignore_for_file: prefer_const_constructors

import 'package:deride_user/core/presentation/setting/provider/contact_us_provider.dart';
import 'package:deride_user/core/presentation/setting/widget/contact_us_message_sent_widget.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/bottom_sheet_widget.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_feild_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/widget/tool_bar_widget.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});
  static const routeName = '/contactUs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ContactUsProvider>(builder: (context, pro, _) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ToolBarWidget(tittle: AppStrings.contactUs),
                  context.sizeH(4),
                  SizedBox(
                    height: context.screenHeight * 0.27,
                    width: context.screenWidth * 0.6,
                    child: AppImagesPath.conatctUsLogo.svg,
                  ),
                  context.sizeH(2.5),
                  TextWidget(
                    msg: AppStrings.getInTouch,
                    font: FontMixin.mediumFamily,
                    fontWeight: FontMixin.fontWeightMedium,
                    textSize: 24,
                    color: AppColors.color001E00,
                  ),
                  context.sizeH(1.5),
                  TextWidget(
                    msg: AppStrings.haveAnyQues,
                    font: FontMixin.regularFamily,
                    fontWeight: FontMixin.fontWeightRegular,
                    textSize: 15,
                    color: AppColors.color5E6D55,
                  ),
                  context.sizeH(1.5),
                  CommonTextfeild(
                    tittle: "",
                    msg: "Enter your email",
                    color: AppColors.color001E00,
                    textSize: 15,
                    editController: pro.emailEdt,
                    backImage: "",
                    isPassword: false,
                    obscureText: false,
                    isDropDown: false,
                    hintColor: AppColors.color5E6D55,
                  ),
                  CommonTextfeild(
                    tittle: "",
                    msg: "Subject",
                    color: AppColors.color001E00,
                    textSize: 15,
                    editController: pro.messageEdt,
                    backImage: "",
                    isPassword: false,
                    obscureText: false,
                    isDropDown: false,
                    hintColor: AppColors.color5E6D55,
                  ),
                  CommonTextfeild(
                    tittle: "",
                    msg: "Enter your message",
                    color: AppColors.color001E00,
                    textSize: 15,
                    editController: pro.subjectEdt,
                    backImage: "",
                    isPassword: false,
                    obscureText: false,
                    isDropDown: false,
                    hintColor: AppColors.color5E6D55,
                    maxLine: 5,
                  ),
                  context.sizeH(2.5),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonWidget(
                      msg: AppStrings.sendMessage,
                      fontColor: AppColors.colorWhite,
                      callback: () {
                        // ModalBottomSheet.moreModalBottomSheet(
                        //     context, const MessageSentWidget());
                        pro.apiCallContactUs(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
