// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:deride_user/core/presentation/authentication/create_profile/provider/create_profile_provider.dart';

import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/app_constant/app_strings.dart';
import '../../../../../utils/widget/text_feild_widget.dart';
import '../../../../../utils/widget/text_widget.dart';

class CreateProfileView extends StatelessWidget {
  const CreateProfileView({Key? key}) : super(key: key);
  static const routeName = "/createProfile";
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProfileProvider>(builder: (context, pro, _) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const ToolBarWidget(tittle: AppStrings.createProfile),
                context.sizeH(3.5),
                Container(
                  height: context.screenHeight * 0.15,
                  width: context.screenHeight * 0.15,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.colorEDF3ED),
                  child: pro.isProfileloading!
                      ? CircularProgressIndicator(
                          color: AppColors.primary,
                        )
                      : pro.profileImage.isNotEmpty
                          ? ClipOval(
                              child: Image.network(
                                '${NetworkConstant.imageBaseUrl}${pro.profileImage}',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.person,
                                color: AppColors.colorWhite,
                                size: context.screenHeight * 0.1,
                              ),
                            ),
                ),
                context.sizeH(2),
                InkWell(
                  onTap: () {
                    pro.imagePicker(context, (file) {
                      pro.setProfileImage(file);
                    });
                  },
                  child: TextWidget(
                    msg: AppStrings.uploadProfile,
                    fontWeight: FontMixin.fontWeightMedium,
                    font: FontMixin.mediumFamily,
                    textSize: 18,
                    color: AppColors.color40AFD2D,
                  ),
                ),
                context.sizeH(2.5),
                CommonTextfeild(
                  tittle: AppStrings.firstName,
                  msg: "Enter First Name",
                  color: Colors.black,
                  isEnable: true,
                  textSize: 15,
                  editController: pro.firstNameEdt,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  isDropDown: false,
                ),
                CommonTextfeild(
                  tittle: AppStrings.lastName,
                  msg: "Enter Last Name",
                  color: Colors.black,
                  isEnable: true,
                  textSize: 15,
                  editController: pro.lastNameEdt,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  isDropDown: false,
                ),
                CommonTextfeildPhone(
                  tittle: AppStrings.mobileNumber,
                  msg: "Enter Mobile Number",
                  color: Colors.black,
                  isEnable: true,
                  textSize: 15,
                  editController: pro.mobileNumberEdt,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  isDropDown: false,
                  onChange: (v) {
                    pro.setCountry(v);
                  },
                ),
              ],
            ),
          )),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ButtonWidget(
            msg: AppStrings.continues,
            fontColor: AppColors.colorWhite,
            callback: () {
              // Navigator.pushNamed(context, HomeView.routeName);
              pro.createProfileApiCall(context);
            },
          ),
        ),
      );
    });
  }
}
