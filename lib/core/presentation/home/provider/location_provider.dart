import 'dart:developer';
import 'dart:io';

import 'dart:ui' as ui;
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/mixin/dev.mixin.dart';
import '../../../../utils/widget/direction_helper.dart';

class LocationProvider extends ChangeNotifier {
  Position? locationData;
  LatLng? currentLatLng;
  String? address;

  LatLng? bookingFlowOriginLatLng;
  LatLng? bookingFlowDestinationLatLng;
  LatLng bookingFlowDriverLatLng = const LatLng(0, 0);

  bool isDriverAccept = false;
  bool isWithDriver = false;

  updateIsDriverAccept() {
    isDriverAccept = true;
    notifyListeners();
  }

 Future<void>   updateBookingFlowOriginAndDestination({required LatLng origin,required LatLng destination})async{
  bookingFlowOriginLatLng=origin;
   bookingFlowDestinationLatLng=destination;
  notifyListeners();
  }


  updateIsWithDriver({bool? value}) {
    isWithDriver = value??true;
    notifyListeners();
  }

  updateDriverCoordinates(LatLng val) {
    bookingFlowDriverLatLng = val;
    notifyListeners();
  }

  late Uint8List markerPinUser;
  late Uint8List destinationPin;
  late Uint8List carImage;

  initializeMarkerBitMap() async {
    markerPinUser = await getImageForMap(AppImagesPath.currentPinUser, 200);
    destinationPin = await getImageForMap(AppImagesPath.dropLocationGreen, 100);
    carImage = await getImageForMap(AppImagesPath.carMarker, 100);
    notifyListeners();
  }

  /// **********  UPDATE BOOKING FLOW COORDINATES ******** /////
  updateBookingFlowCoordinates(
      {required LatLng origin, required LatLng destination}) async {
    // final Uint8List markerPinUser =
    //     await getImageForMap(AppImagesPath.currentPinUser, 200);
    // final Uint8List destinationPin =
    //     await getImageForMap(AppImagesPath.dropLocationGreen, 100);
    // final Uint8List carImage =
    //     await getImageForMap(AppImagesPath.carMarker, 100);

    bookingFlowOriginLatLng = origin;
    bookingFlowDestinationLatLng = destination;
    notifyListeners();

    if (!isWithDriver) {
      // add origin marker
      bookingFlowMarkerList?.add(
        Marker(
          infoWindow: const InfoWindow(title: "driver position"),
          icon:
              BitmapDescriptor.fromBytes(carImage, size: const Size(100, 100)),
          markerId: const MarkerId("driver position"),
          position: bookingFlowDriverLatLng,
          anchor: const Offset(0.5, 0.5),
        ),
      );

      // add destination marker
      bookingFlowMarkerList?.add(
        Marker(
          infoWindow: const InfoWindow(title: "origin"),
          icon: BitmapDescriptor.fromBytes(
            markerPinUser,
            // size: const Size(5, 5)
          ),
          markerId: const MarkerId("origin"),
          position: bookingFlowOriginLatLng!,
          anchor: const Offset(0.5, 0.5),
        ),
      );

      await setBookingFlowPolylinesDirection(
          bookingFlowDriverLatLng, bookingFlowOriginLatLng??const LatLng(0,0));
    }
  }

  ///----------------------------- Track and update polyline with Socket------------------------///

  updatePolylineWithSocket() async {
    log("driver lat long is:${bookingFlowDriverLatLng.latitude},${bookingFlowDriverLatLng.longitude}");

    log("Update polyline called");


    // bookignFlowPolyline?.clear();
    bookingFlowMarkerList?.clear();

    // final Uint8List markerPinUser =
    //     await getImageForMap(AppImagesPath.currentPinUser, 200);
    // final Uint8List destinationPin =
    //     await getImageForMap(AppImagesPath.dropLocationGreen, 100);
    // final Uint8List carImage =
    //     await getImageForMap(AppImagesPath.carMarker, 100);

    /******************* CUSTOMER IS ------NOT------- WITH THE DRIVER **************/
    // add origin marker
    bookingFlowMarkerList?.add(
      Marker(
        infoWindow: const InfoWindow(title: "driver position"),
        icon: BitmapDescriptor.fromBytes(carImage, size: const Size(100, 100)),
        markerId: const MarkerId("driver position"),
        position: bookingFlowDriverLatLng,
        anchor: const Offset(0.5, 0.5),
      ),
    );

    if (!isWithDriver) {
      log("Not with the driver");

      // add destination marker
      bookingFlowMarkerList?.add(
        Marker(
          infoWindow: const InfoWindow(title: "origin"),
          icon: BitmapDescriptor.fromBytes(
            markerPinUser,
            // size: const Size(5, 5)
          ),
          markerId: const MarkerId("origin"),
          position: bookingFlowOriginLatLng!,
          anchor: const Offset(0.5, 0.5),
        ),
      );
      await setBookingFlowPolylinesDirection(
          bookingFlowDriverLatLng, bookingFlowOriginLatLng!);
    }

    /******************* CUSTOMER IS WITH THE DRIVER **************/
    else {
      log("Is with the driver");

      // add destination marker
      bookingFlowMarkerList?.add(
        Marker(
          infoWindow: const InfoWindow(title: "Destination"),
          icon: BitmapDescriptor.fromBytes(
            destinationPin,
            // size: const Size(5, 5)
          ),
          markerId: const MarkerId("Destination"),
          position: bookingFlowDestinationLatLng!,
          anchor: const Offset(0.5, 0.5),
        ),
      );

      await setBookingFlowPolylinesDirection(
          bookingFlowDriverLatLng, bookingFlowDestinationLatLng!);
    }
  }

  // setBookingFlowPolylineDirection()async{

  //     Dev.log("set polyline direction called");
  //   Dev.log("polyline :${origin.latitude}");
  //   Dev.log("polyline :${destination.latitude}");

  //   await DirectionHelper()
  //       .getRouteBetweenCoordinates(origin.latitude, origin.longitude,
  //           destination.latitude, destination.longitude)
  //       .then((result) {
  //     Dev.log(result.toString());
  //     if (result.isNotEmpty) {
  //       polylineCoordinates.clear();
  //       notifyListeners();
  //       for (var point in result) {
  //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //       }

  //       Polyline polylines = Polyline(
  //           polylineId: const PolylineId("jalur"),
  //           color: AppColors.color080809,
  //           points: polylineCoordinates,
  //           width: 6,
  //           startCap: Cap.roundCap,
  //           endCap: Cap.roundCap);
  //       polyline!.add(polylines);

  //       notifyListeners();
  //     }
  //   });

  // }

  UserRideLocationData? userRideLocationData = UserRideLocationData();

  // final List<LatLng> _nearByDrivers = [];
  Set<Polyline>? polyline = {};
  Set<Polyline>? bookignFlowPolyline = {};

  List<LatLng> polylineCoordinates = [];

  // Todo: Implements Google map controller
  GoogleMapController? mapController;

  Set<Marker>? markerList = {};
  Set<Marker>? bookingFlowMarkerList = {};

  List<Marker>? markerListStationDetail = [];

  CameraPosition? cameraPosition;
  CameraPosition? bookingFlowCameraPosition;

  //BitmapDescriptor? pinLocationIcon;
  Uint8List? pinLocationIcon;
  BitmapDescriptor? currentLocationIcon;

  // updateMarkerList(val) {
  //   markerList?.add(val);
  //   notifyListeners();
  // }

  /// Update driver coordinates
  updateBookingFlowDriverCoordinates(Marker val) {
    bookingFlowMarkerList?.add(val);
    notifyListeners();
  }

  // updateBookingFlowMarkerList(val) {
  //   bookingFlowMarkerList?.add(val);
  //   notifyListeners();
  // }

  // updateBookingFlowPolylineAndMarkers() {}
  void getUserCurrentLocation(context) async {
    try {
      // customMarker();

      if (Platform.isAndroid) {
        final status = await Permission.location.request();
        print('Permission =-===> ${status.isGranted}');
        if (status.isGranted) {
          locationData = await Geolocator.getCurrentPosition();
          currentLatLng =
              LatLng(locationData!.latitude, locationData!.longitude);

          ///=============//
          address = await getAddress(
            locationData?.latitude??0,
            locationData?.longitude??0,
          );
          if(address!=null && !(address?.contains("Error:")??false)&& currentLatLng!=null) {
            Provider.of<HomeViewProvider>(navigatorKey.currentContext!,
                    listen: false).updatePickUpText(address, currentLatLng);
            updateCameraPosition(currentLatLng);
          }
          notifyListeners();

          print('location--->Lat- ${locationData?.latitude} Long-${locationData?.longitude}');
          print('address-----> $address');
        } else if (status.isPermanentlyDenied) {
          openAppSettings();
        }
      } else {

       final permission = await Geolocator.requestPermission();

          locationData = await Geolocator.getCurrentPosition();
          currentLatLng =
              LatLng(locationData!.latitude, locationData!.longitude);
          address =
              await getAddress(locationData!.latitude, locationData!.longitude);

      }

      final Uint8List markerPinUser =
          await getImageForMap(AppImagesPath.currentPinUser, 200);


      markerList?.clear();

      /** when selection the origin and destination address polyline will draw */
      markerList?.add(Marker(
        infoWindow: const InfoWindow(title: "source add marker 100"),
        icon: BitmapDescriptor.fromBytes(markerPinUser,
            size: const Size(100, 100)),
        markerId: const MarkerId("Source"),
        position: currentLatLng ?? const LatLng(0, 0),
      ));

      //Todo add the current latlng in userRideLocationData suppose he is choosing the current lnglat
      userRideLocationData?.userPickUpLocation = currentLatLng;
      userRideLocationData?.userPickupAddress = address;

      // for (var element in _nearByDrivers) {
      //   markerList?.add(
      //     Marker(
      //       infoWindow: InfoWindow(title: "MarkerId ${element.latitude}"),
      //       icon: BitmapDescriptor.fromBytes(markerImage, size: const Size(5, 5)),
      //       markerId: MarkerId("MarkerId ${element.latitude}"),
      //       position: LatLng(element.latitude, element.longitude),
      //     ),
      //   );
      // }
      notifyListeners();
    } catch (e, t) {
      Dev.log("getUserCurrentLocation========>${e.toString()}");
      Dev.log("getUserCurrentLocation======>${t.toString()}");
    }
  }

  onChangePickUpDropLocation(
      {LatLng? pickUpLocation,
      LatLng? dropUpLocation,
      bool? isRideStart}) async {
    Uint8List sourcePin;
    Uint8List destinationPin;
    if (pickUpLocation != null && dropUpLocation != null) {
      if (!isRideStart!) {
        sourcePin = await getImageForMap(AppImagesPath.currentPinUser, 100);
        destinationPin =
            await getImageForMap(AppImagesPath.dropLocationCamel, 100);
      } else {
        markerList?.clear();
        sourcePin = await getImageForMap(AppImagesPath.carMarker, 100);
        destinationPin =
            await getImageForMap(AppImagesPath.dropLocationGreen, 100);
      }
      final Uint8List markerPinUser =
          await getImageForMap(AppImagesPath.currentPinUser, 200);
      markerList?.clear();

// add origin marker
      markerList?.add(
        Marker(
          infoWindow: const InfoWindow(title: "source add origin 5"),
          icon: BitmapDescriptor.fromBytes(markerPinUser,
              size: const Size(100, 100)),
          markerId: const MarkerId("Source"),
          position: pickUpLocation ?? const LatLng(0, 0),
          anchor: const Offset(0.5, 0.5),
        ),
      );

// add destination marker
      markerList?.add(
        Marker(
          infoWindow: const InfoWindow(title: "destination 5"),
          icon: BitmapDescriptor.fromBytes(
            destinationPin,
            // size: const Size(5, 5)
          ),
          markerId: const MarkerId("destination"),
          position: dropUpLocation ?? const LatLng(0, 0),
          anchor: const Offset(0.5, 0.5),
        ),
      );

      await setPolylinesDirection(pickUpLocation, dropUpLocation);

      // polyline!.add(Polyline(
      //   polylineId: const PolylineId('polylineId'),
      //   color: Colors.black,
      //   points: [
      //     pickUpLocation!, // Start point
      //     dropUpLocation!, // Start point
      //
      //   ],
      //   width: 3, // Adjust the width as needed
      // )

      // );

      moveMapViewOnLocationChange(pickUpLocation, 15.0);

      notifyListeners();
    }
  }

  updateMapController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  updateCameraPosition(latlng) {
    cameraPosition = CameraPosition(
      target: latlng ?? const LatLng(36.56666, 74.65657),
      zoom: 14.0,
    );
    notifyListeners();
  }

  moveMapViewOnLocationChange(latLng, zoom) {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          latLng!,
          zoom,
        ),
      );
    }

    updateCameraPosition(latLng);
    notifyListeners();
  }

  showCurrentLocationMarker() {
    markerListStationDetail!.clear();
    markerListStationDetail!.add(
      Marker(
        infoWindow: const InfoWindow(title: "current marker"),
        markerId: const MarkerId("current_marker"),
        position: currentLatLng!,
        icon: currentLocationIcon!,
        anchor: const Offset(0.5, 0.5),
      ),
    );
    notifyListeners();
    moveMapViewOnLocationChange(currentLatLng, 18);
  }

  /// Todo:
  Future<String> getAddress(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        return address;
      } else {
        return 'Address not found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Future<Uint8List> getImageForMap(String path) async {
  //   final ByteData bytes = await rootBundle.load(path);
  //   return bytes.buffer.asUint8List();
  // }

  Future<Uint8List> getImageForMap(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // Set polylines Direction
  Future<void> setPolylinesDirection(LatLng origin, LatLng destination) async {
    try {
      Dev.log("set polyline direction called");
      Dev.log("polyline :${origin.latitude}");
      Dev.log("polyline :${destination.latitude}");

      await DirectionHelper()
          .getRouteBetweenCoordinates(origin.latitude, origin.longitude,
              destination.latitude, destination.longitude)
          .then((result) {
        Dev.log(result.toString());
        if (result.isNotEmpty) {
          // polylineCoordinates.clear();
          // notifyListeners();
          // for (var point in result) {
          //   polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          // }

          Polyline polylines = Polyline(
              polylineId: const PolylineId("jalur"),
              color: AppColors.color080809,
              points: List<LatLng>.generate(
                  result.length,
                  (index) =>
                      LatLng(result[index].latitude, result[index].longitude)),
              width: 6,
              startCap: Cap.roundCap,
              endCap: Cap.roundCap);
          polyline!.add(polylines);

          notifyListeners();
        }
      });
    } catch (e, t) {
      Dev.log("e>>>>>>$e");
      Dev.log("e>>>>>>$t");
    }
  }

  void clear() {
    Dev.log("clear=================LocationProvider");

    markerList?.clear();
    polyline?.clear();
    bookingFlowMarkerList?.clear();
    bookignFlowPolyline?.clear();
    getUserCurrentLocation(navigatorKey.currentContext!);
    notifyListeners();
  }

  // Set polylines Direction
  setBookingFlowPolylinesDirection(LatLng origin, LatLng destination) async {
    Dev.log("set booking flow polyline direction called");
    Dev.log("polyline :${origin.latitude}");
    Dev.log("polyline :${destination.latitude}");

    await DirectionHelper()
        .getRouteBetweenCoordinates(origin.latitude, origin.longitude,
            destination.latitude, destination.longitude)
        .then((result) {
      Dev.log(result.toString());
      if (result.isNotEmpty) {
        // bookingFlowPolylineCoordinates.clear();

        // notifyListeners();
        // for (var point in result) {
        //   bookingFlowPolylineCoordinates
        //       .add(LatLng(point.latitude, point.longitude));
        // }

        Polyline polylines = Polyline(
            polylineId: const PolylineId("new"),
            color: AppColors.color080809,
            points: List<LatLng>.generate(
                result.length,
                (index) =>
                    LatLng(result[index].latitude, result[index].longitude)),
            width: 6,
            startCap: Cap.roundCap,
            endCap: Cap.roundCap);
        bookignFlowPolyline?.clear();
        bookignFlowPolyline?.add(polylines);

        notifyListeners();
      }
    });
  }

  acceptPolyLine(LatLng destination) async {
    moveMapViewOnLocationChange(currentLatLng, 15.0);
    final Uint8List markerPinUser =
        await getImageForMap(AppImagesPath.currentPinUser, 180);

    ///
    markerList?.clear();
    markerList?.add(Marker(
      icon: BitmapDescriptor.fromBytes(markerPinUser, size: const Size(6, 6)),
      markerId: const MarkerId("Source"),
      anchor: const Offset(0.5, 0.5),
      position: LatLng(currentLatLng!.latitude, currentLatLng!.longitude),
    ));

    userRideLocationData?.userPickUpLocation = currentLatLng;
    userRideLocationData?.userDropUpLocation = destination;
    userRideLocationData?.userPickupAddress = address;
    Uint8List destinationPin =
        await getImageForMap(AppImagesPath.dropLocationCamel, 65);

    markerList?.add(
      Marker(
        icon:
            BitmapDescriptor.fromBytes(destinationPin, size: const Size(3, 3)),
        markerId: const MarkerId("destination"),
        position: destination ?? const LatLng(30.6942, 76.8606),
      ),
    );
    await setPolylinesDirection(
        currentLatLng!, destination ?? const LatLng(30.6942, 76.8606));
    // moveMapViewOnLocationChange(currentLatLng);
    notifyListeners();
  }
}

class UserRideLocationData {
  LatLng? userPickUpLocation;
  LatLng? userDropUpLocation;
  String? userPickupAddress;
  String? userDropupAddress;

  UserRideLocationData(
      {this.userPickUpLocation,
      this.userDropupAddress,
      this.userDropUpLocation,
      this.userPickupAddress});
}
