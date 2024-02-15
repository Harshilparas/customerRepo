import 'package:flutter/material.dart';

class ModalBottomSheet {
  static void moreModalBottomSheet(
    context,
    Widget widget, {
    bool isExpendable = true,
    bool isScrollControlled = true,
    double topBorderRadius = 20.0,
    double? maxHeight,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(20, 20, 20, 20),
  }) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: isScrollControlled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height * 0.35,
              maxHeight: ((isExpendable)
                  ? (maxHeight ?? size.height * 0.5)
                  : double.infinity),
              maxWidth: size.width,
            ),
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(topBorderRadius),
                  topLeft: Radius.circular(topBorderRadius),
                ),
              ),
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isExpendable) Expanded(child: widget) else widget
                  ],
                ),
              ),
            ),
          );
        });
  }
}
