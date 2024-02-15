//
// import 'package:deride_user/utils/extensions/sizebox_extension.dart';
// import 'package:flutter/material.dart';
// import '../../../../utils/app_constant/app_colors.dart';
// import '../../../../utils/app_constant/app_strings.dart';
// import '../../../../utils/fonts.dart';
// import '../../../../utils/widget/button_widget.dart';
// import '../../../../utils/widget/text_widget.dart';
//
//
// class RatingScreen extends StatelessWidget {
//   const RatingScreen({Key? key}) : super(key: key);
//   static const routeName = '/ratingView';
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: SizedBox(
//                 width: context.screenWidth,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     Container(
//                       width: 125.0,
//                       height: 125.0,
//                       decoration:  BoxDecoration(
//                         image: const DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVEkc2UkDw7KRfYCWS062uQQCGYhm5mFPNFA&usqp=CAU')),
//                         borderRadius: const BorderRadius.all(Radius.circular(100)),
//                         color: Colors.redAccent,
//                         border: Border.all(
//                           color: AppColors.colorEDF3ED,// Border color
//                           width: 12, // Border width
//                         ),
//                       ),
//                     ),
//                     TextWidget(
//                       msg: "Alex Robin",
//                       font: FontMixin.mediumFamily,
//                       fontWeight: FontMixin.fontWeightMedium,
//                       color: AppColors.color001E00,
//                       textSize: 18,
//                     ),
//                     TextWidget(
//                       msg: "Alex Robin",
//                       font: FontMixin.mediumFamily,
//                       fontWeight: FontMixin.fontWeightMedium,
//                       color: AppColors.color001E00,
//                       textSize: 18,
//                     ),
//                     TextWidget(
//                       msg: AppStrings.howWasRide,
//                       font: FontMixin.mediumFamily,
//                       fontWeight: FontMixin.fontWeightMedium,
//                       color: AppColors.color001E00,
//                       textSize: 24,
//                     ),
//                     context.sizeH(2),
//                     TextWidget(
//                       msg: AppStrings.yourFeedbackWill,
//                       font: FontMixin.mediumFamily,
//                       fontWeight: FontMixin.fontWeightRegular,
//                       color: AppColors.color5E6D55,
//                       textSize: 18,
//                     ),
//                     TextWidget(
//                       msg: AppStrings.drivingExperience,
//                       font: FontMixin.mediumFamily,
//                       fontWeight: FontMixin.fontWeightRegular,
//                       color: AppColors.color5E6D55,
//                       textSize: 18,
//                     ),
//
//                 Container(
//                   height: context.screenHeight*0.2,
//                   width: context.screenWidth,
//                   decoration: BoxDecoration(
//                       color: AppColors.colorEDF3ED,
//                       borderRadius: BorderRadius.circular(11)
//                   ),
//                   child: TextFormField(
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.grey[200], // Background color
//                       border: InputBorder.none, // Remove the border
//                       hintText: AppStrings.additionalComments,
//                       contentPadding: EdgeInsets.all(12), // Adjust padding as needed
//                     ),
//                   ),
//                 ),
//
//                     ButtonWidget(
//                         bgBolor: AppColors.color001E00,
//                         msg: AppStrings.submit,
//                         fontColor: AppColors.colorWhite,
//                         callback: () {}),
//                     context.sizeH(2.0),
//                     ButtonWidget(
//                         msg: AppStrings.skip,
//                         fontColor: AppColors.colorWhite,
//                         callback: () {}),
//
//
//                   ],
//                 ),
//               )),
//         ),
//       ),
//     );
//   }
// }
