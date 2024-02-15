part of '../car_receipt/car_receipt_screen.dart';

class PaymentInfoWidget extends StatelessWidget {
  const PaymentInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.color265E6D55),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            context.sizeH(0.5),
            TextWidget(
              msg: "Payment Information",
              textSize: 18,
             color: AppColors.color001E00,
              font: FontMixin.mediumFamily,
            ),
            context.sizeH(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  msg: "Payment Through",
                  color: AppColors.color5E6D55,
                  textSize: 16,
                  font: FontMixin.regularFamily,
                ),
                const Spacer(),
                Container(
                  color: const Color(0xFFEDF3ED),
                  padding: const EdgeInsets.all(5),
                  child: AppImagesPath.masterCardIcon.svg,
                ),
                TextWidget(
                  msg: "Card",
                  color: AppColors.color5E6D55,
                  textSize: 16,
                  font: FontMixin.regularFamily,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
