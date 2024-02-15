// import 'package:deride_user/core/presentation/setting/view/history_details_view.dart';
// import 'package:deride_user/utils/app_constant/app_colors.dart';
// import 'package:deride_user/utils/app_constant/app_image_strings.dart';
// import 'package:deride_user/utils/app_constant/app_strings.dart';
// import 'package:deride_user/utils/extensions/image_extensions.dart';
// import 'package:deride_user/utils/extensions/sizebox_extension.dart';
// import 'package:deride_user/utils/fonts.dart';
// import 'package:deride_user/utils/widget/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class HistoryListTile extends StatelessWidget {
//   const HistoryListTile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return InkWell(
//       onTap: () {
//         // <------------- Navigating to history Details view ----------> //
//         Navigator.pushNamed(context, HistoryDetailsView.routeName);
//       },
//       child: Container(
//         margin: const EdgeInsets.only(top: 7, bottom: 7),
//         width: context.screenWidth,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: AppColors.color5E6D55.withOpacity(0.15)),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextWidget(
//                     msg: "10 May 2023, 3:30PM",
//                     font: FontMixin.regularFamily,
//                     fontWeight: FontMixin.fontWeightRegular,
//                     textSize: 14,
//                     color: AppColors.color001E00,
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         height: 6,
//                         width: 6,
//                         decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColors.color001E00),
//                       ),
//                       context.sizeW(2),
//                       TextWidget(
//                         msg: "In Progress",
//                         font: FontMixin.boldFamily,
//                         fontWeight: FontMixin.fontWeightBold,
//                         textSize: 14,
//                         color: AppColors.color001E00,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               height: 1,
//               width: context.screenWidth,
//               color: AppColors.color5E6D55.withOpacity(0.15),
//             ),
//
//             /// Origin and distance column wit fare
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   /// Pickup and Drop location column
//                   Column(
//                     children: [
//                       /// Pickup row
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: context.screenHeight * 0.03,
//                             width: context.screenHeight * 0.03,
//                             child: AppImagesPath.pickupIcon.svg,
//                           ),
//                           context.sizeW(5),
//                           TextWidget(
//                             msg: "PJCX+6R3, Sector 115",
//                             font: FontMixin.mediumFamily,
//                             fontWeight: FontMixin.fontWeightMedium,
//                             textSize: 16,
//                             color: AppColors.color001E00,
//                           )
//                         ],
//                       ),
//                       // Destination row
//                       context.sizeH(2),
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: context.screenHeight * 0.03,
//                             width: context.screenHeight * 0.03,
//                             child: AppImagesPath.dropIcon.svg,
//                           ),
//                           context.sizeW(5),
//                           TextWidget(
//                             msg: "PJCX+6R3, Sector 115",
//                             font: FontMixin.mediumFamily,
//                             fontWeight: FontMixin.fontWeightMedium,
//                             textSize: 16,
//                             color: AppColors.color001E00,
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   // Total Fare Colum
//                   Column(
//                     children: [
//                       TextWidget(
//                         msg: AppStrings.totalFare,
//                         font: FontMixin.mediumFamily,
//                         fontWeight: FontMixin.fontWeightMedium,
//                         textSize: 14,
//                         color: AppColors.color5E6D55,
//                       ),
//                       context.sizeH(1),
//                       TextWidget(
//                         msg: "\$152",
//                         font: FontMixin.mediumFamily,
//                         fontWeight: FontMixin.fontWeightMedium,
//                         textSize: 24,
//                         color: AppColors.color001E00,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
//               child: Container(
//                 height: 1,
//                 width: context.screenWidth,
//                 color: AppColors.color5E6D55.withOpacity(0.15),
//               ),
//             ),
//
//             /// Ride type row
//             Padding(
//               padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextWidget(
//                         msg: AppStrings.rideType,
//                         font: FontMixin.regularFamily,
//                         fontWeight: FontMixin.fontWeightRegular,
//                         textSize: 16,
//                         color: AppColors.color5E6D55,
//                       ),
//                       TextWidget(
//                         msg: "Mini (4 Person)",
//                         font: FontMixin.mediumFamily,
//                         fontWeight: FontMixin.fontWeightMedium,
//                         textSize: 16,
//                         color: AppColors.color001E00,
//                       ),
//                     ],
//                   ),
//                   context.sizeH(1),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextWidget(
//                         msg: "Payment by",
//                         font: FontMixin.regularFamily,
//                         fontWeight: FontMixin.fontWeightRegular,
//                         textSize: 16,
//                         color: AppColors.color5E6D55,
//                       ),
//                       TextWidget(
//                         msg: "Google Pay",
//                         font: FontMixin.mediumFamily,
//                         fontWeight: FontMixin.fontWeightMedium,
//                         textSize: 16,
//                         color: AppColors.color001E00,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
