import 'dart:developer';

import 'package:deride_user/core/presentation/home/widget/payment_screen.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/payment_method/widget/apply_coupon_widget.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/core/presentation/payment_method/widget/payment_card_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/bottom_sheet_widget.dart';
import '../../../../utils/widget/button_widget.dart';
import '../../../../utils/widget/text_widget.dart';
import '../widget/add_new_card_view.dart';

class SelectPaymentMethodView extends StatefulWidget {
  const SelectPaymentMethodView({
    super.key,
  });

  static const routeName = '/selectPayment';

  @override
  State<SelectPaymentMethodView> createState() =>
      _SelectPaymentMethodViewState();
}

class _SelectPaymentMethodViewState extends State<SelectPaymentMethodView> {
  @override
  void initState() {
    if (Provider.of<PaymentMethodProvider>(context, listen: false)
        .getCard
        .isEmpty) {
      Provider.of<PaymentMethodProvider>(context, listen: false).fectchCard();
    }
    //   Provider.of<PaymentMethodProvider>(context,listen: false).fectchCard();

    // TODO: implement initState
    super.initState();
  }

  // final Uri _url = Uri.parse(SharedPreferencesManager().setupintent.toString());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (v) {
        setValue(context);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<PaymentMethodProvider>(
                  builder: (context, provider, _) {
                /*  if(provider.getCard.isEmpty){
                      provider.fectchCard();
                      return const CircularProgressIndicator();

                    }*/
                return Column(
                  children: [
                    ToolBarWidget(
                      tittle: AppStrings.paymentMethod,
                      back: () {
                        setValue(context);
                        Navigator.pop(context);
                      },
                    ),
                    context.sizeH(2),
                    provider.isCard
                        ? const CircularProgressIndicator()
                        : provider.getCard.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 24),
                                child: InkWell(
                                  onTap: () {
                                    log("====>dfdf");
                                    provider.addCard(context);
                                    //        Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const PaymentView(),
                                    //   ),
                                    // );
                                    //  ModalBottomSheet.moreModalBottomSheet(
                                    //    context,
                                    //    const AddNewCardView(),
                                    //    isExpendable: true,
                                    //    maxHeight:MediaQuery.of(context).size.height * 0.65,
                                    //    // isScrollControlled:false,
                                    //    // topBorderRadius: 0,
                                    //    padding: EdgeInsets.zero,
                                    //  );
                                  },
                                  child: TextWidget(
                                    msg: "+ ${AppStrings.addNewCard}",
                                    fontWeight: FontMixin.fontWeightMedium,
                                    textSize: 16,
                                    color: AppColors.color001E00,
                                    font: FontMixin.mediumFamily,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.paymentMethods.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PaymentCardWidget(
                                    msg: provider.paymentMethods[index],
                                    imageName:
                                        provider.paymentMethodsImage[index].svg,
                                    type: index,
                                  );
                                },
                              ),
                    context.sizeH(4.7),
                    ApplyCouponWidget(
                      controller: provider.applyCouponController,
                    ),
                    context.sizeH(4.7),
                    ButtonWidget(
                        msg: 'Confirm',
                        fontColor: AppColors.colorWhite,
                        callback: () {
                          //  Navigator.pushNamed(context, ReceiptScreen.routeName);
                          setValue(context);
                          Navigator.pop(context);
                        }),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _launchUrl() async {
  //   if (await canLaunchUrl(_url)) {
  //     launchUrl(
  //       _url,
  //       mode: LaunchMode.externalNonBrowserApplication,
  //     );
  //   } else {
  //     print("object");
  //   }
  // }

  void setValue(BuildContext context) {
    final provider = Provider.of<PaymentMethodProvider>(context,listen: false);
    if(provider.radioButtonValue!=null) {
      // provider.updatedSelectedCardId(
      //     cardId: provider.getCard[provider.checkBoxValue].id);
      provider.updatedSelectedCard(
          card: provider.getCard[provider.checkBoxValue]);
    }
  }
}
