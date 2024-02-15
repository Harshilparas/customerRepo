// part of 'rating_main_screen.dart';
//
// class AverageRatingWidget extends StatelessWidget {
//   const AverageRatingWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         color: AppColors.color0F40AF2D,
//       ),
//       padding: const EdgeInsets.all(15),
//       child: Row(
//         children: [
//           TextWidget(
//             msg: '4.5',
//             textAlign: TextAlign.center,
//             color: AppColors.secondary,
//             textSize: 34,
//             font: FontMixin.mediumFamily,
//           ),
//           context.sizeW(3),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               IgnorePointer(
//                 child: RatingBar.builder(
//                   initialRating: 4.5,
//                   minRating: 1,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 20,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 2),
//                   itemBuilder: (context, _) => AppImagesPath.starIcon.svg,
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                   },
//                 ),
//               ),
//               context.sizeH(1),
//               TextWidget(
//                 msg: 'Based On 20 Reviews',
//                 textAlign: TextAlign.center,
//                 color: AppColors.color5E6D55,
//                 textSize: 12,
//                 font: FontMixin.mediumFamily,
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
