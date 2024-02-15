import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/setting/model/history_model.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryDetailsMapView extends StatefulWidget {
  final HistoryOrder? item;

  const HistoryDetailsMapView({super.key, this.item});

  @override
  State<HistoryDetailsMapView> createState() => _HistoryDetailsMapViewState();
}

class _HistoryDetailsMapViewState extends State<HistoryDetailsMapView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var provider = Provider.of<LocationProvider>(context, listen: false);
    Provider.of<LocationProvider>(context, listen: false)
        .getUserCurrentLocation(context);
    // if(pro.orderHistoryModel?.historyOrder?.isNotEmpty??false) {
    List<String> splitCoordinates =
        (widget.item?.endCoordinate ?? "").split(', ');
    // provider.setDropLoaction(LatLng(double.parse(splitCoordinates[0]), double.parse(splitCoordinates[1])));
    provider.acceptPolyLine(LatLng(
        double.parse(splitCoordinates[0]), double.parse(splitCoordinates[1])));
    // }
  }

//Todo:  Implements camera position
  static CameraPosition? _cameraPosition;

  // Todo: Implements marker icon
  BitmapDescriptor? pinLocationIcon;

  // Todo: latLong variable
  LatLng? _latLng;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(builder: (context, provider, _) {
      return Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              polylines: provider.polyline ?? {},
              markers: provider.markerList ?? {},

              initialCameraPosition: provider.cameraPosition ??
                  CameraPosition(
                      target: LatLng(
                        provider.locationData?.latitude ?? 0,
                        provider.locationData?.longitude ?? 0,
                      ),
                      zoom: 10.0),
              onMapCreated: (GoogleMapController controller) {
                provider.updateMapController(controller);
              },
              buildingsEnabled: false,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
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
          ),
          Container(
            height: context.screenHeight * 0.048,
            width: context.screenWidth,
            color: AppColors.color40AFD2D.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextWidget(
                      msg:
                          // widget.item?.orderTime.toString(),
                          historyConvertToCustomFormat(
                              widget.item!.orderTime.toString()),
                      font: FontMixin.mediumFamily,
                      fontWeight: FontMixin.fontWeightMedium,
                      textSize: 14,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 6,
                        width: 6,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                      context.sizeW(2),
                      TextWidget(
                        msg: widget.item?.booking_status,
                        font: FontMixin.boldFamily,
                        fontWeight: FontMixin.fontWeightBold,
                        textSize: 14,
                        color: widget.item?.booking_status == 'Completed'
                            ? AppColors.color40AFD2D
                            : widget.item?.booking_status == 'Cancelled'
                                ? AppColors.colorRed
                                : AppColors.color001E00,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  String historyConvertToCustomFormat(String inputDateTime) {
    DateTime dateTime = DateTime.parse(
        inputDateTime.contains("Z") ? inputDateTime : "${inputDateTime}Z");

    DateTime dateTimeAtOffset = dateTime.toLocal();

    String formattedDateTime =
        DateFormat('dd MMMM yyyy, hh:mm a').format(dateTimeAtOffset);

    return formattedDateTime;
  }
}
