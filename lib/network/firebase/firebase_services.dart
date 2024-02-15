
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/presentation/chat/view/chat_view.dart';
import '../../main.dart';
import '../../utils/mixin/dev.mixin.dart';
import '../basic/local_db.dart';
import 'local_services.dart';

class FCMService {
  static final FCMService _fcmService = FCMService._internal();

  factory FCMService() {
    return _fcmService;
  }

  FCMService._internal();

  FirebaseMessaging? _messaging;

  init() {
    _messaging = FirebaseMessaging.instance;
    requestNotificationPermissions();
  }

  ///  <------- Method to request the notification -------> ///
  Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    await Permission.location.request();
    if (status.isGranted) {
      // Notification permissions granted
    } else if (status.isDenied) {
      // Notification permissions denied
    } else if (status.isPermanentlyDenied) {
      // Notification permissions permanently denied, open app settings
      await openAppSettings();
    }
  }

  Future<String> getFCMToken() async {
    String token = '';
    await _messaging!.getToken().then((value) {
      token = value!;
      Dev.log('============FCM Token ---> $value');
      SharedPreferencesManager().setDeviceToken(value);
    });

    return token;
  }

  showForGroundMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      final data = message.data;
      Dev.log('Notification data ======> ${data.toString()}');
      if (data['notificationTypeId'] == "message") {
        // navigatorKey.currentState!.push(MaterialPageRoute(
        //     builder: (context) => ChatView(
        //         image: data['sender_profile_picture'],
        //         name: data['senderName'])));
        print("message");
        _handleNotification(
            message, "${data['message']}", "${data['senderName']}");
      } else {
        _handleNotification(message, "", "");
        print("not message");
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessageClick(message);
    });

    FirebaseMessaging.onBackgroundMessage(
          (message) {
        final data = message.data;
        Dev.log('Notification data ======> ${data.toString()}');
        if (data['notificationTypeId'] == "message") {
          // navigatorKey.currentState!.push(MaterialPageRoute(
          //     builder: (context) => ChatView(
          //         image: data['sender_profile_picture'],
          //         name: data['senderName'])));
          print("message");
          return _handleNotification(
              message, "${data['message']}", "${data['senderName']}");
        } else {
          return _handleNotification(message, "", "");
        }
      },
    );
  }

  _handleNotification(
      RemoteMessage remoteMessage, String message, String title) {
    print("bbb");
    LocalNotificationService().showNotification(
      title: title == "" ? remoteMessage.notification!.title : title,
      //message: remoteMessage.notification!.body!,
      message: message,
      payload: remoteMessage.data,

      // payload: {"test": "test"},
    );
  }



  _handleMessageClick(RemoteMessage message) {
    ///Handle all message notification click
    // printf('=========> Notification Clicked - ${message.toString()}');
    final data = message.data;
    Dev.log("on click the open message handler");
    Dev.log(data.toString());

    ///TODo: handle notification click event here
    if (data['notificationTypeId'] == 'message') {
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => ChatView(
            // context: context,
              image: data['sender_profile_picture'],
              name: data['senderName'])));
    } else {}
  }
}