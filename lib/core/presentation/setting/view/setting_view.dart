// ignore_for_file: prefer_const_constructors

import 'package:deride_user/core/presentation/authentication/login/view/login_view.dart';
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/setting/provider/history_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/profile_provider.dart';
import 'package:deride_user/core/presentation/setting/view/contact_us_view.dart';
import 'package:deride_user/core/presentation/setting/view/edit_profile.dart';
import 'package:deride_user/core/presentation/setting/view/history_view.dart';
import 'package:deride_user/core/presentation/setting/view/privacy_policy_view.dart';
import 'package:deride_user/core/presentation/setting/view/terms_policy_view.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../network/locator/locator.dart';
import '../../../../utils/app_constant/app_image_strings.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/tool_bar_widget.dart';
import '../../home/provider/location_provider.dart';
import '../widget/setting_tile_widget.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  static const routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).getProfileData();
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProfileProvider>(builder: (context, pro, _) {
          return pro.isProfileLoading
              ? Center(
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator()),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              var locationProvider = locator<LocationProvider>();
                              var homeViewProvider = locator<HomeViewProvider>();


                              locationProvider.initializeMarkerBitMap();
                              homeViewProvider.clearController();
                              Navigator.pushNamed(context, HomeView.routeName);
                            },
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              color: AppColors.color232323,
                              size: 25,
                            ),
                          ),
                          TextWidget(
                            msg: AppStrings.setting,
                            font: FontMixin.mediumFamily,
                            fontWeight: FontMixin.fontWeightMedium,
                            color: AppColors.color001E00,
                            textSize: 20,
                          ),
                          const SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                      context.sizeH(4),
                      Container(
                        height: context.screenHeight * 0.15,
                        width: context.screenHeight * 0.15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.color001E00, width: 3)),
                        child: ClipOval(
                            child: Image.network(
                          '${NetworkConstant.imageBaseUrl}${pro.userDetailModel!.user.image}',
                          fit: BoxFit.fill,
                        )),
                      ),
                      context.sizeH(2),
                      TextWidget(
                        msg:
                            '${pro.userDetailModel!.user.firstName} ${pro.userDetailModel!.user.lastName}',
                        color: AppColors.color001E00,
                        font: FontMixin.mediumFamily,
                        fontWeight: FontMixin.fontWeightMedium,
                        textSize: 24,
                        textAlign: TextAlign.center,
                      ),
                      context.sizeH(1),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, EditProfileView.routeName),
                        child: TextWidget(
                          msg: AppStrings.editProfile,
                          color: AppColors.color40AFD2D,
                          font: FontMixin.regularFamily,
                          fontWeight: FontMixin.fontWeightRegular,
                          textSize: 16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      context.sizeH(5),
                      SettingTileWidget(
                          iconPath: AppImagesPath.historyIcon,
                          title: AppStrings.history,
                          callback: () {
                            Provider.of<HistoryProvider>(context, listen: false)
                                .getHistoryData();
                            Navigator.pushNamed(context, HistoryView.routeName);
                          }),
                      SettingTileWidget(
                          iconPath: AppImagesPath.contactUsIcon,
                          title: AppStrings.contactUs,
                          callback: () {
                            Navigator.pushNamed(
                                context, ContactUsView.routeName);
                          }),
                      SettingTileWidget(
                          iconPath: AppImagesPath.privacyIcon,
                          title: AppStrings.privacyPolicy,
                          callback: () {
                            Navigator.pushNamed(
                                context, PrivacyPolicyView.routeName);
                          }),
                      SettingTileWidget(
                          iconPath: AppImagesPath.termPolicyIcon,
                          title: AppStrings.termCondition,
                          callback: () {
                            Navigator.pushNamed(context, TermsPolicy.routeName);
                          }),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ButtonWidget(
                            msg: AppStrings.logout,
                            fontColor: AppColors.colorWhite,
                            callback: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          child:
                                              AppImagesPath.logoPath.image()),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            msg: "Do you want exit this app?",
                                            color: AppColors.color001E00,
                                            font: FontMixin.boldFamily,
                                            fontWeight:
                                                FontMixin.fontWeightRegular,
                                            maxLine: 1,
                                            textSize: 15,
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ButtonWidget(
                                              width: 100,
                                              height: 40,
                                              msg: "Yes",
                                              fontColor: AppColors.colorWhite,
                                              callback: () {
                                                Provider.of<HomeViewProvider>(
                                                        context,
                                                        listen: false)
                                                    .clearController();
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        LoginView.routeName,
                                                        (route) => false);
                                                SharedPreferencesManager()
                                                    .seIsLogin(false);
                                              },
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            ButtonWidget(
                                              width: 100,
                                              height: 40,
                                              msg: "No",
                                              fontColor: AppColors.colorWhite,
                                              callback: () {
                                                SharedPreferencesManager()
                                                    .clear();
                                                Navigator.pop(context, true);
                                              },
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 10,
                                        ),
                                      ],
                                    );
                                  });
                              /*   Navigator.pushNamedAndRemoveUntil(context,
                                  LoginView.routeName, (route) => false);
                              SharedPreferencesManager().seIsLogin(false);*/
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
