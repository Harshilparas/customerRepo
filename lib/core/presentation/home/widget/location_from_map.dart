import 'dart:developer';

import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/button_widget.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'dart:developer' as dev;

import '../../../../utils/app_constant/app_image_strings.dart';
import '../provider/place_picker_provider.dart';

enum AddressType { origin, destination }

class PlacePickerPage extends StatefulWidget {
  final AddressType addressType;

  const PlacePickerPage({
    Key? key,
    required this.addressType,
  }) : super(key: key);
  static const routeName = '/place_picker';

  @override
  State<PlacePickerPage> createState() => _PlacePickerPageState();
}

class _PlacePickerPageState extends State<PlacePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlacePickerProvider>(builder: (context, provider, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            //show background google maps
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: provider.selectedLatLng,
                zoom: 18.0,
              ),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                provider.googleMapController = controller;
              },
              onCameraMove: (CameraPosition cameraPositiona) {
                provider.cameraPosition = cameraPositiona;
              },
              onCameraIdle: () async {
                dev.log("On CAMERA ideal called");
                if (provider.cameraPosition != null) {
                  provider.setAddressLoad(true);

                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      provider.cameraPosition!.target.latitude,
                      provider.cameraPosition!.target.longitude);

                  provider.setAddress =
                      "${placemarks.first.street}, ${placemarks.first.subLocality}, ${placemarks.first.locality}";

                  provider.setAddressLoad(false);
                }
              },
            ),

            Center(
              child: SvgPicture.asset(
                widget.addressType == AddressType.origin
                    ? AppImagesPath.currentLocationIcon
                    : AppImagesPath.dropLocationIcon,
                width: 50,
              ),
            ),

            //Bottom Section
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                // height: queryData.size.height * 0.3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: provider.isCurrentLoading
                              ? FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () {},
                                  child: const CircularProgressIndicator(
                                      strokeWidth: 3),
                                )
                              : FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  onPressed: () async {
                                    provider.setCurrentLoad();
                                    await provider.getCurrentLocation(
                                        context, widget.addressType);
                                  },
                                  child: const Icon(Icons.my_location_rounded,
                                      color: Colors.green, size: 35),
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.isAddressLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : TextWidget(
                                    // "sdf",
                                    msg: provider.addressSelected,

                                    textSize: 20,
                                    // m: 10,
                                    maxLine: 3,
                                    textAlign: TextAlign.center,
                                  ),
                            context.sizeH(0.8),
                            //Select this place button
                            ButtonWidget(
                              msg: "Select this place",
                              callback: () {
                                dev.log("on pressed called -------->>>..");
                                if (!provider.isAddressLoading) {
                                  Navigator.pop(
                                      context, provider.placeDataSelected);
                                }
                              },
                            ),
                            context.sizeH(0.5),
                            // SizedBox(
                            //   height:
                            //       MediaQuery.of(context).size.width *
                            //           .02,
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );
    });
  }
}
