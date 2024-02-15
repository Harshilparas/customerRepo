// part of '../car_receipt/car_receipt_screen.dart';
//
// get fixPadding => const EdgeInsets.all(10);
//
// class ReceiptScreen extends StatefulWidget {
//   var orderId;
//    ReceiptScreen({super.key,this.orderId});
//   static const routeName = '/finalReceipt';
//
//   @override
//   State<ReceiptScreen> createState() => _ReceiptScreenState();
// }
//
// class _ReceiptScreenState extends State<ReceiptScreen> {
//   @override
//   void initState() {
//     Provider.of<ReceiptScrerenProvider>(context,listen: false).getReceiptDetail(context, widget.orderId);
//
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 context.sizeH(2),
//                  ToolBarWithOutBackWidget(tittle: AppStrings.receipt),
//                 context.sizeH(4),
//                 const UserDetailWidget(),
//                 context.sizeH(3),
//                 fareBreakdown(context),
//                 context.sizeH(3),
//                 const PaymentInfoWidget(),
//                 context.sizeH(1),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: AppColors.color0F40AF2D,
//                   ),
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     children: [
//                       customRow(title: AppStrings.baseFare, value: "CA\$11.70"),
//                       customRow(title: AppStrings.techFare, value: "CA\$11.70"),
//                       customRow(title: AppStrings.perKm, value: "CA\$11.70"),
//                       customRow(title: AppStrings.perMin, value: "CA\$11.70"),
//                       customRow(title: AppStrings.tip, value: "CA\$5.70"),
//                       const Divider(height: 20, thickness: 2),
//                       customRow(
//                           title: AppStrings.totalPrice,
//                           value: "\$40.01",
//                           titleFont: FontMixin.mediumFamily,
//                           valueFont: FontMixin.boldFamily,
//                             color: AppColors.color001E00,),
//                     ],
//                   ),
//                 ),
//                 context.sizeH(3),
//                 ButtonWidget(
//                   msg: AppStrings.backToHome,
//                   fontColor: AppColors.colorWhite,
//                   callback: () {
//                     Navigator.pushNamed(context, HomeView.routeName);
//                   },
//                 ),
//                 context.sizeH(2)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget fareBreakdown(BuildContext context) {
//     return Container(
//       decoration: ShapeDecoration(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(width: 1, color: AppColors.color265E6D55),
//           borderRadius: BorderRadius.circular(15),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           context.sizeH(0.5),
//           Padding(
//             padding: fixPadding,
//             child: TextWidget(
//               msg: "Fare Breakdown",
//               textSize: 18,
//               color: AppColors.color001E00,
//               font: FontMixin.mediumFamily,
//             ),
//           ),
//           context.sizeH(0.5),
//           const Divider(height: 5, thickness: 2),
//           // context.sizeH(2),
//           customRow(
//               title: AppStrings.date,
//               value: "09 May 2023",
//               padding: fixPadding),
//           customRow(
//               title: AppStrings.time, value: "12:00 PM", padding: fixPadding),
//           customRow(
//               title: AppStrings.totalDistance,
//               value: "12 km",
//               padding: fixPadding),
//           customRow(
//               title: AppStrings.timeToken,
//               value: "30 min",
//               padding: fixPadding),
//         ],
//       ),
//     );
//   }
// }
