part of '../car_receipt/car_receipt_screen.dart';

class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.color265E6D55),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            cachedNetworkImage(imageUrl: '', context: context),
            context.sizeW(2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  msg: 'Alex Robin',
                  color: AppColors.secondary,
                  textSize: 16,
                  font: FontMixin.mediumFamily,
                ),
                context.sizeH(0.5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFE6B045), size: 20),
                    TextWidget(
                      msg: '4.5',
                      color: AppColors.secondary,
                      textSize: 16,
                      font: FontMixin.mediumFamily,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextWidget(
                  msg: 'Chevrolet Trail',
                  color: AppColors.color5E6D55,
                  textSize: 14,
                  font: FontMixin.regularFamily,
                ),
                context.sizeH(0.5),
                TextWidget(
                  msg: 'GJZ 0196',
                  color: AppColors.secondary,
                  textSize: 14,
                  font: FontMixin.mediumFamily,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
