import 'package:flutter/material.dart';

extension CenterExtension on Widget {
  Widget center() {
    return Center(
      child:
          this, // 'this' refers to the widget you're calling the extension on
    );
  }
}
