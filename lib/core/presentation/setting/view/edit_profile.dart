import 'package:deride_user/core/presentation/setting/provider/edit_profile_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/profile_provider.dart';
import 'package:deride_user/core/presentation/setting/view/setting_view.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_feild_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/widget/text_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  static const routeName = '/editProfile';

  @override
  Widget build(BuildContext context) {
    Provider.of<EditProfileProvider>(context, listen: false).initValue(context);
    return Consumer<EditProfileProvider>(builder: (context, proEdit, _) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SettingView.routeName);
                      },
                      child: const Icon(
                        Icons.arrow_back_sharp,
                        color: AppColors.color232323,
                        size: 25,
                      ),
                    ),
                    TextWidget(
                      msg: AppStrings.editProfile,
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
                context.sizeH(2),
                Stack(
                  children: [
                    Container(
                      height: context.screenHeight * 0.15,
                      width: context.screenHeight * 0.15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.color001E00, width: 3)),
                      child: ClipOval(
                          child: proEdit.isProfileloading!
                              ? const CircularProgressIndicator()
                              : proEdit.profileImage.isNotEmpty
                                  ? Image.network(
                                      '${NetworkConstant.imageBaseUrl}${proEdit.profileImage}',
                                      fit: BoxFit.fill,
                                    )
                                  : AppImagesPath.dummyUserImage.image()),
                    ),

                    /// Profile Picture Widget
                    Positioned(
                      right: 0,
                      bottom: 10,
                      child: InkWell(
                        onTap: () {
                          // <---------------- Set Profile Image -------------> //
                          proEdit.imagePicker(context, (file) {
                            proEdit.setProfileImage(file);
                          });
                        },
                        child: Container(
                          height: context.screenHeight * 0.045,
                          width: context.screenHeight * 0.045,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.colorWhite,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: AppImagesPath.editCameraIcon.svg,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                context.sizeH(3),

                /// Todo: Textfeilds
                CommonTextfeild(
                  tittle: AppStrings.firstName,
                  msg: "Enter First Name",
                  color: Colors.black,
                  isEnable: true,
                  textSize: 15,
                  editController: proEdit.firstNameEdt,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  isDropDown: false,
                ),
                CommonTextfeild(
                  tittle: AppStrings.lastName,
                  msg: "Enter First Name",
                  color: Colors.black,
                  isEnable: true,
                  textSize: 15,
                  editController: proEdit.lastNameEdt,
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
                  editController: proEdit.mobileNumberEdt,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  isDropDown: false,
                  initailSeelection:
                      Provider.of<ProfileProvider>(context, listen: false)
                          .userDetailModel!
                          .user
                          .country,
                  onChange: (v) {
                    proEdit.setCountry(v);
                  },
                ),

                /// save button
              ],
            )),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ButtonWidget(
            msg: AppStrings.save,
            fontColor: AppColors.colorWhite,
            callback: () {
              // Navigator.pushNamed(context, SettingView.routeName);
              proEdit.editProfileApiCall(context);
            },
          ),
        ),
      );
    });
  }
}
