import 'dart:async';

import 'package:deride_user/core/presentation/home/widget/no_driver_found_widget.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/bottom_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class RequestProvider extends ChangeNotifier {
  bool showTryAgainBottomSheet =false;
  // <------ METHOD TO BOOK THE RIDE ------->  //
  void bookNowRide(BuildContext context) {
    if (Provider.of<PaymentMethodProvider>(context, listen: false)
            .radioButtonValue ==
        null) {
      context.showAnimatedToast('Select Payment Mode');
    } else {
      showTryAgainBottomSheet=true;
      Provider.of<SocketProvider>(context, listen: false).bookTaxi(context);
    }
  }

  // <---------  Using for waiting for driver screen --------------> //

  void driverWaiting(BuildContext context) {
    Dev.log("driverWaiting=======");

  Timer(const Duration(seconds: 90), () {
   Dev.log("showTryAgainBottomSheet>>>>${showTryAgainBottomSheet}");
      if(showTryAgainBottomSheet) {
        Navigator.pop(navigatorKey.currentContext!);
        Provider.of<SocketProvider>(navigatorKey.currentContext!,listen: false).cancelBooking(navigatorKey.currentContext!,navigateNextScreen: false);
        // <-----------  NO DRIVER FOUND SHEET-----------> //
        final ctx = navigatorKey.currentContext;
        if (ctx != null) {
          ModalBottomSheet.moreModalBottomSheet(
            ctx,
            const NoDriverFoundWidget(),
            isExpendable: false,
            topBorderRadius: 20,
            padding: EdgeInsets.zero,
          );
        }
      }
    });

  }
}
