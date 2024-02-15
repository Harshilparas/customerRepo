import 'package:flutter/material.dart';

extension CommonSizeBox on BuildContext {



  //
  Widget sizeH(double percentage) {
    double screenHeight = MediaQuery.of(this).size.height;
    double desiredHeight = screenHeight * percentage / 100.0;

    return SizedBox(height: desiredHeight);
  }


   ///
  Widget sizeW(double percentage) {
    double screenWidth = MediaQuery.of(this).size.width;
    double desiredHeight = screenWidth * percentage / 100.0;

    return SizedBox(width: desiredHeight);
  }
}


extension MediaQueryExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}