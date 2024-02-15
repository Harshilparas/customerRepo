part of '../view/home_view.dart';

class ChooseRideView extends StatefulWidget {
  const ChooseRideView({super.key});

  @override
  State<ChooseRideView> createState() => _ChooseRideViewState();
}

class _ChooseRideViewState extends State<ChooseRideView> {
  //  late final WebViewController controller;
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
  

    return Consumer<HomeViewProvider>(builder: (context, pro, _) {
      return pro.isDataLoading!
          ? const CircularProgressIndicator()
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context.sizeH(2),
                Align(

                  alignment: Alignment.center,
                  child: SvgPicture.asset(AppImagesPath.downArrow),
                ),

                /// car list
                Consumer<HomeViewProvider>(
                  builder: (context, homeViewProvider, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeViewProvider.vechileCatPrice?.data.length,
                      itemBuilder: (context, index) {
                        // final data = homeViewProvider.carList[index];
                        return GestureDetector(
                          onTap: () {
                            // homeViewProvider
                            //     .vechileCatPrice!.data[index].isSelected = true;
                            homeViewProvider.setSelectedIndex(index);
                            homeViewProvider.notifyListeners();
                          },
                          child: carWidget(
                            carData: homeViewProvider.vechileCatPrice!.data[index],
                            context: context,
                            isSelected: homeViewProvider.selectedIndex == index,
                          ),
                        );
                      },
                    );
                  },
                ),
                dotedDevider(context),
                context.sizeH(0.5),
                     applePayButton(context),
                context.sizeH(0.5),
                dotedDevider(context),
                context.sizeH(2),

                /// book now button
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: ButtonWidget(
                    msg: AppStrings.bookNow,
                    fontColor: AppColors.colorWhite,
                    callback: () {
                    
                       context.read<RequestProvider>().bookNowRide(context);
                    },
                  ),
                ),
                context.sizeH(2)
              ],
            );
    });
  }

  Widget carWidget({
    required VechilePrice carData,
    required BuildContext context,
    required bool isSelected,
  }) {
    return Container(
      color: isSelected
          ? AppColors.color63BA6B1A.withOpacity(0.17)
          : Colors.transparent,
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
         carData.image==null?const Text("null") :Image.network(
            carData.image??"",
            height: 40,
            width: 50,
          ),
          context.sizeW(2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                msg: "${carData.category} (${carData.seat} Person)",
                font: FontMixin.regularFamily,
                fontWeight: FontMixin.fontWeightRegular,
                textSize: 16,
              ),
              TextWidget(
                msg: "${carData.time} min",
                font: FontMixin.regularFamily,
                fontWeight: FontMixin.fontWeightRegular,
                textSize: 14,
                color: isSelected
                    ? const Color(0xFF242E42)
                    : AppColors.colorB9B8BA,
              ),
            ],
          ),
          const Spacer(),
          TextWidget(
            msg:
                "CA\$ ${(carData.priceKm * Provider.of<HomeViewProvider>(context, listen: false).distance!).toStringAsFixed(2)}",
                  
            font: FontMixin.regularFamily,
            fontWeight: FontMixin.fontWeightBold,
            textSize: 16,
          ),
        ],
      ),
    );
  }

// <----------  Apple pay button ------> //

  
//     Future<void> stripeMakePayment() async {
//     try {
//       paymentIntentData = await createPaymentIntent('100', 'INR');
//       await Stripe.instance
//           .initPaymentSheet(
        
//               paymentSheetParameters: const SetupPaymentSheetParameters(
//                paymentIntentClientSecret:"fcsess_client_secret_9E9g0xy1kRhUjiGaSQgYJf6n",
//                // SharedPreferencesManager().setupintent.toString(),
//                 customerId: "cus_POhxrdU5zkPXls",
//                 //SharedPreferencesManager().stripecustomerid.toString(),
//                 customerEphemeralKeySecret: "ek_test_YWNjdF8xT0dDdFBHcWZZSVZBQWtJLGZlanhoYTNqZFNsa01UaVZtNXpiS0FQU0pBa1dtMUE_006hK7c9Gw",
//                 // SharedPreferencesManager().ephemeraKey.toString(),
                
              
//                   // billingDetails: const BillingDetails(
//                   //     name: 'YOUR NAME',
//                   //     email: 'YOUREMAIL@gmail.com',
//                   //     phone: 'YOUR NUMBER',
//                   //     address: Address(
//                   //         city: 'YOUR CITY',
//                   //         country: 'YOUR COUNTRY',
//                   //         line1: 'YOUR ADDRESS 1',
//                   //         line2: 'YOUR ADDRESS 2',
//                   //         postalCode: 'YOUR PINCODE',
//                   //         state: 'YOUR STATE')),
//                   // paymentIntentClientSecret: paymentIntentData![
//                   //     'client_secret'], //Gotten from payment intent
//                   // style: ThemeMode.dark,
//                   merchantDisplayName: 'Ikay')
//                   )
//           .then((value) {});

//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//     } catch (e) {
//       log("============1st========>${e.toString()}");
//       Fluttertoast.showToast(msg: e.toString());
//       log("===============2nd=====>${e.toString()}");
//     }
//   }

//   displayPaymentSheet() async {
//     try {
//       // 3. display the payment sheet.
//       await Stripe.instance.presentPaymentSheet();

//       Fluttertoast.showToast(msg: 'Payment succesfully completed');
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         Fluttertoast.showToast(
         
//             msg: 'Error from Stripe: ${e.error.localizedMessage}');
//              log("============1st========>${e.toString()}");
//       } else {
//         log("===============2nd=====>${e.toString()}");
//         Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
//       }
//     }
//   }

// //create Payment
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

// //calculate Amount
//   calculateAmount(String amount) {
//     final calculatedAmount = (int.parse(amount)) * 100;
//     return calculatedAmount.toString();
//   }

}

dotedDevider(BuildContext context) {
  return   SizedBox(
    height: 5,
    child: CustomPaint(
        painter: DashedLineHorizontalPainter(),
        size: const Size(10000000, double.infinity)),
  );
}
Widget applePayButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: InkWell(
      onTap: () async {
    //     if (Provider.of<PaymentMethodProvider>(context, listen: false)
    //         .radioButtonValue == null) {
    //   context.showAnimatedToast('Select Payment Mode');
    // } else {
        Provider.of<PaymentMethodProvider>(context, listen: false).addCoupon(context);
       Navigator.pushNamed(context, SelectPaymentMethodView.routeName);
    // }
      
      },
      child: Row(
        children: [

          context.sizeW(3),
          SvgPicture.asset(AppImagesPath.masterCardIcon),
          TextWidget(
            msg: Provider.of<PaymentMethodProvider>(context).selectCreditCard,
            font: FontMixin.regularFamily,
            fontWeight: FontMixin.fontWeightBold,
            textSize: 18,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Colors.grey,
          ),
        ],
      ),
    ),
  );
}