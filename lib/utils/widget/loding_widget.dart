
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

Widget dataSpinner(){
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppColors.color5E6D55.withOpacity(0.1),
          offset: const Offset(0,0.2),
          blurRadius: 0.2
        )
      ]
    ),
    child:   const Padding(
      padding: EdgeInsets.all(15.0),
      child: SpinKitFadingCircle(
        color: AppColors.color001E00,
        size: 50,
      ),
    ),
  );

}

 //
class ProgressDialog {
  static void showProgressDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animation/Animation - 1697716999332.json",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
                repeat: true,
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => true, child: alert);
      },
    );
  }}


Widget circularIndicator() {
  return const SizedBox(
    height: 50,
    width: 50,
    child: CircularProgressIndicator(
      strokeWidth: 5,
      color: AppColors.color63BA6B1A,
    ),
  );
}
