import 'dart:developer';
import 'package:deride_user/core/presentation/home/models/vechile_price_category.dart';
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/provider/place_picker_provider.dart';
import 'package:deride_user/core/presentation/home/provider/ride_in_Progress_provider.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/request/provider/request_provider.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/core/presentation/request/view/driver_accept_request_view.dart';
import 'package:deride_user/core/presentation/setting/view/setting_view.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/bottom_sheet_widget.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/dash_separetor.dart';
import 'package:deride_user/utils/widget/repeating_linear_progress_indicator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../utils/mixin/dev.mixin.dart';
import '../../payment_method/view/select_payment_method_view.dart';
import '../widget/location_from_map.dart';

part '../widget/home_top_view_widget.dart';

part '../widget/choose_ride_view.dart';

part '../widget/request_ride_view.dart';

part '../widget/cancel_ride_pop_up.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{
  var locationProvider = locator<LocationProvider>();
  var socketProvider = locator<SocketProvider>();
  var rideInProgressProvider = locator<RideInProgressProvider>();


  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);

    log("======================>jdjfdsjfdsfbdsf==========>");
    //  Provider.of<RideInProgressProvider>(context, listen: false).getRideDetail();
    if (locationProvider.locationData == null ||
        locationProvider.currentLatLng == null) {
      locationProvider.getUserCurrentLocation(context);
    }
    var orderId = SharedPreferencesManager().getOrderId();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      socketProvider.connectToSocket(context);

      log("orderId check : $orderId");

      if (orderId != "") {
        log("order id type ${orderId.runtimeType}");
        log("oder  cehk id=========> $orderId");
        checkPrviousOrderDetailsIfRunning(orderId);
      } else {
        log("oder id=========> ${orderId.toString()}");
      }
    });
  }

  checkPrviousOrderDetailsIfRunning(String orderId) {
    if ((orderId != "")) {
      rideInProgressProvider.getRideDetail().then((value) {
        if (value) {
          //  navigatorKey.currentState!.push(MaterialPageRoute(
          //   builder: ((context) => CarReceiptScreen(
          //         orderrId: SharedPreferencesManager().oderid,
          //       ))));
          Dev.log(
              "rideInProgressProvider.rideInProgressModel?.order?.orderStatus>>>${rideInProgressProvider.rideInProgressModel?.order?.orderStatus}");
          if (rideInProgressProvider.rideInProgressModel?.order?.orderStatus
                  .toString() ==
              "7") {
            SharedPreferencesManager().removeOrderID();
            locationProvider.updateIsWithDriver(value: false);
            socketProvider.driverLatLng = const LatLng(0, 0);
            locationProvider
                .updateDriverCoordinates(socketProvider.driverLatLng);
            locationProvider.notifyListeners();
            socketProvider.notifyListeners();
            navigatorKey.currentState!.push(MaterialPageRoute(
                builder: ((context) => const CarReceiptScreen(
                      orderrId: null,
                    ))));
          } else {
            Navigator.pushAndRemoveUntil(
                navigatorKey.currentContext!,
                MaterialPageRoute(
                    builder: (context) => const DriverRequestAcceptView()),
                (route) => false);
          }
        } else {
          Provider.of<SharedPreferencesManager>(context, listen: false)
              .setorderId("");
        }
      });
    }
  }

//Todo:  Implements camera position
  CameraPosition? _cameraPosition;

  // Todo: Implements marker icon
  BitmapDescriptor? pinLocationIcon;

  // Todo: latLong variable
  LatLng? _latLng;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Consumer2<LocationProvider, HomeViewProvider>(
            builder: (context, provider, homeViewProvider, _) {
          return Stack(
            children: [
              GoogleMap(
                polylines: provider.polyline ?? {},
                markers: provider.markerList ?? {},
                mapType: MapType.terrain,
                initialCameraPosition: provider.cameraPosition ??
                    CameraPosition(
                        target: LatLng(
                          provider.locationData?.latitude ?? 0,
                          provider.locationData?.longitude ?? 0,
                        ),
                        zoom: 14.0),
                onMapCreated: (GoogleMapController controller) {
                  provider.updateMapController(controller);
                },
                buildingsEnabled: false,
                compassEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onTap: (argument) {
                  print(">>>>>>>>>$argument");
                },
                // Todo : On camera move
                onCameraMove: (CameraPosition cameraPosition) {
                  //  setState(() {
                  _cameraPosition = cameraPosition;
                  _latLng = LatLng(_cameraPosition!.target.latitude,
                      _cameraPosition!.target.longitude);

                  print("_latLng ======> $_latLng");
                  setState(() {});
                  //  });
                },
              ),
              const Positioned(top: 0, child: HomeTopViewWidget()),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Consumer<HomeViewProvider>(
                      builder: (context, homeViewProvider, child) {
                    return ButtonWidget(
                      msg: AppStrings.confirm,
                      fontColor: AppColors.colorWhite,
                      callback: () {

                        HomeViewProvider homeViewProvider =
                            Provider.of<HomeViewProvider>(context,
                                listen: false);

                        homeViewProvider.onTap(context);


                      },
                    );
                  }),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
