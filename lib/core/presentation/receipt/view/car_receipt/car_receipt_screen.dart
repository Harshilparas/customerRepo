import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/payment_method/view/payment_screen.dart';
import 'package:deride_user/core/presentation/receipt/model/receipt_model.dart';
import 'package:deride_user/core/presentation/receipt/view/fedback/view/feedback_view.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/history_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/circular_image_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../home/provider/ride_in_Progress_provider.dart';
import '../../provider/receipt_screen_provider.dart';

part 'fare_breakdown_detail_widget.dart';

part 'car_detail_widget.dart';

// part '../receipt_screen/receipt_screen.dart';

part '../receipt_screen/user_detail_widget.dart';

part '../receipt_screen/payment_info_widget.dart';

class CarReceiptScreen extends StatefulWidget {
  final dynamic orderrId;
  final bool? isPendingPayment;
  final bool callPayment;

  const CarReceiptScreen({
    super.key,
    this.orderrId,
    this.isPendingPayment,
    this.callPayment=true,
  });

  static const routeName = '/receipt';

  @override
  State<CarReceiptScreen> createState() => _CarReceiptScreenState();
}

class _CarReceiptScreenState extends State<CarReceiptScreen> {
  @override
  void initState() {
    super.initState();
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<ReceiptScrerenProvider>(builder: (context, pro, _) {
            return pro.loading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : pro.receiptModel != null
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              context.sizeH(2),
                              ToolBarWithOutBackWidget(
                                  tittle: AppStrings.receipt),
                              CarDetailWidget(receiptModel: pro.receiptModel),
                              context.sizeH(3),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: FareBreakdownDetailWidget(
                                    receiptModel: pro.receiptModel,
                                  ))
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              msg: "Data not found",
                              textSize: 20,
                            ),
                            context.sizeH(2),
                            ButtonWidget(
                              callback: () {
                                getData(context);
                              },
                              msg: "Refresh",
                              width: MediaQuery.of(context).size.width / 2,
                            )
                          ],
                        ),
                      );
          }),
        ),
      ),
    );
  }

  Future<void> getData(BuildContext context) async {

    final rideInProgressProvider = context.read<RideInProgressProvider>();
    rideInProgressProvider.rideInProgressModel?.driverDetails?.id;
    final id=widget.orderrId ??
        rideInProgressProvider.rideInProgressModel?.order?.id;
    if(id!=null && id.toString()!="") {
      final data =
      await Provider.of<ReceiptScrerenProvider>(context, listen: false)
          .getReceiptDetail(
          context,id);
      if (data != null && context.mounted && widget.callPayment) {
        await action(
          context: context,
          isPendingPayment: widget.isPendingPayment,
          driverId: data.orderReceipt?.driverId,
          orderId: data.orderReceipt?.id,
          totalAmountToPay: data.orderReceipt?.total,
        );
      }
    }else{
      Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, HomeView.routeName, (route) => false);
    }
  }
}
