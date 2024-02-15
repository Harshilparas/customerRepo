import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:flutter/cupertino.dart';

import '../../setting/model/history_model.dart';
import '../model/rating_list_model.dart';
import '../repo/rating_list_repo.dart';

class RatingProvider extends ChangeNotifier {
  RatingListModel? ratindListModel;
  List<ListElement> getRatingList = [];
  bool dataLoading = true;

  void ratingListMethod(id) async {
    try {
      dataLoading = true;
      notifyListeners();
      final response = await RaingListRepo.getRatingList(id);
      if (response['success'] == 1) {
        ratindListModel = RatingListModel.fromJson(response);
        getRatingList.clear();
        getRatingList.addAll(ratindListModel!.list!);
        dataLoading = false;
        notifyListeners();
      } else if (response['success'] == 0) {
        getRatingList.clear();
        dataLoading = false;
        notifyListeners();
      } else {
        dataLoading = false;
        notifyListeners();
      }
    } catch (e, t) {
      ratindListModel = null;
      getRatingList.clear();
      dataLoading = false;
      notifyListeners();
      Dev.log("ratingListMethod----->$e");
      Dev.log("ratingListMethod----->$t");
    }
  }
}
