import 'package:deride_user/core/presentation/receipt/model/receipt_model.dart';
import 'package:deride_user/core/presentation/receipt/repository/receipt_screen_repo.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:flutter/cupertino.dart';

class ReceiptScrerenProvider extends ChangeNotifier {
  ReceiptModel? receiptModel;
  bool loading = false;

  Future<ReceiptModel?> getReceiptDetail(
      BuildContext context, var orderId) async {
    try {
      loading = true;
      notifyListeners();
      //ReceiptScreenRepo.receiptScreenRepo(context,orderId);
      final response =
          await ReceiptScreenRepo.receiptScreenRepo(context, orderId);
      loading = false;
      notifyListeners();
      if (response['success'] == 1) {
        receiptModel = ReceiptModel.fromJson(response);
        notifyListeners();
        return receiptModel;
      }
    } on Exception catch (e) {
      receiptModel = null;
      loading = false;
      notifyListeners();
    }
    return null;
  }
}
