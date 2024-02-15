

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PolicyProvider extends ChangeNotifier {
  // <-------- Web view Controller ----------> //
  WebViewController? controller;

  // <----------Bool isLoading -----------> //
  bool isLoadingWeb = true;

  // <-----------  method to get the data----------> //
  void getWebViewData(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {},
      );
    loadData(url);
  }

  // <-----------  Method to Load Data -------->  //
  loadData(data) async {
    await controller!.loadRequest(Uri.parse(data));

    Future.delayed(const Duration(seconds: 3), () {
      isLoadingWeb = false;
      notifyListeners();
    });
  }
}
