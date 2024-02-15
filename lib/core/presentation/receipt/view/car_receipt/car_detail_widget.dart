part of 'car_receipt_screen.dart';

class CarDetailWidget extends StatelessWidget {
  final ReceiptModel? receiptModel;

  const CarDetailWidget({super.key, this.receiptModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        context.sizeH(4),
        Align(
          alignment: Alignment.center,
          child: (receiptModel?.orderReceipt?.vehicleCategory?.image?.isEmpty ??
                  false)
              ? AppImagesPath.xlCar.image()
              : Image.network(
                  "${NetworkConstant.imageBaseUrl}${receiptModel?.orderReceipt?.vehicleCategory?.image}",
            width: context.screenWidth/1.8,
            fit: BoxFit.cover,
                ),
        ),
        context.sizeH(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppImagesPath.seatImage.svg,
            context.sizeW(2),
            TextWidget(
              msg: receiptModel?.orderReceipt?.vehicleCategory?.seat ?? "0",
              color: Colors.black,
              font: FontMixin.mediumFamily,
            ),
            context.sizeW(5),
            Container(
              height: 36,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFC5C5C5),
                  ),
                ),
              ),
            ),
            context.sizeW(5),
            AppImagesPath.bagImage.svg,
            context.sizeW(2),
            TextWidget(
              msg: receiptModel?.orderReceipt?.vehicleCategory?.baseFare
                      .toString() ??
                  "0",
              color: Colors.black,
              font: FontMixin.mediumFamily,
            ),
          ],
        )
      ],
    );
  }
}
