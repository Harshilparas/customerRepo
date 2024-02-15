import 'dart:developer';

import 'package:deride_user/core/presentation/home/models/Ride_In_Progress_model.dart';
import 'package:deride_user/core/presentation/home/models/driver_detail_model.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/repository/ride_in_Process_repo.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class RideInProgressProvider extends ChangeNotifier {
  RideInProgressModel? rideInProgressModel;
  bool loading = false;

  Future<bool> getRideDetail() async {
    var orderId = SharedPreferencesManager().getOrderId();
    try {
      loading = true;
      notifyListeners();
      final response = await RideInProgressRepo.receiptScreenRepo(orderId);
      loading = false;
      notifyListeners();
      final ctx=navigatorKey.currentState?.context;
      if (response['success'] == 1 && ctx!=null && (ctx.mounted??false)) {

        var rideModel = RideInProgressModel.fromJson(response);
        if(int.parse((rideModel.order?.orderStatus.toString()??"0"))>7){
          return false;
        }
        log("==========>>>>>> ride model : $rideModel");

       final socketProvider= Provider.of<SocketProvider>(ctx, listen: false);
        socketProvider .updateOrderStatusText(
                val: rideModel.order?.orderStatus.toString() ?? "0");

       final locationProvider= Provider.of<LocationProvider>(ctx, listen: false);
        locationProvider .updateBookingFlowOriginAndDestination(
                origin: LatLng(
                    double.parse(
                        rideModel.order!.startCoordinate!.split(',').first),
                    double.parse(
                        rideModel.order!.startCoordinate!.split(',').last)),
                destination: LatLng(
                    double.parse(
                        rideModel.order!.endCoordinate!.split(',').first),
                    double.parse(
                        rideModel.order!.endCoordinate!.split(',').last)))
            .then((value) {
          // log("respon of api====== ==>$response");
          // socketProvider.driverUpdateLatLng = UpdateLatLngResponseModels.fromJson(response);

          socketProvider.driverLatLng =
              LatLng(double.tryParse(rideModel.driverDetails?.latitude.toString()??"0.0")??0, double.tryParse(rideModel.driverDetails?.longitude.toString()??"0.0")??0);
          locationProvider.updateDriverCoordinates(socketProvider.driverLatLng);
          locationProvider.updateBookingFlowDriverCoordinates(Marker(
            infoWindow: const InfoWindow(title: "driver"),
            icon: BitmapDescriptor.defaultMarker,
            markerId: const MarkerId("DRIVER"),
            position: socketProvider.driverLatLng,
          ));
          locationProvider.updatePolylineWithSocket();
           Provider.of<SocketProvider>(navigatorKey.currentState!.context,
                listen: false).updateDriverDetailsModel(val: DriverDetailModel(data:Data() ));

          rideInProgressModel = RideInProgressModel.fromJson(response);
          notifyListeners();
        });
        return true;
      }
return false;
      // );
    } on Exception catch (e) {
      rideInProgressModel = null;
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
