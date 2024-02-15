import 'dart:math';

import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_feild_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class AddNewCardView extends StatelessWidget {
  const AddNewCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Consumer<PaymentMethodProvider>(
          builder: (context,provider,_) {
            return
            Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                context.sizeH(2.5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(

                        msg: AppStrings.addNewCard,
                        fontWeight: FontMixin.fontWeightBold,
                        font: FontMixin.mediumFamily,
                        textSize: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                context.sizeH(2.5),
                CommonTextfeild(
                  tittle: "Card Holder Name",
                  msg: "Enter card holder name",
                  color: Colors.black,
                  isEnable: true,
                  textSize: 15,
                  editController: provider.holderName,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  isDropDown: false,
                ),
                CommonTextfeild(
                  tittle: "Card number",
                  msg: "Enter card number",
                  color: Colors.black,
                  textSize: 15,
                  textInputType: TextInputType.number,
                  editController: provider.cardNos,
                  backImage: "",
                  isPassword: false,
                  obscureText: false,
                  isDropDown: false,
                ),
                CommonTextfeild(
                  tittle: "CVV",
                  msg: "Enter CVV number",
                  color: Colors.black,
                  textSize: 15,
                  length: 4,
                  textInputType: TextInputType.number,
                  editController: provider.cvc,
                  backImage: "",
                  isPassword: false,
                  obscureText: true,
                  isDropDown: false,
                ),
                InkWell(
                  onTap: ()async{
                    var picker =await showMonthYearPicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        initialMonthYearPickerMode: MonthYearPickerMode.year,
                        lastDate: DateTime(DateTime.now().year + 30));
                    if(picker!=null){
                      String formatter = DateFormat('MM/yy').format(picker);
                      print('${formatter}');
                      provider.expiryDate.text =formatter;
                    }
                  },
                  child: IgnorePointer(
                    child: CommonTextfeild(
                      tittle: "Expire Date",
                      msg: "MM/YY",
                      color: Colors.black,
                      textSize: 15,
                      length: 4,
                      textInputType: TextInputType.number,
                      editController: provider.expiryDate,
                      backImage: "",
                      isPassword: false,
                      obscureText: false,
                      isDropDown: false,
                    ),
                  ),
                ),

                /// Add button
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: ButtonWidget(
                    msg: AppStrings.add,
                    fontColor: AppColors.colorWhite,
                    callback: () {
                      if(provider.cardNos.text.trim()==''||provider.expiryDate.text.trim()==""){
                        context.showAnimatedToast('Please fill all fields');
                      }else if (provider.cardNos.text.length<14||provider.cardNos.length>18){
                      context.showAnimatedToast('Card length should between 14 to 18 digit');
                      }else if( provider.cvc.length<3||provider.cvc.length>4){
                        context.showAnimatedToast('CVV code length should between 3 to 4 digit');
                      }else{
                        provider.addCard(context);
                      }
                    //  Navigator.pop(context);
                    },
                  ),
                ),
                context.sizeH(2)
              ],
            );
          }
        ),
      ),
    );
  }
}
