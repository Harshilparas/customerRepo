import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:deride_user/core/presentation/authentication/login/view/login_view.dart';
import 'package:deride_user/core/presentation/home/provider/location_provider.dart';
import 'package:deride_user/core/presentation/home/view/home_view.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/network/basic/local_db.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../network/firebase/firebase_services.dart';
import '../../../../../network/locator/locator.dart';
import '../../../../../utils/app_constant/app_image_strings.dart';
import '../../../home/provider/home_view_provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const routeName = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool isLogin = SharedPreferencesManager().isLogin??false;
  late AppLinks _appLinks;
  String tag = "deepLinking";
  var locationProvider = locator<LocationProvider>();
  var homeViewProvider = locator<HomeViewProvider>();

  @override
  void initState() {
    FCMService().getFCMToken();
        _appLinks = AppLinks();
    // _getTokenAndSaveData();
    _appLinks.uriLinkStream.listen((uri) {
      print('onApp stream Link: $uri');
      if(isLogin){
        navigateToScreen(uri);
      }
    });



    locationProvider.initializeMarkerBitMap();
    homeViewProvider.clearController();
    print("init called in SplashView _handleDeepLinking");
    _handleDeepLinking();
    // TODO: implement initState//
    //=====//

    super.initState();
    Provider.of<LocationProvider>(context, listen: false).getUserCurrentLocation(context);
    Provider.of<LocationProvider>(context, listen: false).getUserCurrentLocation(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(const Duration(seconds: 4), () async {
        final ctx=navigatorKey.currentContext;
        if(ctx!=null && ctx.mounted) {
          if (SharedPreferencesManager().isLogin) {
            Navigator.pushNamedAndRemoveUntil(
                ctx, HomeView.routeName, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                ctx, LoginView.routeName, (route) => false);
          }
        }
      });
    });
    //=======//
  }


 

  void navigateToScreen(Uri uri) {
    print(uri);
    List<String> parts = uri.toString().split('=');
    String idWithPlus = parts.length > 1 ? parts[1] : '';
    String id = idWithPlus.replaceAll('+', '');
    print('Extracted ID: $id');
    if(id.trim().isNotEmpty){
          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
      // Get.offAll(() => NewRequestView(deepLink: id,));
    }else{
      Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
    }

  }

  void _handleDeepLinking() {
    const delayDuration = Duration(seconds: 3);
    Future.delayed(delayDuration, () async {
      final appLink = await _appLinks.getInitialAppLink();
      final recentLink = await _appLinks.getLatestAppLink();
      final isLoggedIn = isLogin;
      if (appLink != null || recentLink != null) {
        final link = appLink ?? recentLink;
        print('$tag ===>: $link');
        if (!isLoggedIn || link ==null) {
             Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
        } else {
          navigateToScreen(link);
        }
      } else {
        if (SharedPreferencesManager().isLogin) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginView.routeName, (route) => false);
        }
        // if (!isLoggedIn) {
        //   Get.offAll(() => const LoginView());
        // } else {
        //   Get.offAll(() => const HomeView());
        // }
      }
    });
  }

  // _getTokenAndSaveData() async {
  //   if (GetPlatform.isAndroid) {
  //     Storage.saveValue(Constants.deviceType, 'android');
  //   } else if (GetPlatform.isIOS) {
  //     Storage.saveValue(Constants.deviceType, 'ios');
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.screenHeight ,
        width: context.screenWidth  ,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage(
              AppImagesPath.splashBgPath,
            ),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: context.screenHeight * 0.25,
              width: context.screenHeight * 0.25,
              child: AppImagesPath.logoPath.image(),
            )
          ],
        ),
      ),
    );
  }
}
