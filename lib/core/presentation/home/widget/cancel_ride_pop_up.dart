part of '../view/home_view.dart';

class CancelRidePopUp extends StatelessWidget {
  const CancelRidePopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SocketProvider>(
      builder: (context,socket,_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            context.sizeH(2),
            Container(
              width: 61.96,
              height: 6,
              decoration: BoxDecoration(
                  color: Colors.grey[300], borderRadius: BorderRadius.circular(15)),
            ),
            context.sizeH(2),
            SizedBox(
              height: context.screenHeight / 5,
              width: context.screenWidth / 2,
              child: AppImagesPath.cancelPopUp.image(fit: BoxFit.contain),
            ),

            context.sizeH(4),
            TextWidget(
              msg: AppStrings.likeToCancel,
              font: FontMixin.regularFamily,
              fontWeight: FontMixin.fontWeightBold,
              textSize: 20,
            ),
            context.sizeH(4),

            /// Cancel ride button
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                children: [
                  Expanded(
                    child: ButtonWidget(
                      msg: AppStrings.yes,
                      fontColor: AppColors.colorWhite,
                      callback: () {
                        socket.cancelBooking(context);
                     
                     //   Navigator.pop(context);
                      },
                    ),
                  ),
                  context.sizeW(5),
                  Expanded(
                    child: ButtonWidget(
                      bgBolor: AppColors.color001E00,
                      msg: AppStrings.no,
                      fontColor: AppColors.colorWhite,
                      callback: () {
                       // Navigator.pushNamed(context, HomeView.routeName,);
                   //     Navigator.pop(context);
                        Navigator.pop(context, true);
                      },
                    ),
                  ),
                ],
              ),
            ),
            context.sizeH(2)
          ],
        );
      }
    );
  }
}
