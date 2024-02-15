import 'dart:math';

import 'package:deride_user/core/presentation/setting/model/history_model.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/history_repository.dart';

class HistoryProvider extends ChangeNotifier {
  static final HistoryProvider _historyProvider = HistoryProvider.internal();

  HistoryProvider.internal();

  factory HistoryProvider() {
    return _historyProvider;
  }

  List<HistoryOrder> getHistoryOrder = [];
  List<Category> getCategory = [];
  HistoryModel? historyModel;
  bool isHistroyLoading = true;

  getHistoryData() async {
    try {
      isHistroyLoading = true;
      notifyListeners();
      final response = await HistoryRepo.getHistory();
      print("sddsf$response");
      if (response['success'] == 1) {
        historyModel = HistoryModel.fromJson(response);
        getHistoryOrder.clear();
        getHistoryOrder.addAll(historyModel!.historyOrder!);

        isHistroyLoading = false;
        notifyListeners();
      } else if (response['success'] == 0) {
        getHistoryOrder.clear();
        notifyListeners();
        isHistroyLoading = false;
      } else {
        isHistroyLoading = false;
        historyModel = null;
        notifyListeners();
      }
    } on Exception catch (e, t) {
      Dev.log("getHistoryData===>$e");
      Dev.log("getHistoryData===>$t");
    }
  }

  paymentMethod(int paymentmethod) {
    switch (paymentmethod) {
      case 0:
        return "Apple Pay";
      case 1:
        return "Card Pay";
      case 2:
        return "Google Pay";
      default:
        return "";
    }
  }

  String convertToCustomFormat(String inputDateTime) {
    DateTime dateTime = DateTime.parse(inputDateTime);
    DateFormat formatter = DateFormat('dd MMMM yyyy, hh:mm a');
    String formattedDateTime = formatter.format(dateTime);
    return formattedDateTime;
  }

  progressStatus(int status) {
    switch (status) {
      case 0:
        return "In Progress";
      case 1:
        return "Complete";

      default:
        return "";
    }
  }
}
