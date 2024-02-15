part of 'car_receipt_screen.dart';

class FareBreakdownDetailWidget extends StatelessWidget {
  final  ReceiptModel? receiptModel;

   const FareBreakdownDetailWidget({super.key, this.receiptModel,});
  //========//
  @override
  Widget build(BuildContext context) {
    final receipt =receiptModel?.orderReceipt;
    return Consumer<SocketProvider>(
      builder: (context,carDetail,_) {
        var trim =Provider.of<HistoryProvider>(context).convertToCustomFormat(receipt?.endTime??" , ").split(',');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              msg: "Fare Breakdown",
              textSize: 20,
              color: Colors.black,
              font: FontMixin.mediumFamily,
            ),
            context.sizeH(2),
            customRow(title: AppStrings.date, value:trim[0]),
            customRow(title: AppStrings.time, value:trim[1]),
            // customRow(title: AppStrings.totalDistance, value: "${carDetail.customerReceiptModel?.data?.distance.toString()??0} Km"),
            // customRow(title: AppStrings.timeToken, value: "${carDetail.customerReceiptModel?.data?.actualTime??0} minutes"),
            customRow(title: AppStrings.totalDistance, value: receipt?.actualDistance.toString()??"0 KM"),
            customRow(title: AppStrings.timeToken, value: "${receipt?.actualTime??0} min"),
            const Divider(height: 20, thickness: 2),
            customRow(title: AppStrings.baseFare, value: "CA\$ ${receipt?.vehicleCategory?.baseFare??""}.00"),
            customRow(title: AppStrings.techFare, value: "CA\$ ${receipt?.vehicleCategory?.techFee??""}"),
            customRow(title: "Extra Distance", value: (receipt?.extraDistance?.isEmpty??false)?"0 km":(receipt?.extraDistance??"0")),
            customRow(title: "Extra Distance Price \$${receipt?.vehicleCategory?.priceKm??0}/ km", value: "CA\$ ${receipt?.extraDistancePrice??"0"}"),
             customRow(title:"Extra Time", value: receipt?.extraTime??"0 min"),
            customRow(title: "Extra Time Price \$${receipt?.vehicleCategory?.priceMin}/min", value: "CA\$ ${receipt?.extraTimePrice??"0"}"),

            // customRow(title: AppStrings.perKm, value: "CA\$ ${receipt?.vehicleCategory?.priceKm??""}"),
            // customRow(title: AppStrings.perMin, value: "CA\$ ${receipt?.vehicleCategory?.priceMin??""}"),
            const Divider(height: 20, thickness: 2),
           /* customRow(title: AppStrings.addTip, value: "CA \$0", showBox: true),
            const Divider(height: 20, thickness: 2),*/
            customRow(
                title: AppStrings.totalPrice,
                value:  "CA""\$ ${receipt?.total??""}",
                titleFont: FontMixin.boldFamily,
                valueFont: FontMixin.boldFamily,
                color: Colors.black),
            context.sizeH(4),
            ButtonWidget(
              msg:"Next",
              fontColor: AppColors.colorWhite,
              callback: () {

              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
              //       PaymentSCreen(item:receiptModel)));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubmitFeedbackView(
                              item: receiptModel,
                            )));
              },
            ),
            context.sizeH(2),
          ],
        );
      }
    );
  }
}

// class PaymentDetailWidget extends StatefulWidget {
//   TextEditingController? tip;
//    PaymentDetailWidget({super.key,this.tip});

//   @override
//   State<PaymentDetailWidget> createState() => _PaymentDetailWidgetState();
// }

// class _PaymentDetailWidgetState extends State<PaymentDetailWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SocketProvider>(
//         builder: (context,carDetail,_) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [

//               context.sizeH(2),
//               customRow(title: AppStrings.date, value: carDetail.customerReceiptModel!.data!.actualTime.toString()),
//               customRow(title: AppStrings.time, value: "12:00 PM"),
//               customRow(title: AppStrings.totalDistance, value: "${carDetail.customerReceiptModel!.data!.distance.toString()}Km"),
//               customRow(title: AppStrings.timeToken, value: "30 min"),
//               const Divider(height: 20, thickness: 2),
//               customRow(title: AppStrings.baseFare, value: "CA\$11.70"),
//               customRow(title: AppStrings.techFare, value: "CA\$11.70"),
//               customRow(title: AppStrings.perKm, value: "CA\$11.70"),
//               customRow(title: AppStrings.perMin, value: "CA\$11.70"),
//               const Divider(height: 20, thickness: 2),

//               const Divider(height: 20, thickness: 2),
//               customRow(
//                   title: AppStrings.totalPrice,
//                   value: "${carDetail.customerReceiptModel?.data?.total??""}\$",
//                   titleFont: FontMixin.boldFamily,
//                   valueFont: FontMixin.boldFamily,
//                   color: Colors.black),

//             ],
//           );
//         }
//     );
//   }
// }


Widget customRow(
    {required String title,
    required String value,
    bool showBox = false,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(vertical: 8.0),
    Color color = AppColors.color5E6D55,
    String titleFont = FontMixin.regularFamily,
    String valueFont = FontMixin.mediumFamily}) {
  return Padding(
    padding: padding,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          msg: title,
          color: color,
          textSize: 16,
          font: titleFont,
        ),
        Container(
          color: showBox ? const Color(0xFFEDF3ED) : Colors.transparent,
          padding: const EdgeInsets.all(5),
          child: TextWidget(
            msg: value,
            color: color,
            textSize: 16,
            font: valueFont,
          ),
        ),
      ],
    ),
  );
}



