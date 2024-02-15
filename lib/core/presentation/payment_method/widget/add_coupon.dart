import 'package:deride_user/core/presentation/payment_method/widget/add_new_card_view.dart';
import 'package:deride_user/core/presentation/payment_method/widget/payment_card_common_layout.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/core/presentation/payment_method/widget/add_payment_card.dart';
import 'package:deride_user/utils/widget/bottom_sheet_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/payment_method_provider.dart';
import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/fonts.dart';

class AddCouponWidget extends StatelessWidget {
  Widget? imageName;
  int? type;
  String? msg;

  AddCouponWidget({Key? key, this.imageName, this.type, this.msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<PaymentMethodProvider>(builder: (context, provider, _) {
      if(provider.getCard.isEmpty){
        provider.fectchCard();
        return const CircularProgressIndicator();}
      return provider.radioButtonValue == 0 && type == 0
          ? Wrap(
              children: [
                Container(
                  width: context.screenWidth,
                  decoration: BoxDecoration(
                      color: AppColors.colorEDF3ED,
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    children: [
                      Container(
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
                          child: PaymentCardCommonLayout(
                            msg: msg!,
                            radioButton: Transform.scale(
                              scale: 1.5,
                              child: Radio(
                                  activeColor: AppColors.color080809,
                                  value: type,
                                  groupValue: provider.radioButtonValue,
                                  onChanged: (v) {
                                    print("11111112525295222562252");
                                   provider.changeRadioValue(v!,context);
                                  }),
                            ),
                            imageName: imageName,
                          )),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.getCard.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = provider.getCard[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 8, right: 8),
                            child: InkWell(
                              onTap: (){
                                provider.updatedSelectedCard(card: item);},
                              child: AddPaymentCard(
                                msg: item.cardNumber,
                                imageName: AppImagesPath.masterCardLogoSub.svg,
                                type: index,),
                            ),
                          );
                        },
                      ),
                    
                    ],
                  ),
                ),
              ],
            )
          : Container(
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
              child: PaymentCardCommonLayout(
                msg: msg!,
                radioButton: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                      activeColor: AppColors.color153B0E,
                      value: type,
                      groupValue: provider.radioButtonValue,
                      onChanged: (v) {
                        print("jsjs");
                        provider.changeRadioValue(v!,context);
                      }),
                ),
                imageName: imageName,
              ));
    });
  }
}
