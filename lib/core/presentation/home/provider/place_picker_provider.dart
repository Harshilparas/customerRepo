import 'dart:async';
import 'dart:developer';

import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as lctn;
import 'package:provider/provider.dart';

import '../widget/location_from_map.dart';

class PlacePickerProvider with ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  final lctn.Location locationService = lctn.Location();

  late GoogleMapController googleMapController;
  CameraPosition? cameraPosition;

  Completer<GoogleMapController> mapController = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  //initial
  late Map<String, dynamic> placeDataSelected;
  late String selectedName;
  late LatLng selectedLatLng;

  late BitmapDescriptor redMarker;
  String addressSelected = '';
  bool isCurrentLoading = false;
  bool isAddressLoading = false;

  PlacePickerProvider();

  set setAddress(val) {

    addressSelected = val;
    isCurrentLoading = false;
    selectedLatLng = LatLng(
        cameraPosition!.target.latitude, cameraPosition!.target.longitude);
    selectedName = addressSelected;
    placeDataSelected = {
      'pickUpCoordinate': selectedLatLng,
      'pickUpName': selectedName,
    };

    notifyListeners();
  }

  setupCurrentLatLongValues(
      LatLng latLng, String address, AddressType addressType) {
    // if (addressType == AddressType.origin) {
      selectedLatLng = latLng;
      addressSelected = address;
      placeDataSelected = {
        'pickUpCoordinate': selectedLatLng,
        'pickUpName': addressSelected,
        'addressType': AddressType.origin,
      };
      notifyListeners();
    // }
  }

  setCurrentLoad() {
    isCurrentLoading = true;
    notifyListeners();
  }

  setAddressLoad(value) {
    isAddressLoading = value;
    notifyListeners();
  }

  Future<void> getCurrentLocation(
      BuildContext context, AddressType addressType) async {
    try {
      final currentLatLong =
          Provider.of<LocationProvider>(context, listen: false).currentLatLng ??
              LatLng(0, 0);
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          currentLatLong.latitude, currentLatLong.longitude);

      googleMapController.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(currentLatLong.latitude, currentLatLong.longitude),
              zoom: 18)));
      cameraPosition = CameraPosition(
          target: LatLng(currentLatLong.latitude, currentLatLong.longitude),
          zoom: 18);
      final address =
          "${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality}";

      setAddress = address;
      setAddressLoad(false);

      setupCurrentLatLongValues(currentLatLong, address, addressType);
      notifyListeners();
      // locationService.onLocationChanged.listen((event) {});
    } on PlatformException catch (e) {
      if (e.toString() == 'PERMISSION_DENIED') {
        Dev.log(e.toString());
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        Dev.log(e.message);
      }
    }
  }
}
