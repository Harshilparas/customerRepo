

import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';

import '../app_constant/app_colors.dart';

///This is the CommonButton [button] widget
/// with a [msg] text and a [callback] onTap
class ButtonWidget extends StatelessWidget {
  String? msg;
  VoidCallback? callback;
  Color? fontColor;
  Color? bgBolor;
  Widget? widget;
  double? height;
  double?width;
  bool? isleading = false;

  ButtonWidget(
      {Key? key,
      this.bgBolor,
      this.msg,
        this.width,
      this.callback,
      this.fontColor,
      this.height,
      this.isleading,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback!();
      },
      onDoubleTap: null,

      child: Container(
        width: width??MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(22.0)),
          color: bgBolor ?? AppColors.color40AFD2D,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2,bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget ?? const SizedBox(),
              context.sizeW(2),
              Visibility(
                visible: widget == null,
                replacement: Center(
                    child: TextWidget(
                  msg: msg!,
                  textSize: 15.0,
                  font: FontMixin.mediumFamily,
                  color: fontColor,
                  fontWeight: FontMixin.fontWeightMedium,
                  textAlign: TextAlign.center,
                )),
                child: Expanded(
                  child: Center(
                      child: TextWidget(
                    msg: msg!,
                    textSize: 15.0,
                    font: FontMixin.mediumFamily,
                    color: fontColor??Colors.white,
                    fontWeight: FontMixin.fontWeightMedium,
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///This is the CommonButton [button] widget
/// with a [msg] text and a [callback] onTap
class ButtonWidgetActions extends StatelessWidget {
  String? msg;
  VoidCallback? callback;
  Color? fontColor;
  Color? bgBolor;
  Widget? widget;
  double? height;
  bool? isleading = false;

  ButtonWidgetActions(
      {Key? key,
      this.bgBolor,
      this.msg,
      this.callback,
      this.fontColor,
      this.height,
      this.isleading,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callback!();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(22.0)),
          color: bgBolor ?? AppColors.color40AFD2D,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2, bottom: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: widget == null,
                replacement: Center(
                    child: Row(
                  children: [
                    TextWidget(
                      msg: msg!,
                      textSize: 15.0,
                      font: FontMixin.mediumFamily,
                      color: fontColor,
                      fontWeight: FontMixin.fontWeightMedium,
                      textAlign: TextAlign.center,
                    ),
                    context.sizeW(2),
                    widget ?? const SizedBox(),
                  ],
                )),
                child: Center(
                    child: TextWidget(
                  msg: msg!,
                  textSize: 15.0,
                  font: FontMixin.mediumFamily,
                  color: fontColor,
                  fontWeight: FontMixin.fontWeightMedium,
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
