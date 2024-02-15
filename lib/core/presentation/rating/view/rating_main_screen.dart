// import 'package:deride_user/utils/app_constant/app_colors.dart';
// import 'package:deride_user/utils/app_constant/app_image_strings.dart';
// import 'package:deride_user/utils/app_constant/app_strings.dart';
// import 'package:deride_user/utils/extensions/image_extensions.dart';
// import 'package:deride_user/utils/extensions/sizebox_extension.dart';
// import 'package:deride_user/utils/fonts.dart';
// import 'package:deride_user/utils/widget/circular_image_widget.dart';
// import 'package:deride_user/utils/widget/text_widget.dart';
// import 'package:deride_user/utils/widget/tool_bar_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// part 'average_rating_widget.dart';
//
// part 'rating_given_user_widget.dart';
//
// class RatingMainScreen extends StatelessWidget {
//   const RatingMainScreen({super.key});
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
//                 const ToolBarWidget(tittle: AppStrings.ratings),
//                 context.sizeH(4),
//                 const AverageRatingWidget(),
//                 context.sizeH(2),
//                 ListView.builder(
//                   itemCount: 10,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     return const RatingGivenUserWidget();
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
