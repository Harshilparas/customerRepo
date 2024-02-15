part of '../view/home_view.dart';

class HomeTopViewWidget extends StatefulWidget {
  const HomeTopViewWidget({Key? key}) : super(key: key);

  @override
  State<HomeTopViewWidget> createState() => _HomeTopViewWidgetState();
}

class _HomeTopViewWidgetState extends State<HomeTopViewWidget> {
  FocusNode pickUpFocusNode = FocusNode();
  FocusNode destinationFocusNode = FocusNode();
  var homeProvider = locator<HomeViewProvider>();

  @override
  void initState() {
    pickUpFocusNode.addListener(listener);
    destinationFocusNode.addListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<LocationProvider>(context, listen: false).currentLatLng ==
        null) {
      Provider.of<LocationProvider>(context, listen: false)
          .getUserCurrentLocation(context);
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: AppColors.color001E00.withOpacity(0.07),
            offset: const Offset(0, 2),
            blurRadius: 50)
      ]),
      child: Consumer3<HomeViewProvider, PlacePickerProvider, LocationProvider>(
          builder: (context, provider, placeProvider, locationProvider, _) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 5,
                  right: 10,
                  top: context.screenHeight * 0.070,
                  bottom: provider.placeList.isEmpty ? 10 : 0),
              child: IntrinsicHeight(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 4),
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: AppImagesPath.currentLocationIcon.svg,
                            ),
                          ),
                          Expanded(
                            child: CustomPaint(
                                painter: DashedLineVerticalPainter(),
                                size: const Size(1, double.infinity)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 4),
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: AppImagesPath.dropLocationIcon.svg,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            msg: AppStrings.pickupLocation.toUpperCase(),
                            font: FontMixin.regularFamily,
                            fontWeight: FontMixin.fontWeightRegular,
                            color: AppColors.color5E6D55,
                            textSize: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    Provider.of<LocationProvider>(context,
                                            listen: false)
                                        .onChangePickUpDropLocation(
                                            isRideStart: true);
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    child: TextField(
                                      focusNode: pickUpFocusNode,
                                      controller: provider.pickUpText,
                                      onChanged: (value) {
                                        Provider.of<HomeViewProvider>(context,
                                                listen: false)
                                            .getLocationResults(value, true);
                                      },
                                      style: const TextStyle(
                                          fontFamily: FontMixin.regularFamily,
                                          fontWeight:
                                              FontMixin.fontWeightRegular,
                                          color: AppColors.color001E00,
                                          fontSize: 17),
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(5),
                                        hintText: "My current location",
                                        hintStyle: TextStyle(
                                            fontFamily: FontMixin.regularFamily,
                                            fontWeight:
                                                FontMixin.fontWeightRegular,
                                            color: AppColors.color5E6D55
                                                .withOpacity(0.5),
                                            fontSize: 17),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, SettingView.routeName);
                                  },
                                  child: SvgPicture.asset(
                                    AppImagesPath.drawerIcon,
                                    height: 25,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.color5E6D55.withOpacity(0.2),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            msg: AppStrings.dropLocation.toUpperCase(),
                            font: FontMixin.regularFamily,
                            fontWeight: FontMixin.fontWeightRegular,
                            color: AppColors.color5E6D55,
                            textSize: 13,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: TextField(
                              focusNode: destinationFocusNode,
                              controller: provider.dropText,
                              onChanged: (value) {
                                Provider.of<HomeViewProvider>(context,
                                        listen: false)
                                    .getLocationResults(value, false);
                              },
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: FontMixin.regularFamily,
                                  fontWeight: FontMixin.fontWeightRegular,
                                  color: AppColors.color001E00,
                                  fontSize: 17),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(5),
                                hintText: "Search Your Destination ",
                                hintStyle: TextStyle(
                                    fontFamily: FontMixin.regularFamily,
                                    fontWeight: FontMixin.fontWeightRegular,
                                    color:
                                        AppColors.color5E6D55.withOpacity(0.5),
                                    fontSize: 17),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (pickUpFocusNode.hasFocus ||
                              destinationFocusNode.hasFocus)
                            InkWell(
                              onTap: () async {
                                await goToMap(
                                  type: pickUpFocusNode.hasFocus
                                      ? AddressType.origin
                                      : AddressType.destination,
                                  context: context,
                                  provider: provider,
                                  placeProvider: placeProvider,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: AppColors.colorB9B8BA
                                            .withOpacity(0.5),
                                        width: 1.5)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppImagesPath.dropIcon,
                                      fit: BoxFit.cover,
                                      semanticsLabel: 'SVG Image',
                                    ),
                                    const SizedBox(width: 5),
                                    TextWidget(
                                      msg: "Select on map",
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: provider.placeList.isNotEmpty,
              child: Wrap(
                children: [
                  ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          log("on tap on placelist geocoder called");

                          provider.getSearchLocation(
                              context, provider.placeList[index]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20.0,
                                  top: 15,
                                  bottom: provider.placeList.length - 1 == index
                                      ? 20
                                      : 15),
                              child:
                                  Text(provider.placeList[index].description!),
                            ),
                            Visibility(
                                visible: provider.placeList.length - 1 != index,
                                child: Container(
                                  width: context.screenWidth,
                                  height: 1,
                                  color: Colors.black26,
                                ))
                          ],
                        ),
                      );
                    },
                    itemCount: provider.placeList.length,
                    shrinkWrap: true,
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Future<void> goToMap(
      {required AddressType type,
      required BuildContext context,
      required HomeViewProvider provider,
      required PlacePickerProvider placeProvider}) async {
    try {
      final location =
          Provider.of<LocationProvider>(context, listen: false).currentLatLng;
      if (location != null) {
        Dev.log("location>>>$location");
        List<Placemark> placeMarks = await placemarkFromCoordinates(
            location.latitude, location.longitude);
        if (context.mounted) {
          final address =
              "${placeMarks.first.street}, ${placeMarks.first.subLocality}, ${placeMarks.first.locality}";
          placeProvider.setupCurrentLatLongValues(location, address, type);
          // Provider.of<PlacePickerProvider>(context, listen: false)
          //     .setupCurrentLatLongValues(location, address, type);
          final value = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlacePickerPage(
                        addressType: type,
                      )));
          Dev.log("value>>>>$value");
          if (value != null && context.mounted) {
            provider.updateLocationFromMap(
                value: value, context: context, type: type);
          }
        }
      } else {
        Provider.of<LocationProvider>(context, listen: false)
            .getUserCurrentLocation(context);
      }
    } catch (e, t) {
      Dev.log("error==>$e");
      Dev.log("error==>$t");
    }
  }

  void listener() {
    context.read<HomeViewProvider>().notifyListeners();
  }
}
