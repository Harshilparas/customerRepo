import 'package:deride_user/core/presentation/payment_method/widget/payment_card_common_layout.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/widget/button_widget.dart';
import '../provider/payment_method_provider.dart';
import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/fonts.dart';

class AddPaymentCard extends StatelessWidget {
  Widget? imageName;
  int type;
  String? msg;
  VoidCallback? callback;

  AddPaymentCard(
      {Key? key, this.imageName, required this.type, this.msg, this.callback})
      : super(key: key);

  ///==========//
  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentMethodProvider>(builder: (context, provider, _) {
      return Container(
        width: context.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: AppColors.colorWhite,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16.96,
                  offset: const Offset(0, 4.24))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: context.screenHeight * 0.06,
                    width: context.screenHeight * 0.06,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 0.0, top: 8.0, bottom: 8.0),
                      child: imageName,
                    ),
                  ),
                  context.sizeW(2.0),
                  TextWidget(
                    msg: msg ?? "",
                    fontWeight: FontMixin.fontWeightMedium,
                    textSize: 16,
                    color: AppColors.color001E00,
                    font: FontMixin.mediumFamily,
                  ),
                ],
              ),
              context.sizeW(5.0),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.9)),
                    value: provider.checkBoxValue == type ? true : false,
                    activeColor: AppColors.color40AFD2D,
                    checkColor: Colors.white,
                    onChanged: (bool? newValue) {

                      provider.updatedSelectedCard(
                        card:provider.getCard[type]
                      );
                      provider.changeInCheckBoxValue(type);
                      //checkBoxValue = newValue!;
                    }),
              ),
              IconButton(
                  onPressed: () {
                    print("kkk");

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width:
                                    MediaQuery.of(context).size.height * 0.18,
                                child: AppImagesPath.logoPath.image()),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  msg: "Do you want remove this card?",
                                  color: AppColors.color001E00,
                                  font: FontMixin.boldFamily,
                                  fontWeight: FontMixin.fontWeightRegular,
                                  maxLine: 1,
                                  textSize: 15,
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidget(
                                    width: 100,
                                    height: 40,
                                    msg: "Yes",
                                    fontColor: AppColors.colorWhite,
                                    callback: () {
                                      provider.removeCard(
                                          provider.getCard[type].id, context);
                                      print("jjj");
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ButtonWidget(
                                    width: 100,
                                    height: 40,
                                    msg: "No",
                                    fontColor: AppColors.colorWhite,
                                    callback: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                height: 10,
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
      );
    });
  }
}
