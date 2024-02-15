// ignore_for_file: use_build_context_synchronously

import 'package:deride_user/core/presentation/setting/widget/contact_us_message_sent_widget.dart';
import 'package:deride_user/network/basic/common_network.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/bottom_sheet_widget.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:flutter/material.dart';

abstract class ContactusRepository {
// <-------------- Function to call the contact us api ------------> //
  static contactUsFunction(
      {BuildContext? context, Map<String, dynamic>? body}) async {
    ProgressDialog.showProgressDialog(context!);
    final response = await ApiService().callPostApi(
        body, NetworkConstant.contactUsEndPoint,
        token: SharedPreferencesManager().token);

    if (response["success"] == 1) {
      Navigator.pop(context);
      ModalBottomSheet.moreModalBottomSheet(context, const MessageSentWidget());
      return response;
    } else {
      Navigator.pop(context);
      context.showAnimatedToast(response["message"]);
    }
  }
}
