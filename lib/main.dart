import 'dart:io';

import 'package:deride_user/core/presentation/authentication/create_profile/provider/image_picker_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
import 'package:deride_user/core/presentation/authentication/login/provider/login_provider.dart';
import 'package:deride_user/core/presentation/authentication/signup/provider/signup_provider.dart';
import 'package:deride_user/core/presentation/authentication/splash/view/splash_view.dart';
import 'package:deride_user/core/presentation/chat/provider/chat_provider.dart';
import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/provider/place_picker_provider.dart';
import 'package:deride_user/core/presentation/home/provider/ride_in_Progress_provider.dart';
import 'package:deride_user/core/presentation/payment_method/provider/payment_method_provider.dart';
import 'package:deride_user/core/presentation/rating/provider/rating_provider.dart';
import 'package:deride_user/core/presentation/receipt/provider/receipt_provider.dart';
import 'package:deride_user/core/presentation/receipt/provider/receipt_screen_provider.dart';
import 'package:deride_user/core/presentation/request/provider/request_provider.dart';
import 'package:deride_user/core/presentation/request/provider/socket_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/contact_us_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/edit_profile_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/history_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/policy_provider.dart';
import 'package:deride_user/core/presentation/setting/provider/profile_provider.dart';
import 'package:deride_user/core/route/routes.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'core/presentation/authentication/create_profile/provider/create_profile_provider.dart';
import 'core/presentation/authentication/forgot_pass/provider/provider/otp_verification_provider.dart';
import 'core/presentation/authentication/forgot_pass/provider/provider/reset_pass_provider.dart';
import 'network/basic/local_db.dart';
import 'network/firebase/firebase_services.dart';
import 'network/firebase/local_services.dart';



GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> _messageHandler(RemoteMessage message) async {
  //  await dotenv.load(fileName: "assets/.env");


   await Firebase.initializeApp();
  LocalNotificationService().showNotification(
    title: message.notification!.title,
    message: message.notification!.body!,
    // message: message.notification!.body!,
    payload: message.data,

    // payload: {"test": "test"},
  );
  print("message on backroung" );
  print(message);
  final data = message.data;
  Dev.log('Notification data ======> ${data.toString()}');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global=MyHttpOverrides();
  Stripe.publishableKey  = "pk_test_51OGCtPGqfYIVAAkIcL3pSK2vLGefS6yGTbhjusEmcw8MLUNsAACVXFNR29Age04fLxv4YwPxGVWp10NVuSVb9nbG008vEk6LuB";
    // await dotenv.load(fileName: "assets/.env");
  try {
    await init();
    await SharedPreferencesManager().initialize();
    await Firebase.initializeApp();
    await FCMService().init();
    await LocalNotificationService().init();
    await  FCMService().showForGroundMessage();
    
    FirebaseMessaging.onBackgroundMessage(_messageHandler);


    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => locator<LoginProvider>()),
          ChangeNotifierProvider(
              create: (context) => locator<OtpVerificationProvider>()),
          ChangeNotifierProvider(
              create: (context) => locator<ResetPassProvider>()),
          ChangeNotifierProvider(
              create: ((context) => locator<SignupProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<SharedPreferencesManager>())),
          ChangeNotifierProvider(
              create: ((context) => locator<CreateProfileProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<ImagePickerProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<LocationProvider>())),
          ChangeNotifierProvider(create: ((context) => HomeViewProvider())),
          ChangeNotifierProvider(
              create: ((context) => PaymentMethodProvider())),
          ChangeNotifierProvider(create: ((context) => ChatProvider())),
          ChangeNotifierProvider(create: ((context) => ChatProvider())),
          ChangeNotifierProvider(
              create: ((context) => locator<ForgotPassProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<ProfileProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<EditProfileProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<PolicyProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<ContactUsProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<SocketProvider>())),
          ChangeNotifierProvider(
              create: ((context) => locator<RequestProvider>())),
          ChangeNotifierProvider(
              create: (context) => locator<HistoryProvider>()),
          ChangeNotifierProvider(
              create: (context) => locator<ReceiptProvider>()),
          ChangeNotifierProvider(
              create: (context) => locator<ReceiptScrerenProvider>()),
            ChangeNotifierProvider(
              create: (context) => locator<RideInProgressProvider>()),  
          ChangeNotifierProvider(create: (context) => locator<RatingProvider>()),
          ChangeNotifierProvider(create: (context) => locator<PlacePickerProvider>()),
        ],
        builder: (context, _) {
          return const MyApp();
        }));
  } catch (e) {
    Dev.log(e.toString());
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      localizationsDelegates: [
      //  AppLocalizations.delegate,
      //  GlobalMaterialLocalizations.delegate,
      //  GlobalWidgetsLocalizations.delegate,
      //  GlobalCupertinoLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],

      home: const SplashView(),
      onGenerateRoute: generateRoute,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
  
}
