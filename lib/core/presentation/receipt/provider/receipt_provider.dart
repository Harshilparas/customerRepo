import 'dart:developer';

import 'package:deride_user/core/presentation/receipt/repository/receopt_repo.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/cupertino.dart';

class ReceiptProvider extends ChangeNotifier {
  double rating = 1.0;
  TextEditingController comment = TextEditingController();

  updateRating(double value) {
    rating = value;
    notifyListeners();
  }

  validate() {
    if (rating == 0.0) {
      return 'Please Give Rating';
    } else {
      return '';
    }
  }

  void addRating(
    BuildContext context,
    var orderId,
    var userId,
  ) async {
    log("user id ===>$userId");
    log("orderId id ===>$orderId");

    if (validate() == "") {
      await ReceiptRepo.receiptRepo(
          context, orderId, userId, comment.text.trim(), rating);
      rating=1.0;
    } else {
      context.showAnimatedToast(validate().toString());
    }
  }

  claerContoller() {
    rating = 0.0;
    comment.clear();
  }
/* void receipt(BuildContext context ,var orderId)async{
    await ReceiptRepo.receiptRepo(context, orderId, userId, comment, rating)
  }*/
}
