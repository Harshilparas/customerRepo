part of '../view/home_view.dart';

class RequestRideView extends StatefulWidget {
  const RequestRideView({super.key});

  @override
  State<RequestRideView> createState() => _RequestRideViewState();
}

class _RequestRideViewState extends State<RequestRideView> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeViewProvider, RequestProvider>(
        builder: (context, provider, requestProvider, _) {
      return PopScope(
        canPop: false,
        onPopInvoked: (v) {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            context.sizeH(2),
            SizedBox(
              height: context.screenHeight / 4,
              width: context.screenWidth / 1.5,
              child: AppImagesPath.requestRide.image(fit: BoxFit.contain),
            ),

            ///  loading
            context.sizeH(2),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: RepeatingLinearProgressIndicator(),
            ),
            context.sizeH(2),
            TextWidget(
              msg: AppStrings.pleaseWait,
              font: FontMixin.regularFamily,
              fontWeight: FontMixin.fontWeightBold,
              textSize: 16,
            ),
            context.sizeH(1),
            TextWidget(
              textAlign: TextAlign.center,
              msg: AppStrings.nearbyDriverText,
              font: FontMixin.regularFamily,
              fontWeight: FontMixin.fontWeightMedium,
              textSize: 16,
            ),
            context.sizeH(1),

            /// Cancel ride button
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: ButtonWidget(
                msg: AppStrings.cancelRide,
                fontColor: AppColors.colorWhite,
                callback: () {
                  ModalBottomSheet.moreModalBottomSheet(
                    context,
                    const CancelRidePopUp(),
                    isExpendable: false,
                    // topBorderRadius: 0,
                    padding: EdgeInsets.zero,
                  );
                },
              ),
            ),
            context.sizeH(2)
          ],
        ),
      );
    });
  }
}
