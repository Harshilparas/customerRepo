import 'dart:developer';

import 'package:deride_user/core/presentation/home/widget/payment_screen.dart';
import 'package:deride_user/core/presentation/payment_method/model/card_model.dart';
import 'package:deride_user/core/presentation/payment_method/model/coupon_model.dart';
import 'package:deride_user/core/presentation/payment_method/repository/payment_repo.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/widget/web_view_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/app_constant/app_image_strings.dart';

class PaymentMethodProvider extends ChangeNotifier {
//  Controller
  final TextEditingController applyCouponController = TextEditingController();
  TextEditingController holderName = TextEditingController();
  TextEditingController cardNos = TextEditingController();
  TextEditingController cvc = TextEditingController();
  TextEditingController expiryDate = TextEditingController();

  CardModel? cardModel;
  List<CardDetail> getCard = [];
  dynamic selectCardId;
  String selectedCardNos = '';
  String selectedExpiryDate = '';
  var cardId = "";
  var selectedCardname = "";
  Coupons? selectedCoupon;
  bool isCard = true;

  updateCardname({required Coupons val}) {
    selectedCardname = val.code??"";
    applyCouponController.text = val.code??"";
    selectedCoupon=val;
    SharedPreferencesManager().saveCoupons(val);
    notifyListeners();
  }

  updatedSelectedCard({ required CardDetail card}) {
    selectedCardNos = card.cardNumber??"";
    selectedExpiryDate=card.expiryDate??"";
    selectCardId=card.id;
    SharedPreferencesManager().saveCardDetail(card);
    notifyListeners();
  }

  // updatedSelectedCardId({cardId}) {
  //     selectCardId = cardId;
  //   notifyListeners();
  // }

  var paymentMethods = [
    AppStrings.debitandCreditCard,
    //   AppStrings.applePay,
    //  AppStrings.googlePay
  ];

  var couponMethod = [AppStrings.checkcupons];

  var couponMethodImg = [
    AppImagesPath.couponimg,
  ];
  var paymentMethodsImage = [
    AppImagesPath.masterCardLogoSub,
    //   AppImagesPath.applePayLogo,
    //   AppImagesPath.googlePayLogo
  ];

  int? radioButtonValue;
  int checkBoxValue = 0;
  bool isCardLoading = true;
  var selectCreditCard = "Select Credit Card";

  updateCreditCard(value) {
    selectCreditCard = value;

    notifyListeners();
  }

  CouponModel? couponModel;

  // method to change radio value
  void changeRadioValue(int value, BuildContext context) {
    radioButtonValue = value;
    print(radioButtonValue);
    if (value == 0) {
      Provider.of<PaymentMethodProvider>(context, listen: false)
          .updateCreditCard("DebitCard");
    }

    notifyListeners();
  }

// method to change checked value
  void changeInCheckBoxValue(int value) {
    checkBoxValue = value;
    notifyListeners();
  }

  // <----------- MASK CARD -----------> //
  maskCard(String inputText) {
    var bufferString = StringBuffer();
    for (int i = 8; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 2 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }
    return "... ... ... $bufferString";
  }

  void fectchCard() async {
    final response = await PaymentRepo.getCard();
    if (response['success'] == 1) {
      //    isCardLoading=false;
      cardModel = CardModel.fromJson(response);
      isCard = false;
      getCard.clear();
      getCard.addAll(cardModel?.data ?? []);
      notifyListeners();
    } else if (response['success'] == 0) {
      cardModel = null;
      isCard = false;
      getCard.clear();
      notifyListeners();
    } else {
      //   navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) =>  SelectPaymentMethodView())));
      cardModel = null;
      getCard.clear();
      notifyListeners();
    }
  }

  void addCard(BuildContext context) async {
  /*   String url = "https://pub.dev/";
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewCommonWidget(url: url)),
    );
    return;*/
    final response = await AddCardRepo.addCard(context);
    if (response['success'] == 1 && response["SessionUrl"] != null) {
      log('$response');
      // String url = "https://pub.dev/";
      String url = response["SessionUrl"];
      var res = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewCommonWidget(url: url)),
      );


      if (res) {
        fectchCard();
      }

      //response["SessionUrl"]
      //   _launchUrl(response["SessionUrl"]);
      fectchCard();
      notifyListeners();
    } else if (['success'] == 0) {
      Navigator.pop(context);
      context.showAnimatedToast(response['message']);
      notifyListeners();
    } else {
      context.showAnimatedToast(response['message']);
    }
  }

  clearAddCardDetail() {
    holderName.text = "";
    cardNos.text = "";
    cvc.text = "";
    expiryDate.text = "";
  }

  void removeCard(cardId, BuildContext context) async {
    final response = await RemoveCardRepo.removeCard(
      context,
      cardId,
    );
    if (response['success'] == 1) {
      print("$response");
      fectchCard();
      Navigator.pop(context);
      context.showAnimatedToast(response['message']);
      notifyListeners();
    } else {
      context.showAnimatedToast(response['message']);
    }
  }

  // int coupomSelected = 0;
  // bool couponSele = false;
  //
  // var couponId;
  //
  // updatedCoupon(id) {
  //   couponId = id;
  //   //  coupomSelected = index;
  //   couponSele = !couponSele;
  //   notifyListeners();
  // }

  List<Coupons> getCoupon = [];

  void  addCoupon(BuildContext context) async {
    final response = await AddCouponRepo.addCoupon(context);
    if (response!=null && response['success'] == 1) {
      getCoupon.clear();
      couponModel = CouponModel.fromJson(response);
      getCoupon.addAll(couponModel?.coupons ?? []);
      notifyListeners();
    }
  }

/*  Future<void> _launchUrl(String url) async {
    var myUrl = Uri.parse(url);
    if(await canLaunchUrl(myUrl)){
    launchUrl(myUrl, mode: LaunchMode.externalNonBrowserApplication,);

    }else{
      print("object");
    }

}*/
}
