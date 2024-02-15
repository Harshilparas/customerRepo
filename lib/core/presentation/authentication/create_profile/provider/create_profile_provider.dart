import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:deride_user/core/presentation/authentication/create_profile/provider/image_picker_provider.dart';
import 'package:deride_user/core/presentation/authentication/create_profile/repository/create_prole_repo.dart';

import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateProfileProvider extends ChangeNotifier {
  static final CreateProfileProvider _createProfileProvider =
      CreateProfileProvider.internal();

  factory CreateProfileProvider() {
    return _createProfileProvider;
  }

  CreateProfileProvider.internal();
  // <--------------  TEXTEDITING CONTROLLER --------------> //

  /// Text editing controller
  TextEditingController firstNameEdt = TextEditingController();
  TextEditingController lastNameEdt = TextEditingController();
  TextEditingController mobileNumberEdt = TextEditingController();

  String _profileImage = '';
  bool? isProfileloading = false;
  // Country
  CountryCode? country;

  // Method to set the country

  void setCountry(value) {
    country = value;
    Dev.log(country!.name);
    notifyListeners();
  }

  //getter
  String get profileImage => _profileImage;

  /// Upload image Api Call
  Future<String> uploadImageApiCall(XFile image, int value) async {
    isProfileloading = true;
    notifyListeners();
    var response =
        await CreateProfileRepository.uploadFileFunction(File(image.path));
    if (response != null) {
      isProfileloading = false;
      notifyListeners();
      return response["fileName"];
    } else {
      isProfileloading = false;
      notifyListeners();
      return "";
    }
  }
  // <------------ Validate Feilds -----------------> //

  validateField() {
    if (_profileImage.isEmpty) {
      return "Upload Profile Pic ";
    } else if (firstNameEdt.text.trim().isEmpty) {
      return AppStrings.firstNameError;
    } else if (lastNameEdt.text.trim().isEmpty) {
      return AppStrings.lastNameError;
    } else if (mobileNumberEdt.text.trim().isEmpty) {
      return AppStrings.mobileNumberError;
    } else if (mobileNumberEdt.text.length <= 5) {
      return "Mobile Number should be greater than 5 characters";
    } else {
      return "";
    }
  }

  // Image Picker
  imagePicker(BuildContext context, Function(XFile file) successCallBack1) {
    final provider = context.read<ImagePickerProvider>();
    ImagePickerHelper.showPicker(
        context: context,
        imagePicker: provider.imagePicker,
        successCallBack: (value) {
          successCallBack1(value!);
        },
        failedCallBack: (value) {});
  }

  // <-------------  Set Profile Image --------------> //

  setProfileImage(XFile image) async {
    var path = await uploadImageApiCall(image, 11);
    if (path != null) {
      _profileImage = path;
    } else {
      _profileImage = "";
    }
    notifyListeners();
  }

  // <------------- Create Profile Api --------------> //

  void createProfileApiCall(BuildContext context) async {
    if (validateField() == "") {
      final response = await CreateProfileRepository.personalDetailFunction({
        "first_name": firstNameEdt.text,
        'last_name': lastNameEdt.text,
        'phone': mobileNumberEdt.text,
        'country': country != null ? country!.name : "Canada",
        'image': profileImage
      }, context);
    } else {
      context.showAnimatedToast(validateField().toString());
    }
  }

// <---------Method to clear the contr0ller -------> //
  clearController() {
    firstNameEdt.clear();
    lastNameEdt.clear();
    mobileNumberEdt.clear();
    _profileImage = '';
    notifyListeners();
  }
}
