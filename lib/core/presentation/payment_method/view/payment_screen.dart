import 'dart:developer';

import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/payment_method/view/select_payment_method_view.dart';
import 'package:deride_user/core/presentation/receipt/model/receipt_model.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/main.dart';

import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:deride_user/utils/widget/toast_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/button_widget.dart';
import '../../../../utils/widget/text_widget.dart';
import '../../../../utils/widget/tool_bar_widget.dart';

import '../../home/models/customer_receipt_model.dart';
import '../../receipt/provider/receipt_screen_provider.dart';
import '../../receipt/view/fedback/view/feedback_view.dart';
import '../../setting/provider/history_provider.dart';

// class PaymentSCreen extends StatefulWidget {
//   final ReceiptModel? item;
//   final bool isPendingPayment;
//
//   //  final  ReceiptModel? receiptModel;
//
//   const PaymentSCreen({
//     super.key,
//     this.item,
//     this.isPendingPayment = false,
//   });
//
//   static const routeName = '/paymentScreen';
//
//   @override
//   State<PaymentSCreen> createState() => _PaymentSCreenState();
// }
//
// class _PaymentSCreenState extends State<PaymentSCreen> {
//   TextEditingController textEditingController = TextEditingController();
//   TextEditingController tips = TextEditingController();
//   var pkToken =
//       'pk_live_51OGCtPGqfYIVAAkIMUcp5e3JvFDGYDLf4NYZ3bndCmTsnJZQMWyZvcxCkOXZFGJR8FFEJAJD7xKLH2DIRFPOxp2800tOj7bZ4G';
//   late String totalAmountToPay;
//
//   updateTotalAmount({tip}) {
//     setState(() {
//       totalAmountToPay = (double.parse(widget.item?.orderReceipt?.total ?? "") +
//               double.parse(tip))
//           .toStringAsFixed(2);
//     });
//   }
//
//   bool isPaymentSuccess = false;
//
//   @override
//   void initState() {
//     setState(() {
//       totalAmountToPay = widget.item?.orderReceipt?.total ?? "";
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 context.sizeH(2),
//                 ToolBarWithOutBackWidget(tittle: AppStrings.paymentSCreen),
//                 if (widget.item != null)
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Consumer<PaymentMethodProvider>(
//                           builder: (context, Pro, _) {
//                         var trim = Provider.of<HistoryProvider>(context)
//                             .convertToCustomFormat(
//                                 widget.item?.orderReceipt?.endTime ?? "")
//                             .split(',');
//                         // var trim = Provider.of<HistoryProvider>(context)
//                         //     .convertToCustomFormat(DateTime.now().toString())
//                         //     .split(', ');
//                         return Column(
//                           children: [
//                             //      PaymentDetailWidget(),
//                             context.sizeH(2),
//                             customRow(title: AppStrings.date, value: trim[0]),
//                             customRow(title: AppStrings.time, value: trim[1]),
//                             customRow(
//                                 title: AppStrings.totalDistance,
//                                 value: widget.item?.orderReceipt?.actualDistance
//                                         .toString() ??
//                                     "0 KM"),
//                             customRow(
//                                 title: AppStrings.timeToken,
//                                 value:
//                                     "${widget.item?.orderReceipt?.actualTime ?? 0} min"),
//                             const Divider(height: 20, thickness: 2),
//                             customRow(
//                                 title: AppStrings.baseFare,
//                                 value:
//                                     "CA\$ ${widget.item?.orderReceipt?.vehicleCategory?.baseFare ?? ""}.00"),
//                             customRow(
//                                 title: AppStrings.techFare,
//                                 value:
//                                     "CA\$ ${widget.item?.orderReceipt?.vehicleCategory?.techFee ?? ""}"),
//
//                             customRow(
//                                 title: "Extra Distance",
//                                 value: (widget.item?.orderReceipt?.extraDistance
//                                             ?.isEmpty ??
//                                         false)
//                                     ? "0 km"
//                                     : (widget.item?.orderReceipt
//                                             ?.extraDistance ??
//                                         "0")),
//                             customRow(
//                                 title:
//                                     "Extra Distance Price \$${widget.item?.orderReceipt?.vehicleCategory?.priceKm ?? 0}/ km",
//                                 value:
//                                     "CA\$ ${widget.item?.orderReceipt?.extraDistancePrice ?? "0"}"),
//                             customRow(
//                                 title: "Extra Time",
//                                 value: widget.item?.orderReceipt?.extraTime ??
//                                     "0 min"),
//                             customRow(
//                                 title:
//                                     "Extra Time Price \$${widget.item?.orderReceipt?.vehicleCategory?.priceMin}/min",
//                                 value:
//                                     "CA\$ ${widget.item?.orderReceipt?.extraTimePrice ?? "0"}"),
//
//                             // customRow(
//                             //     title: AppStrings.perKm,
//                             //     value:
//                             //         "CA\$ ${widget.item?.orderReceipt?.vehicleCategory?.priceKm ?? ""}"),
//                             // customRow(
//                             //     title: AppStrings.perMin,
//                             //     value:
//                             //         "CA\$ ${Provider.of<ReceiptScrerenProvider>(context, listen: false).receiptModel?.orderReceipt?.vehicleCategory?.priceMin ?? ""}"),
//                             // const Divider(height: 20, thickness: 2),
//                             SizedBox(
//                               height: 30,
//                               child: Row(
//                                 children: [
//                                   const Text(r"Add Tip CAD$"),
//                                   context.sizeW(30),
//                                   Expanded(
//                                     child: TextField(
//                                       inputFormatters: [
//                                         // FilteringTextInputFormatter.allow(
//
//                                         FilteringTextInputFormatter.allow(
//                                             RegExp(r'^\d+\.?\d{0,2}')),
//                                         // RegExp(r'^[0-9]+.?[0-9]*')),
//                                         // WhitelistingTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}')),
//
//                                         // FilteringTextInputFormatter.allow(
//                                         //     RegExp(r'[0-9]'))
//                                       ],
//                                       controller: tips,
//                                       onChanged: (value) {
//                                         log("test value is-->> $value");
//                                         log("length is ::_>> ${value.length}");
//
//                                         if (value != '') {
//                                           setState(() {
//                                             updateTotalAmount(tip: value);
//                                           });
//                                         } else {
//                                           setState(() {
//                                             updateTotalAmount(tip: "0.0");
//                                           });
//                                         }
//                                       },
//                                       onTapOutside: (event) {
//                                         setState(() {
//                                           // updateTotalAmount(tip: "0.0");
//                                         });
//                                         FocusScope.of(context)
//                                             .requestFocus(FocusNode());
//                                       },
//                                       keyboardType:
//                                           const TextInputType.numberWithOptions(
//                                               decimal: true),
//                                       decoration: const InputDecoration(
//                                         contentPadding: EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         border: OutlineInputBorder(),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             const Divider(height: 20, thickness: 2),
//                             customRow(
//                                 title: AppStrings.totalPrice,
//                                 value: "CA\$ $totalAmountToPay",
//                                 titleFont: FontMixin.boldFamily,
//                                 valueFont: FontMixin.boldFamily,
//                                 color: Colors.black),
//                           ],
//                         );
//                       })),
//                 context.sizeH(20),
//                 ButtonWidget(
//                   msg: 'Pay',
//                   fontColor: AppColors.colorWhite,
//                   callback: () async {
//                     if (!widget.isPendingPayment) {
//                       var homeProvider = locator<HomeViewProvider>();
//                       homeProvider.clearController();
//                     }
//                     await action(
//                      context:  context,
//                       orderId: widget.item?.orderReceipt?.id??'',
//                       driverId: widget.item?.orderReceipt?.driverId??'',
//                       isPendingPayment: widget.isPendingPayment,
//                       tips: tips.text.trim(),
//                       totalAmountToPay: totalAmountToPay,
//
//                     );
//                     //    homeProvider.updateStartEndController().then((value) async {
//                     //       log("asjfndsjhsjfndshf");
//                     //       log("---${homeProvider.pickUpText.text}");
//                     //       log(homeProvider.dropText.text.toString());
//                     //       Provider.of<SocketProvider>(context, listen: false).removeItem();
//                     //     await action();
//                     // });
//                   },
//                 ),
//                 context.sizeH(5),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget customRow(
//       {required String title,
//       required String value,
//       bool showBox = false,
//       EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 8.0),
//       Color color = AppColors.color5E6D55,
//       String titleFont = FontMixin.regularFamily,
//       String valueFont = FontMixin.mediumFamily}) {
//     return Padding(
//       padding: padding,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           TextWidget(
//             msg: title,
//             color: color,
//             textSize: 16,
//             font: titleFont,
//           ),
//           Container(
//             color: showBox ? const Color(0xFFEDF3ED) : Colors.transparent,
//             padding: const EdgeInsets.all(5),
//             child: TextWidget(
//               msg: value,
//               color: color,
//               textSize: 16,
//               font: valueFont,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

Future<void> action({
  required BuildContext context,
  String? tips,
  bool? isPendingPayment,
  String? totalAmountToPay,
  String? orderId,
  String? driverId,
}) async {
  try {
    if (context.mounted) {
      final card = SharedPreferencesManager().getCardDetail();
      final getCoupons = SharedPreferencesManager().getCoupons();
      // if (paymentMethodProvider.selectCardId == null ||
      //     paymentMethodProvider.selectCardId.toString().isEmpty) {
      //   Provider.of<PaymentMethodProvider>(context, listen: false)
      //       .addCoupon(context);
      //   Navigator.pushNamed(context, SelectPaymentMethodView.routeName);
      // } else {
      /// todo: check coupe id
      var body = {
        'coupon_id': getCoupons != null ? getCoupons.id : 0,
        'tip': (tips?.isEmpty ?? false) ? 0 : tips?.trim(),
        // 'token': cardToken,
        'order_id': int.parse(orderId ?? "0"),
        "driver_id": int.parse(driverId ?? "0"),
        "amount": totalAmountToPay,
        "payment_type": (isPendingPayment ?? false) ? 1 : 0,
        "card_id": card?.id ?? ""
      };
      await pay(
        context: context,
        body: body,
        orderId: orderId ?? "",
        tips: tips,
        isPendingPayment: isPendingPayment,
        totalAmountToPay: totalAmountToPay,
        driverId: driverId,
      );
      // }
    }
  } catch (e, t) {
    Dev.log("error>>>>>>>>>$e");
    Dev.log("error>>>>>>>>>$t");
  }
}

Future<void> pay({
  required BuildContext context,
  required Map<String, dynamic> body,
  String? tips,
  bool? isPendingPayment,
  String? totalAmountToPay,
  String? orderId,
  String? driverId,
}) async {
  ProgressDialog.showProgressDialog(context);
  var dio = Dio();

  var userToken = SharedPreferencesManager().token;

  log(body.toString());
  log("user token is:-->> $userToken");

  var response = await dio.post(
    NetworkConstant.payment,
    // 'https://php.parastechnologies.in/taxi/public/api/webservice/driver/payment',
    data: body,
    options: Options(headers: {"Authorization": "Bearer $userToken"}),
  );
  Dev.log("response=====>${response.data}");
  if (context.mounted) {
    Navigator.pop(context);
    final ctx = navigatorKey.currentContext;
    if (response.data["success"] == 1) {
      await SharedPreferencesManager().removeOrderID();
      await SharedPreferencesManager().removeCoupon();
      print(response.data["message"]);
      if (ctx != null && ctx.mounted) {
        showDialog(
          barrierDismissible: false,
          context: ctx,
          builder: (ctx) => AlertDialog(
            title: LottieBuilder.asset(
              "assets/animation/successfully.json",
              height: 200,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  msg: "Ride Payment Status",
                  color: AppColors.color001E00,
                  textSize: 18,
                  fontWeight: FontMixin.fontWeightMedium,
                  font: FontMixin.mediumFamily,
                ),
                TextWidget(
                  msg: "Payment successful",
                  color: AppColors.color001E00,
                  textSize: 14,
                  fontWeight: FontMixin.fontWeightMedium,
                  font: FontMixin.mediumFamily,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ButtonWidget(
                  msg: "Ok",
                  fontColor: AppColors.colorWhite,
                  callback: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarReceiptScreen(
                            orderrId: orderId,
                            isPendingPayment: isPendingPayment,
                            callPayment: false,
                          ),
                        ));
                  },
                )
              ],
            ),
          ),
        );
      }
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          title: LottieBuilder.asset(
            "assets/animation/unsuccessfull.json",
            height: 180,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                msg: 'Payment unsuccessfully',
                color: AppColors.color001E00,
                textSize: 18,
                fontWeight: FontMixin.fontWeightMedium,
                font: FontMixin.mediumFamily,
              ),
              TextWidget(
                msg: response.data["message"],
                color: AppColors.color001E00,
                textSize: 14,
                fontWeight: FontMixin.fontWeightMedium,
                font: FontMixin.mediumFamily,
              ),
              const SizedBox(
                height: 20.0,
              ),
              dotedDevider(context),
              context.sizeH(0.5),
              applePayButton(context),
              context.sizeH(0.5),
              dotedDevider(context),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonWidget(
                msg: "Pay Again",
                fontColor: AppColors.colorWhite,
                callback: () async {
                  if (Provider.of<PaymentMethodProvider>(context, listen: false)
                          .radioButtonValue ==
                      null) {
                    context.showAnimatedToast('Select Payment Mode');
                  } else {
                    await action(
                      context: context,
                      tips: tips,
                      isPendingPayment: isPendingPayment,
                      totalAmountToPay: totalAmountToPay,
                      orderId: orderId,
                      driverId: driverId,
                    );
                  }
                },
              )
            ],
          ),
        ),
      );
    }
  }
}
