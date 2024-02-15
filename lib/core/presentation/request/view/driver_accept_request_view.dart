// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:deride_user/core/presentation/home/models/driver_detail_model.dart';
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/provider/ride_in_Progress_provider.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/core/presentation/request/widget/request_accept_bottom_view.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../utils/widget/bottom_sheet_widget.dart';
import '../../home/view/home_view.dart';

class DriverRequestAcceptView extends StatefulWidget {
  const DriverRequestAcceptView({super.key});
  static const routeName = '/requestAccept';

  @override
  State<DriverRequestAcceptView> createState() =>
      _DriverRequestAcceptViewState();
}

class _DriverRequestAcceptViewState extends State<DriverRequestAcceptView> {
//Todo:  Implements camera position
  static CameraPosition? _cameraPosition;
  // static CameraPosition? _bookingFlowcameraPosition;

  // Todo: Implements marker icon
  BitmapDescriptor? pinLocationIcon;

  // Todo: latLong variable
  LatLng? _latLng;

  var locationProvider = locator<LocationProvider>();
  var socketProvider = locator<SocketProvider>();
  var rideInProgressProvider = locator<RideInProgressProvider>();



  @override
  void initState() {
    locationProvider.markerList?.clear();
    locationProvider.polyline?.clear();
      // rimediffernce();

    // locationProvider.updateBookingFlowCoordinates();

    // locationProvider.getUserCurrentLocation(context);

    // locationProvider.getUserCurrentLocation(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  Provider.of<HomeViewProvider>(context, listen: false)
        .navigateAfterLoading(context, step: 2);*/
Dev.log("SharedPreferencesManager().oderid>>.${SharedPreferencesManager().getOrderId()}");
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: Consumer<SocketProvider>(builder: (context, socket, _) {
        return Consumer<LocationProvider>(builder: (context, provider, _) {
          return provider.locationData == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(children: [

                if(provider.bookingFlowOriginLatLng!=null)
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        GoogleMap(
                          polylines: provider.bookignFlowPolyline ?? {},
                          markers: provider.bookingFlowMarkerList ?? {},
                          mapType: MapType.normal,
                          initialCameraPosition: provider
                                  .bookingFlowCameraPosition ??
                              CameraPosition(
                                  target: LatLng(
                                    provider.bookingFlowOriginLatLng!.latitude,
                                    provider.bookingFlowOriginLatLng!.longitude,
                                  ),
                                  zoom: 18.0),
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
                            setState(() {});
                            //  });
                          },
                        ),
                        /*   Padding(
                            padding: EdgeInsets.only(
                                top: context.screenHeight * 0.06,
                                left: context.screenHeight * 0.02),
                            child: ToolBarWidget(tittle: ""),
                          )*/
                      ],
                    ),
                  ),
                  Expanded(child: HomeBookingAcceptBottomView()),
                ]);
        });
      })),
    );
  }
}
