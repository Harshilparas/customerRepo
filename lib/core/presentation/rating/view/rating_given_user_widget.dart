// part of 'rating_main_screen.dart';
//
// class RatingGivenUserWidget extends StatelessWidget {
//   const RatingGivenUserWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             cachedNetworkImage(imageUrl: '', context: context),
//             context.sizeW(3),
//             Flexible(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Flexible(
//                         child: TextWidget(
//                           maxLine: 2,
//                           overflow: TextOverflow.ellipsis,
//                           msg: 'Alex RobinAlex',
//                           color: AppColors.secondary,
//                           textSize: 16,
//                           font: FontMixin.mediumFamily,
//                         ),
//                       ),
//                     ],
//                   ),
//                   context.sizeH(0.5),
//                   TextWidget(
//                     msg: '12 May 2023',
//                     color: AppColors.color5E6D55,
//                     textSize: 12,
//                     font: FontMixin.mediumFamily,
//                   ),
//                 ],
//               ),
//             ),
//             // const Spacer(),
//             Row(
//               children: [
//                 const Icon(Icons.star, color: Color(0xFFE6B045), size: 20),
//                 TextWidget(
//                   msg: '4.5',
//                   color: AppColors.secondary,
//                   textSize: 16,
//                   font: FontMixin.mediumFamily,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         context.sizeH(1),
//         TextWidget(
//           msg:
//               'Lorem ipsum dolor sit amet consectetur. Scelerisque ornare nunc adipiscing ipsum id turpis quis. Viverra amet arcu eget quisque cras risus lacus tristique morbi. Nisl magnis aliquam tortor dui adipiscing .',
//           color: AppColors.color5E6D55,
//           textSize: 12,
//           font: FontMixin.mediumFamily,
//         ),
//         context.sizeH(2),
//         const Divider(
//           thickness: 1,
//         )
//       ],
//     );
//   }
// }
