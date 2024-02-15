// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:deride_user/core/presentation/authentication/forgot_pass/view/otp_verification_view.dart';
import 'package:deride_user/core/presentation/home/widget/location_from_map.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/receipt/provider/receipt_screen_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:deride_user/utils/widget/toast_widget.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:deride_user/core/presentation/home/models/car_category_model.dart';
import 'package:deride_user/core/presentation/home/models/vechile_price_category.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/request/repository/request_pepo.dart';
import 'package:deride_user/core/presentation/request/view/driver_accept_request_view.dart';
import 'package:deride_user/utils/extensions/validation_extension.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../model/direct_model_data.dart';
import '../../../../network/basic/common_network.dart';
import '../../../../utils/fonts.dart';
import '../models/google_route_distance.dart';

class HomeViewProvider extends ChangeNotifier {
  List<CarCategoryModel> carList = <CarCategoryModel>[];
  CarCategoryModel? selectedCar;
  bool isAnotherStep = false;
  bool isLoadingWeb = true;
  WebViewController? controller;

  clearController() {
    Dev.log("clearController=================HomeViewProvider");
    pickUpText.clear();
    dropText.clear();
    notifyListeners();
   final locationProvider= locator<LocationProvider>();
    locationProvider.clear();
  }

  launchPhone({String? number}) async {
    // String telephoneNumber = '+2347012345678';
    String telephoneUrl = "tel:$number";
    if (await canLaunchUrl(Uri.parse(telephoneUrl))) {
      await launchUrl(Uri.parse(telephoneUrl));
    } else {
      throw "Error occured trying to call that number.";
    }
  }

  void getWebViewData(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {},
      );
    loadData(url);
  }

  loadData(data) async {
    await controller!.loadRequest(Uri.parse(data));

    Future.delayed(const Duration(seconds: 3), () {
      isLoadingWeb = false;
      notifyListeners();
    });
  }

  changeAnotherStep(value) {
    isAnotherStep = value;
    notifyListeners();
  }

  void onCarSelect(CarCategoryModel selectedCarValue) {
    selectedCar = selectedCarValue;
    notifyListeners();
  }

  // <-------------- Navigate after the request accept by driver------------> //
  // navigateAfterLoading(BuildContext context, {int step = 1}) async {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     if (step == 1) {
  //       Timer(const Duration(seconds: 3), () async {
  //         Navigator.pushNamed(
  //           context,
  //           DriverRequestAcceptView.routeName,
  //         );
  //       });
  //     } else {
  //       Timer(const Duration(seconds: 5), () async {
  //         if (isAnotherStep) {
  //           Dev.log("------> no navigte");
  //         } else {
  //           Dev.log("------> navigte");
  //           Navigator.pushNamed(
  //             context,
  //             CarReceiptScreen.routeName,
  //           );
  //           notifyListeners();
  //         }
  //       });
  //     }
  //   });
  // }

  // <------------------  METHOD TO GET THE SEARCH LOCATION -------------> //
  getSearchLocation(context, Predictions? predictions) async {
    try{
      dev.log("predictions are:-->> ${predictions!.description!}");
      if (isPickupPlacesList!) {
        pickUpAddress = predictions.description!;
        pickUpText.text = pickUpAddress;

        // var addresses =
        //     await Geocoder.local.findAddressesFromQuery(pickUpAddress);

        // dev.log("pick up address are :-->> ${addresses} ");
        List<Location> pickLocation =
            await locationFromAddress(predictions.description!);

        dev.log("new location is :-->> ${pickLocation[0].latitude}");

        // final addresses = await placemarkFromAddress('1600 Amphitheatre Parkway, Mountain View, CA');
        // var first = addresses.first;
        pickUpLatLng =
            LatLng(pickLocation[0].latitude, pickLocation[0].longitude);
        // print("${first.featureName} : ${first.coordinates}");
      } else {
        dropAddress = predictions.description!;
        // var addresses = await Geocoder.local.findAddressesFromQuery(dropAddress);
        List<Location> dropLocation =
            await locationFromAddress(predictions.description!);

        // dev.log("drop address are :-->> ${addresses} ");

        // var first = addresses.first;
        dropLatLng =
            LatLng(dropLocation[0].latitude, dropLocation[0].longitude);
        // print("${first.featureName} : ${first.coordinates}");
        dropText.text = dropAddress;
      }

      placeList.clear();
      notifyListeners();

      /* if (pickUpAddress != null && dropAddress != null) {
      Provider.of<LocationProvider>(context, listen: false)
          .getAddress(pickUpLatLng!.latitude,pickUpLatLng!.longitude,pickUpAddress);}*/

      Provider.of<LocationProvider>(context, listen: false)
          .onChangePickUpDropLocation(
        pickUpLocation: pickUpLatLng,
        dropUpLocation: dropLatLng,
        isRideStart: false,
      );
    }on PlatformException
        catch(e,t){
      Dev.log("getSearchLocation====>$e");
      Dev.log("getSearchLocation====>$t");
    }
  }

  String pickUpAddress = '';
  String dropAddress = '';
  LatLng? pickUpLatLng;
  LatLng? dropLatLng;
  TextEditingController pickUpText = TextEditingController();
  TextEditingController dropText = TextEditingController();
  double? distance;
  bool? isDataLoading = true;

  updatePickUpText(value, latlong) {
    pickUpText.text = value;
    pickUpLatLng = latlong;
    notifyListeners();
  }



  Future<void> updateStartEndController() async {
    pickUpText.text = '';
    dropText.text = '';
    notifyListeners();
  }

  List<Predictions> placeList = [];
  bool? isPickupPlacesList;
  int estimatedTime = 0;
  String? newTime;

  DateTime currentTime = DateTime.now();

  void getLocationResults(String input, bool? isPickupPlaces) async {
    isPickupPlacesList = isPickupPlaces;
    var response = await ApiService().callGetApiThirdParty(input: input);
    if (response.statusCode == 200) {
      placeList.clear();
      SearchLocationData searchLocationData =
          SearchLocationData.fromJson(jsonDecode(response.body));

      placeList.addAll(searchLocationData.predictions!);

      notifyListeners();
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future<void> estimateTime() async {
    try {
      var response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=${dropLatLng?.latitude},${dropLatLng?.longitude}&origins=${pickUpLatLng?.latitude},${pickUpLatLng?.longitude}&key=AIzaSyDiKTQ48lMBMLemXjAbEPbw8GwaVzPoNyo'));

      var data =
          GoogleRouteDistanceResponseModal.fromJson(jsonDecode(response.body));
      estimatedTime = data.rows[0].elements[0].duration.value;

      newTime = (estimatedTime / 60).toStringAsFixed(1);
      print("estimateTime===>$newTime");

      notifyListeners();
    } catch (e) {
      print("$e");
    }
  }

  ///  // <--------- Calculate distance ---------> //
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    Dev.log("_______> Distance ${12742 * asin(sqrt(a))}");

    distance = 12742 * asin(sqrt(a));
    notifyListeners();
    return distance!;
  }

  /// <--------- Validate fields -----------> //

  validateFeild() {
    if (pickUpText.text.trim().isEmpty) {
      return "Please Enter Pickup Address";
    } else if (dropText.text.trim().isEmpty) {
      return 'Please Enter Drop Address';
    } else {
      return '';
    }
  }

  // <--------- onTap -------------> //

  onTap(BuildContext context) async {
    if (validateFeild() == "") {
      ProgressDialog.showProgressDialog(context);

      calculateDistance(pickUpLatLng?.latitude, pickUpLatLng?.longitude,
          dropLatLng?.latitude, dropLatLng?.longitude);
      await estimateTime();
      await getVechileCatData();
      if (vechileCatPrice?.data.first.is_pending == "1") {
        // showToast(message: "fasfjasja");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: LottieBuilder.asset(
                    "assets/animation/payment.json",
                    height: 200,
                    width: 200,
                  ),
                  content: SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        TextWidget(
                          msg: 'Please Pay ,',
                          color: AppColors.color001E00,
                          textSize: 18,
                          fontWeight: FontMixin.fontWeightMedium,
                          font: FontMixin.mediumFamily,
                        ),
                        TextWidget(
                          msg: r"The Outstanding Amount of CAD $ " +
                              vechileCatPrice?.data.first.pending_amount,
                          color: AppColors.color001E00,
                          textSize: 14,
                          fontWeight: FontMixin.fontWeightMedium,
                          font: FontMixin.mediumFamily,
                        ),
                        TextWidget(
                          msg: r"To Book the next Ride !!",
                          color: AppColors.color001E00,
                          textSize: 14,
                          fontWeight: FontMixin.fontWeightMedium,
                          font: FontMixin.mediumFamily,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        dotedDevider(context),
                        context.sizeH(0.5),
                        applePayButton(context),
                        context.sizeH(0.5),
                        dotedDevider(context),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ButtonWidget(
                          msg: "Pay",
                          fontColor: AppColors.colorWhite,
                          callback: () {
                            //       navigatorKey.currentState!.push(MaterialPageRoute(
                            // builder: ((context) => CarReceiptScreen(
                            //       orderrId: orderrId,
                            //     ))));
                            if (Provider.of<PaymentMethodProvider>(context,
                                        listen: false)
                                    .radioButtonValue ==
                                null) {
                              context.showAnimatedToast('Select Payment Mode');
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CarReceiptScreen(
                                            orderrId: vechileCatPrice
                                                ?.data.first.OrderID,
                                             isPendingPayment: true,
                                          )));
                            }
                            //   Provider.of<ReceiptScrerenProvider>(context,listen: false).getReceiptDetail(context,
                            //  //  "246"
                            //  vechileCatPrice?.data.first.OrderID
                            //  )
                          },
                        )
                      ],
                    ),
                  ));
            });
        return;
      }
      if (vechileCatPrice != null) {
        Navigator.pop(context);

        ModalBottomSheet.moreModalBottomSheet(
          context,
          const ChooseRideView(),
          isExpendable: false,
          topBorderRadius: 0,
          padding: EdgeInsets.zero,
        );
      }
    } else {
      context.showAnimatedToast(validateFeild().toString());
    }
  }

  int selectedIndex = 0;
  VechileCatPrice? vechileCatPrice;

  // <--------- Set Selected Index --------->  //

  setSelectedIndex(value) {
    selectedIndex = value;
    notifyListeners();
  }

  // <-------------- Function to get the data of vechile price cat -------------->  //
  getVechileCatData() async {
    var data = await RequestRepo.getVechilePriceCat({
      "distance": distance.toString(),
      "night_service": "0",
      "coordinates":
          //"30.704628,76.6843953",
          "${pickUpLatLng!.latitude}, ${pickUpLatLng!.longitude}",
      "time":
          //"12.5"
          newTime.toString(),
    });
    if (data != null) {
      vechileCatPrice = VechileCatPrice.fromJson(data);
      isDataLoading = false;

      notifyListeners();
    }
    Dev.log('data   ---> $data');
  }

  void updateLocationFromMap(
      {dynamic value,
      required BuildContext context,
      required AddressType type}) {
    if (type == AddressType.origin) {
      pickUpAddress = value['pickUpName'];
      pickUpText.text = value['pickUpName'];

      pickUpLatLng = LatLng(value['pickUpCoordinate'].latitude,
          value['pickUpCoordinate'].longitude);
      // print("${first.featureName} : ${first.coordinates}");
    } else {
      dropAddress = value['pickUpName'];

      dropLatLng = LatLng(value['pickUpCoordinate'].latitude,
          value['pickUpCoordinate'].longitude);

      dropText.text = value['pickUpName'];
    }

    placeList.clear();
    notifyListeners();
    /* if (pickUpAddress != null && dropAddress != null) {
        Provider.of<LocationProvider>(context, listen: false)
            .getAddress(pickUpLatLng!.latitude,pickUpLatLng!.longitude,pickUpAddress);}*/

    Provider.of<LocationProvider>(context, listen: false)
        .onChangePickUpDropLocation(
      pickUpLocation: pickUpLatLng,
      dropUpLocation: dropLatLng,
      isRideStart: false,
    );
  }
}
