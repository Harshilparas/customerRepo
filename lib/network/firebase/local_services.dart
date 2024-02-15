import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../../core/presentation/chat/view/chat_view.dart';
import '../../main.dart';
import '../../utils/mixin/dev.mixin.dart';

class LocalNotificationService {
  static final LocalNotificationService _localNotificationService =
  LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    /*final bool result =*/
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'afri_channel', // id
    'Afri Notifications', // title
    description: 'This channel is used for important notifications.',
    //sound: null,
    //playSound: false,
    //enableVibration: false,
    // description
    importance: Importance.max,
  );

  Future selectNotification(String? payload) async {
    ///Handle notification tapped logic here
    Dev.log('=========> Notification Clicked - ${payload.toString()}');
    final data = json.decode(payload!);

    ///TODO: Handle notification click event
    ///TODo: handle notification click event hereA
    if (data['notificationTypeId'] == 'message') {
      navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => ChatView(
              image: data['sender_profile_picture'],
              name: data['senderName'])));
    }
  }

  void onDidReceiveLocalNotification(
      int? id, String? payload, String? payload1, String? payload2) async {
    ///Handle notification logic here
  }

  showNotification({
    int id = 123,
    String? title,
    String? message,
    String? image,
    Map<String, dynamic>? payload,
  }) async {
    ///Create channel specifics for iOS
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails();

    ///Create channel specifics for android
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
    );

    ///create platform channel specifics
    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    ///show notification
    await flutterLocalNotificationsPlugin.show(
        id, title, message, platformChannelSpecifics,
        payload: json.encode(payload));
  }

  Future<void> showBigPictureNotification({
    int id = 123,
    String? title,
    String? message,
    String? image,
    String? payload,
  }) async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl(
        image!,
      ),
    );
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
      await _getByteArrayFromUrl(
        image,
      ),
    );

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      bigPicture,
      largeIcon: largeIcon,
      contentTitle: message,
      htmlFormatContentTitle: true,
      summaryText: message,
      htmlFormatSummaryText: true,
    );

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
    );

    ///Image for iOS
    // final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');

    ///Create channel specifics for iOS
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails();

    ///Create Notification detail
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    ///Show notification
    await flutterLocalNotificationsPlugin.show(
        id, title, message, platformChannelSpecifics);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    ///Convert image url to byte array
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }
}