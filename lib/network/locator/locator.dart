import 'package:deride_user/core/presentation/authentication/create_profile/provider/create_profile_provider.dart';
import 'package:deride_user/core/presentation/authentication/create_profile/provider/image_picker_provider.dart';
import 'package:deride_user/core/presentation/authentication/forgot_pass/provider/forgot_pass_provider.dart';
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
import 'package:deride_user/network/basic/local_db.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../core/presentation/authentication/forgot_pass/provider/provider/otp_verification_provider.dart';
import '../../core/presentation/authentication/forgot_pass/provider/provider/reset_pass_provider.dart';
import '../../core/presentation/authentication/login/provider/login_provider.dart';
import '../../core/presentation/authentication/signup/provider/signup_provider.dart';

final locator = GetIt.instance;

Future<void> init() async {
// Otp provider
  locator.registerLazySingleton<OtpVerificationProvider>(
      () => OtpVerificationProvider());
  // Login Provider
  locator.registerLazySingleton<LoginProvider>(() => LoginProvider());

  locator.registerLazySingleton<SignupProvider>(() => SignupProvider());
  locator.registerLazySingleton<ResetPassProvider>(() => ResetPassProvider());
  locator.registerLazySingleton<CreateProfileProvider>(
      () => CreateProfileProvider());
  locator.registerLazySingleton<ImagePickerProvider>(() => ImagePickerProvider());
  locator.registerLazySingleton<LocationProvider>(() => LocationProvider());
  locator.registerLazySingleton<GlobalKey<ScaffoldState>>(
          () => GlobalKey<ScaffoldState>());

  /// payment method provider
  locator.registerLazySingleton<PaymentMethodProvider>(
      () => PaymentMethodProvider());

  locator.registerLazySingleton<HomeViewProvider>(() => HomeViewProvider());

  locator.registerLazySingleton<SharedPreferencesManager>(() => SharedPreferencesManager());
  locator.registerLazySingleton<ForgotPassProvider>(() => ForgotPassProvider());
  locator.registerLazySingleton<ProfileProvider>(() => ProfileProvider());
  locator.registerLazySingleton<EditProfileProvider>(() => EditProfileProvider());
  locator.registerLazySingleton<PolicyProvider>(() => PolicyProvider());
  locator.registerLazySingleton<ContactUsProvider>(() => ContactUsProvider());
  locator.registerLazySingleton<SocketProvider>(() => SocketProvider());
  locator.registerLazySingleton<RequestProvider>(() => RequestProvider());
  locator.registerLazySingleton<HistoryProvider>(() => HistoryProvider());
  locator.registerLazySingleton<ReceiptProvider>(() => ReceiptProvider());
  locator.registerLazySingleton<ReceiptScrerenProvider>(() => ReceiptScrerenProvider());
  locator.registerLazySingleton<PlacePickerProvider>(() => PlacePickerProvider());
  locator.registerLazySingleton<RatingProvider>(() => RatingProvider());
  locator.registerLazySingleton<RideInProgressProvider>(() => RideInProgressProvider());
  
}
