import 'package:deride_user/core/presentation/setting/model/user_details_model.dart';
import 'package:deride_user/core/presentation/setting/repository/profile_repository.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  static final ProfileProvider _profileProvider = ProfileProvider.internal();

  factory ProfileProvider() {
    return _profileProvider;
  }

  ProfileProvider.internal();

  UserDetailModel? userDetailModel;
  // <------------Variable for check data ------------------>
  bool isProfileLoading = true;

  // <---------------  Get Profile Data ---------->  //
  getProfileData() async {
    final response = await ProfileRepo.getProfile();
    if (response["success"] == 1) {
      userDetailModel = UserDetailModel.fromJson(response);
      isProfileLoading = false;
      notifyListeners();
    } else {
      isProfileLoading = false;
      userDetailModel = null;
      notifyListeners();
    }
  }
}
