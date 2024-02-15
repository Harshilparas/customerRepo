import 'dart:async';
import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:deride_user/core/presentation/chat/model/get_chat_model.dart';
import 'package:deride_user/core/presentation/home/models/driver_detail_model.dart';
import 'package:deride_user/core/presentation/home/models/update_lat_lng_model.dart';
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/provider/ride_in_Progress_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/payment_method/view/payment_screen.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/request/provider/request_provider.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/toast_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_client/web_socket_client.dart';
import '../../../../main.dart';
import '../../../../network/basic/network_constant.dart';
import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/widget/bottom_sheet_widget.dart';
import '../../../../utils/widget/button_widget.dart';
import '../../../../utils/widget/text_widget.dart';
import '../../chat/model/chat_list_model.dart';
import '../../receipt/provider/receipt_screen_provider.dart';
import '../view/driver_accept_request_view.dart';

class SocketProvider extends ChangeNotifier {
  static final SocketProvider _provider = SocketProvider.internal();

  factory SocketProvider() {
    return _provider;
  }

  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  var homeProvider = locator<HomeViewProvider>();

  SocketProvider.internal();

  var homeprovider = locator<HomeViewProvider>();

  getImage() async {
    final Uint8List markerImage =
        await getImageForMap(AppImagesPath.carMarker, 80);
  }

  final locationProvider = locator<LocationProvider>();

  Future<Uint8List> getImageForMap(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  /// Update order status Text
  rimediffernce() {
    var rideInProgressProvider = locator<RideInProgressProvider>();
    if (((rideInProgressProvider.rideInProgressModel?.order?.reached_time
                .toString()
                .isNotEmpty ??
            false) &&
        (rideInProgressProvider.rideInProgressModel?.order?.reached_time !=
            null))) {
      final currentTime = DateTime.tryParse(DateTime.now().toString());
      var starttime = DateTime.parse(rideInProgressProvider
              .rideInProgressModel?.order?.reached_time
              .toString() ??
          "");
      final difference = currentTime?.difference(starttime).inSeconds;
      Dev.log("difference =====>$difference");
      if ((difference ?? 0) >= 300) {
        return 0;
      } else {
        return 300 - (difference ?? 0);
      }
    } else {
      return 0;
    }
  }

  updateOrderStatusText({required String val}) {
    Dev.log("val>>>$val");
    if (val == "1") {
      reachedLocation = "Driver is Arriving Soon!";
    } else if (val == "3") {
      reachedLocation = "Driver has reached your location";
      startCountdown(rimediffernce());
    } else if (val == "5") {
      locationProvider.updateIsWithDriver();
      reachedLocation = "Driver has started trip";
    } else if (val == "7") {
      reachedLocation = "";
    }
    notifyListeners();
  }

  ///
  WebSocket? _socket;

  LatLng driverLatLng = const LatLng(0.0, 0.0);

  // -----> function to connect the socket <--------- //
  Future<dynamic> connectToSocket(BuildContext context) async {
    Dev.log("-------->CONNECTING TO SOCKET <--------");
    final url =
        "ws://shakti.parastechnologies.in:8052?token=${SharedPreferencesManager().chatToken}&userID=${SharedPreferencesManager().userId}";
    log('-------> uri === "$url"');
    _socket = WebSocket(Uri.parse(url));

    _socket!.connection.listen((event) {
      if (event is Connected) {
        Dev.log("************ Connectd ***********");

        listenSocketRequests(context, "connectToSocket");
        //      listenGetChat();
        // postCurrentPosition(context);
      } else {
        // showToast(message: "Socat not connected Please try again latter ");
        Dev.log("************ DisConnectd ***********");
      }
    });
  }

  // <------------ Listen To Socket Request Chat --------> //

  void listenGetChat() {
    final rideInProgressProvider =
        navigatorKey.currentContext!.read<RideInProgressProvider>();
    final driverId = driverDetailModel?.data?.id != null
        ? driverDetailModel?.data?.driverID
        : rideInProgressProvider.rideInProgressModel?.driverDetails?.id;

    final map = {
      'serviceType': 'GetChat',
      'roomID': (int.parse(SharedPreferencesManager().userId) >
              int.parse(driverId.toString()))
          ? '${int.parse(driverId.toString())}-${SharedPreferencesManager().userId}'
          : '${SharedPreferencesManager().userId}-${int.parse(driverId.toString())}',
      'user_id': SharedPreferencesManager().userId,
      'reciever_id': driverId,
      'userType': 'Customer',
    };
    // Dev.log('---kkk----${jsonDecode(map.toString())}');
    _socket!.send(json.encode(map));
    try {
      _socket!.connection.listen((event) {
        // if (event is Connected || event is Reconnected) {
          _socket!.send(json.encode(map));
          Dev.log('---kkk----${map.toString()}');
          notifyListeners();
// /*        }*/ else {
//           disconnect();
//           connectToSocket(navigatorKey.currentContext!);
//           listenGetChat();
//         }
      });
    } catch (e) {
      Dev.log(e.toString());
    }
  }

  void disconnect() {
    _socket!.connection.listen((event) {
      if (event is Connected) {
        _socket!.close();
      }
    });
  }

  // <------------ Send Message  Chat --------> //
  sendMessage({
    String? message,
  }) {
    final rideInProgressProvider =
        navigatorKey.currentContext!.read<RideInProgressProvider>();
    final driverId = driverDetailModel?.data?.id != null
        ? driverDetailModel?.data?.driverID
        : rideInProgressProvider.rideInProgressModel?.driverDetails?.id;

    final map = {
      'userID': SharedPreferencesManager().userId,
      'recieverID': driverId,
      'msg': message,
      'room': (int.parse(SharedPreferencesManager().userId) >
              int.parse(driverId.toString()))
          ? '${int.parse(driverId.toString())}-${SharedPreferencesManager().userId}'
          : '${SharedPreferencesManager().userId}-${int.parse(driverId.toString())}',
      'MessageType': "Text",
      'SenderType': 'Customer',
      'RecieverType': 'Driver',
      'serviceType': 'Chat',
      'type': 'Chat',
      'payment_method': '2'
    };
    Dev.log('---------message send--------${map.toString()}');
    _socket!.send(jsonEncode(map));
    messageCnt.text = '';
    chatList.insert(
        0,
        ChatModel(
            message: message,
            senderId: SharedPreferencesManager().userId,
            receiverId: driverId,
            createdOn: DateTime.now(),
            messageType: 'Text',
            senderType: 'Customer'));
    notifyListeners();
  }

  var unreadCount = '0';

  updateUnreadCount(val) {
    unreadCount = val;
    notifyListeners();

    log("unrad count :-->> $unreadCount");
  }

  // <------------ Listen To Socket Request --------> //

  void listenSocketRequests(BuildContext context, String s) {
    _socket!.messages.listen((event) {
      //  Decoding data
      final response = jsonDecode(event);
      Dev.log("---Event${response.toString()}");
      Dev.log("ride status ========> ${response['type']}");
      Dev.log("ride status sssssssss========> $s");

      if (response['type'] == 'Accept') {
        driverDetailModel = DriverDetailModel.fromJson(response);
        orderrId = driverDetailModel?.data?.id;
        Provider.of<SharedPreferencesManager>(context, listen: false)
            .setorderId(orderrId);
        log("custoer id check===>${driverDetailModel?.data?.id}");
        Provider.of<RequestProvider>(context, listen: false)
            .showTryAgainBottomSheet = false;
        Provider.of<RequestProvider>(context, listen: false).notifyListeners();
        if (driverDetailModel?.data?.profile_photo != null) {
          ExitRoom();

          // //    Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const DriverRequestAcceptView()),
              (route) => false);
          //   //  Navigator.pushNamed(context, DriverRequestAcceptView.routeName,);
          notifyListeners();
        }
      } else if (response['type'] == 'GetChat') {
        Dev.log('----k---${response.toString()}');
        getChatModel = GetChatModel.fromJson(response);
        chatList.clear();
        for (var element in getChatModel!.data!) {
          chatList.add(ChatModel(
              message: element.message,
              senderId: int.tryParse(element.senderId.toString()),
              receiverId: int.tryParse(element.receiverId.toString()),
              senderType: element.senderType));
          notifyListeners();
        }
        //  notifyListeners();
        print(chatList.length);
      } else if (response['type'] == 'UnreadCount') {
        updateUnreadCount(response["data"].toString());
        notifyListeners();
      } else if (response['type'] == 'UpdatedLatLong') {
        driverUpdateLatLng = UpdateLatLngResponseModels.fromJson(response);

        driverLatLng =
            LatLng(driverUpdateLatLng!.latitude, driverUpdateLatLng!.longitude);
        locationProvider.updateDriverCoordinates(driverLatLng);
        locationProvider.updateBookingFlowDriverCoordinates(Marker(
          infoWindow: const InfoWindow(title: "driver"),
          icon: BitmapDescriptor.defaultMarker,
          // icon: BitmapDescriptor.fromBytes(
          //     size: const Size(2, 2)),
          markerId: const MarkerId("DRIVER"),
          position: driverLatLng,
        ));
        locationProvider.updatePolylineWithSocket();

        notifyListeners();

        // locationProvider.updateMarkerList(Marker(
        //   infoWindow: const InfoWindow(title: "driver"),
        //   icon: BitmapDescriptor.defaultMarker,
        //   // icon: BitmapDescriptor.fromBytes(
        //   //     size: const Size(2, 2)),
        //   markerId: const MarkerId("DRIVER"),
        //   position: driverLatLng,
        // ));

        // markerList?.add(Marker(
        //   infoWindow: const InfoWindow(title: "source"),
        //   icon: BitmapDescriptor.defaultMarker,
        //   // icon: BitmapDescriptor.fromBytes(
        //   //     size: const Size(2, 2)),
        //   markerId: const MarkerId("DRIVER"),
        //   position: driverLatLng,
        // ));
      } else if (response['type'] == 'CustomerBookRequest') {
        reachedLocation = "Driver is Arriving Soon! ";
        driverDetailModel = DriverDetailModel.fromJson(response);
        print(' request ${driverDetailModel?.data?.name}');
        notifyListeners();
      } else if (response['type'] == 'reachLocation') {
        locationProvider.updateIsWithDriver(value: false);
        reachedLocation = "Driver has reached your location";
        startCountdown(300);
        SharedPreferencesManager().setStartTime(DateTime.now().toString());
        log("check the second ------>${SharedPreferencesManager().getStartTime().toString()}");
        // locationProvider.updateIsWithDriver();
        notifyListeners();
      } else if (response['type'] == 'startTrip') {
        locationProvider.updateIsWithDriver();
        locationProvider.updatePolylineWithSocket();
        reachedLocation = "Driver has started trip";

        notifyListeners();
      } else if (response['type'] == 'endTrip') {
        SharedPreferencesManager().removeOrderID();
        log("context is not null");
        locationProvider.updateIsWithDriver(value: false);
        driverLatLng = const LatLng(0, 0);
        locationProvider.updateDriverCoordinates(driverLatLng);

        navigatorKey.currentState!.push(MaterialPageRoute(
            builder: ((context) => CarReceiptScreen(
                  orderrId: orderrId,
                ))));

        //    navigatorKey.currentState!.pushAndRemoveUntil( MaterialPageRoute(builder:(context)=> const DriverRequestAcceptView()),
        //       (route) => false);
      } else if (response['type'] == 'Chat') {
        chatList.insert(
            0,
            ChatModel(
                message: response['data']['message'],
                senderId:
                    int.parse(response['data']['source_user_id'].toString()),
                receiverId: int.parse(SharedPreferencesManager().userId),
                senderType: 'Driver',
                createdOn: DateTime.now()));
        notifyListeners();
        Dev.log({"--Chat-$response.toString()"});
      }
      /*     else if(response['type']=='Reject'){
        navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => const HomeView())));
        notifyListeners();
      }*/
      else if (response['type'] == 'Cancel') {
        showDialog(
            barrierDismissible: false,
            context: navigatorKey.currentState!.context,
            builder: (context) {
              return const FindNewDriver();
            });
        /*    navigatorKey.currentState!.push(MaterialPageRoute(builder: ((context) => const HomeView())));
       notifyListeners();*/
      }

      /*else{
         ModalBottomSheet.moreModalBottomSheet(
          context,
          const RequestRideView(),
          isExpendable: false,
          // topBorderRadius: 0,
          padding: EdgeInsets.zero,
         );
       }*/

      //  Dev.log('-----Event  ${event.toString()}');
    });
  }

  void removeItem() {
    clearChat();
    chatList.clear();
    notifyListeners();
  }

  DriverDetailModel? driverDetailModel;

  // CustomerReceiptModel? customerReceiptModel;
  UpdateLatLngResponseModels? driverUpdateLatLng;

  var reachedLocation = "";
  var orderrId;

  List<ChatModel> chatList = [];
  TextEditingController messageCnt = TextEditingController();
  GetChatModel? getChatModel;

  addChatAll(List<ChatModel> list) {
    chatList = list;
    notifyListeners();
  }

  updateDriverDetailsModel({required DriverDetailModel val}) {
    driverDetailModel = val;
    notifyListeners();
  }

  // updateOrderDetailsModel({required O val}){

  // driverDetailModel=val;
  // notifyListeners();
  // }

  String? newTime;

  // <------------ BOOK TAXI --------------> //
  void bookTaxi(BuildContext context) {
    var homePro = Provider.of<HomeViewProvider>(context, listen: false);
    newTime = (homePro.estimatedTime / 60).toStringAsFixed(1);
    // var locationPro = Provider.of<LocationProvider>(context, listen: false);
    // < --------  Creating map for request to server --------->  //
    final map = {
      'serviceType': 'UserBookDriver',
      'UserID': SharedPreferencesManager().userId,
      'vehicle_category_id':
          homePro.vechileCatPrice!.data[homePro.selectedIndex].id.toString(),
      'start_coordinate':
          '${homePro.pickUpLatLng!.latitude.toString()}, ${homePro.pickUpLatLng!.longitude.toString()}',
      'end_coordinate':
          '${homePro.dropLatLng!.latitude.toString()}, ${homePro.dropLatLng!.longitude.toString()}',
      'start_address': homePro.pickUpText.text.trim(),
      'end_address': homePro.dropAddress,
      'Latitude': homePro.pickUpLatLng!.latitude.toString(),
      'Longitude': homePro.pickUpLatLng!.longitude.toString(),
      //  'estimated_time': '0',
      'estimated_time': newTime,
      'distance': homePro.distance.toString(),
      'total':
          '${homePro.vechileCatPrice!.data[homePro.selectedIndex].priceKm * homePro.distance!}',
      'payment_method':
          Provider.of<PaymentMethodProvider>(context, listen: false)
              .radioButtonValue
              .toString()
    };
    Dev.log(map.toString());
    try {
      _socket!.connection.listen((event) {
        log("event===>$event");
        if (event is Connected || event is Reconnected) {
          _socket!.send(json.encode(map));
          Dev.log("************ Booking Requested ***********");
          Dev.log(map.toString());
          Navigator.pop(context);
          // listenSocketRequests(context);

          locationProvider.updateBookingFlowCoordinates(
              origin: LatLng(homePro.pickUpLatLng!.latitude,
                  homePro.pickUpLatLng!.longitude),
              destination: LatLng(
                  homePro.dropLatLng!.latitude, homePro.dropLatLng!.longitude));
          Provider.of<RequestProvider>(context, listen: false)
              .showTryAgainBottomSheet = true;
          Provider.of<RequestProvider>(context, listen: false)
              .driverWaiting(context);

          ModalBottomSheet.moreModalBottomSheet(
            context,
            const RequestRideView(),
            isExpendable: false,
            // topBorderRadius: 0,
            padding: EdgeInsets.zero,
          );
        } else {
          disconnect();
          connectToSocket(navigatorKey.currentContext!);
        }
      });
    } catch (e) {
      Dev.log(e.toString());
    }
  }

  void cancelBooking(BuildContext context, {bool navigateNextScreen = true}) {
    // ProgressDialog.showProgressDialog(context);
    Provider.of<RequestProvider>(context, listen: false)
        .showTryAgainBottomSheet = false;
    Provider.of<RequestProvider>(context, listen: false).notifyListeners();
    final map = {
      'serviceType': 'CancelByUser',
      'UserID': SharedPreferencesManager().userId,
      'OrderID': driverDetailModel?.data?.id,
    };
    try {
      _socket!.connection.listen((event) {
        if (event is Connected) {
          _socket!.send(jsonEncode(map));
          if (navigateNextScreen) {
            Dev.log('------${map.toString()}');
            // homeProvider.clearController();
            Dev.log(
                "locationProvider>>>>>>>>>${locator<LocationProvider>().polyline}");
            Navigator.pushNamed(context, HomeView.routeName);
          }
        }
      });
    } catch (e) {
      Dev.log(e.toString());
    }
  }

  void tryAgainBooking(BuildContext context) {
    // ProgressDialog.showProgressDialog(context);
    // final map = {
    //   'serviceType': 'CancelByUser',
    //   'UserID': SharedPreferencesManager().userId,
    //   'OrderID': driverDetailModel?.data?.id,
    // };
    try {
      bookTaxi(context);
      // _socket!.connection.listen((event) {
      //   if (event is Connected) {
      //     // _socket!.send(jsonEncode(map));
      //     bookTaxi(context);
      //     Dev.log('------${map.toString()}');
      //   }
      // });
    } catch (e) {
      Dev.log(e.toString());
    }
  }

  // <------------ Join room  --------> //
  joinRoom() {
    // Dev.log('----${type}');
    final rideInProgressProvider =
        navigatorKey.currentContext!.read<RideInProgressProvider>();
    final driverId = driverDetailModel?.data?.id != null
        ? driverDetailModel?.data?.driverID
        : rideInProgressProvider.rideInProgressModel?.driverDetails?.id;

    final map = {
      'UserID': SharedPreferencesManager().userId,
      'type': 'Customer',
      'serviceType': 'Join',
      'roomID': (int.parse(SharedPreferencesManager().userId) >
              int.parse(driverId.toString()))
          ? '${int.parse(driverId.toString())}-${SharedPreferencesManager().userId}'
          : '${SharedPreferencesManager().userId}-${int.parse(driverId.toString())}'
    };
    try {
      _socket!.connection.listen((event) {
        if (event is Connected) {
          _socket!.send(jsonEncode(map));
          Dev.log('--join room----${map.toString()}');
          //    listenGetChat();
          notifyListeners();
        } else {
          disconnect();
          connectToSocket(navigatorKey.currentContext!);
          joinRoom();
        }
      });
    } catch (e) {
      Dev.log(map.toString());
    }
  }

  // <------------ Exit room  --------> //
  ExitRoom() {
    final rideInProgressProvider =
        navigatorKey.currentContext!.read<RideInProgressProvider>();
    final driverId = driverDetailModel?.data?.id != null
        ? driverDetailModel?.data?.driverID
        : rideInProgressProvider.rideInProgressModel?.driverDetails?.id;

    final map = {
      'UserID': SharedPreferencesManager().userId,
      'roomID': (int.parse(SharedPreferencesManager().userId) >
              int.parse(driverId.toString()))
          ? '${int.parse(driverId.toString())}-${SharedPreferencesManager().userId}'
          : '${SharedPreferencesManager().userId}-${int.parse(driverId.toString())}',
      'type': 'Customer',
      'serviceType': 'unJoin',
    };
    print(map);
    try {
      _socket!.connection.listen((event) {
        if (event is Connected) {
          _socket!.send(jsonEncode(map));
          print("sjbj");
          notifyListeners();
        }
      });
    } catch (e) {}
  }

  /// <---------- Clear Chat Function -------> ///
  void clearChat() {
    final ctx = navigatorKey.currentContext;
    if (ctx != null && (ctx.mounted)) {
      final d = Provider.of<ReceiptScrerenProvider>(ctx, listen: false)
          .receiptModel
          ?.orderReceipt
          ?.driverId;
      final map = {
        'serviceType': "ClearChat",
        'user_id': SharedPreferencesManager().userId,
        'type': 'Customer',
        "other_user_id": d ?? "",
      };

      try {
        _socket!.connection.listen((event) {
          if (event is Connected) {
            _socket!.send(json.encode(map));
            Dev.log("************Clear Chat***********");
            Dev.log(map.toString());

            notifyListeners();
          }
        });
      } catch (e) {
        Dev.log(e.toString());
      }
    }
  }

  bool timerReached = false;
  late Timer _timer;
  int seconds = 0;

  void startCountdown(int durationInSeconds) {
    seconds = durationInSeconds;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds == 0) {
          timerReached = false;
          notifyListeners();
        } else {
          timerReached = true;
          seconds--;
          notifyListeners();
        }
      },
    );
  }
}

class FindNewDriver extends StatefulWidget {
  const FindNewDriver({super.key});

  @override
  State<StatefulWidget> createState() => _FindNewDriver();
}

class _FindNewDriver extends State<FindNewDriver> {
  @override
  void initState() {
    super.initState();
    payAmount();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.18,
            child: AppImagesPath.logoPath.image()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(
              msg: "Ride Cancelled by  the Driver",
              color: AppColors.color001E00,
              font: FontMixin.boldFamily,
              fontWeight: FontMixin.fontWeightRegular,
              maxLine: 1,
              textAlign: TextAlign.center,
              textSize: 15,
            ),
            TextWidget(
              msg: "\$ 5 has been deducted from your account as penitently",
              color: AppColors.colorB9B8BA,
              font: FontMixin.boldFamily,
              fontWeight: FontMixin.fontWeightRegular,
              textAlign: TextAlign.center,
              overflow: null,
              textSize: 15,
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                width: 160,
                height: 40,
                msg: "Find New Driver",
                fontColor: AppColors.colorWhite,
                callback: () {
                  final socketProvider = locator<SocketProvider>();
                  socketProvider.removeItem();
                  socketProvider.disconnect();
                  socketProvider.connectToSocket(context);
                  // socketProvider.homeProvider.clearController();
                  SharedPreferencesManager().removeOrderID();
                  Navigator.pushNamed(context, HomeView.routeName);

                  socketProvider.notifyListeners();
                },
              ),
            ],
          ),
          Container(
            height: 10,
          ),
        ],
      ),
    );
  }

  Future<void> payAmount() async {
    // ProgressDialog.showProgressDialog(context);
    var dio = Dio();
    final socketProvider = locator<SocketProvider>();
    final rideInProgressProvider = locator<RideInProgressProvider>();

    var userToken = SharedPreferencesManager().token;
    var cardDetail = SharedPreferencesManager().getCardDetail();
    if (cardDetail?.id != null) {
      final driverData = socketProvider.driverDetailModel?.data;
      final driverDetails =
          rideInProgressProvider.rideInProgressModel?.driverDetails;
      final useOld = driverData?.id != null;
      final driverId = useOld ? driverData?.driverID : driverDetails?.id;
      final orderId = useOld
          ? driverData?.id
          : rideInProgressProvider.rideInProgressModel?.order?.id;
      var body = {
        // 'token': cardToken,
        'order_id': int.parse(orderId ?? "0"),
        "driver_id": int.parse(driverId ?? "0"),
        "amount": "5",
        "payment_type": 0,
        "card_id": cardDetail?.id ?? ""
      };
      log("user token is:-->> $userToken");

      var response = await dio.post(
        NetworkConstant.payment,
        // 'https://php.parastechnologies.in/taxi/public/api/webservice/driver/payment',
        data: body,
        options: Options(headers: {"Authorization": "Bearer $userToken"}),
      );
      Dev.log("response===.$response");
    }
  }
}
