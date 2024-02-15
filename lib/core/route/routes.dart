import 'package:deride_user/core/presentation/chat/view/chat_view.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/core/presentation/payment_method/view/payment_screen.dart';
import 'package:deride_user/core/presentation/payment_method/view/select_payment_method_view.dart';
import 'package:deride_user/core/presentation/rating/view/review_view.dart';

import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/core/presentation/receipt/view/fedback/view/feedback_view.dart';
import 'package:deride_user/core/presentation/receipt/view/fedback/view/submit_feedback_successfull_view.dart';
import 'package:deride_user/core/presentation/request/view/driver_accept_request_view.dart';
import 'package:deride_user/core/presentation/setting/view/contact_us_view.dart';
import 'package:deride_user/core/presentation/setting/view/edit_profile.dart';
import 'package:deride_user/core/presentation/setting/view/history_details_view.dart';
import 'package:deride_user/core/presentation/setting/view/history_view.dart';
import 'package:deride_user/core/presentation/setting/view/privacy_policy_view.dart';
import 'package:deride_user/core/presentation/setting/view/setting_view.dart';
import 'package:deride_user/core/presentation/setting/view/terms_policy_view.dart';
import 'package:flutter/material.dart';

import '../presentation/authentication/create_profile/view/create_profile_view.dart';
import '../presentation/authentication/forgot_pass/view/forgot_pass_view.dart';
import '../presentation/authentication/forgot_pass/view/otp_verification_view.dart';
import '../presentation/authentication/forgot_pass/view/reset_password_view.dart';
import '../presentation/authentication/login/view/login_view.dart';
import '../presentation/authentication/signup/view/signup_view.dart';
import '../presentation/authentication/splash/view/splash_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case ForgotPassView.routeName:
      return MaterialPageRoute(builder: (_) => const ForgotPassView());
    case OtpVerificationView.routeName:
      return MaterialPageRoute(builder: (_) => const OtpVerificationView());
    case ResetPasswordView.routeName:
      return MaterialPageRoute(builder: (_) => const ResetPasswordView());

    case CreateProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const CreateProfileView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeView());
    case SettingView.routeName:
      return MaterialPageRoute(builder: (_) => const SettingView());

    case ContactUsView.routeName:
      return MaterialPageRoute(builder: (_) => const ContactUsView());
    case DriverRequestAcceptView.routeName:
      return MaterialPageRoute(builder: (_) => const DriverRequestAcceptView());
    case ChatView.routeName:
      return MaterialPageRoute(builder: (_) =>  ChatView());

    case HistoryView.routeName:
      return MaterialPageRoute(builder: (_) => const HistoryView());
    case HistoryDetailsView.  routeName:
      return MaterialPageRoute(builder: (_) =>  HistoryDetailsView());

    case CarReceiptScreen.routeName:
      return MaterialPageRoute(builder: (_) =>  CarReceiptScreen());

    case SubmitFeedbackView.routeName:
      return MaterialPageRoute(builder: (_) =>  SubmitFeedbackView());
    case SelectPaymentMethodView.routeName:
      return MaterialPageRoute(builder: (_) => const SelectPaymentMethodView());
    case PrivacyPolicyView.routeName:
      return MaterialPageRoute(builder: (_) => const PrivacyPolicyView());
    case TermsPolicy.routeName:
      return MaterialPageRoute(builder: (_) => const TermsPolicy());
    case EditProfileView.routeName:
      return MaterialPageRoute(builder: (_) => const EditProfileView());

    case ReviewScreen.routeName:
      return MaterialPageRoute(builder: (_) => ReviewScreen());

    case SubmitFeedbackSuccessfully.routeName:
      return MaterialPageRoute(
          builder: (_) => const SubmitFeedbackSuccessfully());
    // case ReceiptScreen.routeName:
    //   return MaterialPageRoute(builder: (_) => ReceiptScreen());
    // case PaymentSCreen.routeName:
    //   return MaterialPageRoute(builder: (_) => PaymentSCreen());

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
