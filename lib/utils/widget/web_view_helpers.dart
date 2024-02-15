
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewCommonWidget extends StatefulWidget {
  late String url;

   WebViewCommonWidget({super.key, required this.url});

  @override
  State<WebViewCommonWidget> createState() => _WebViewCommonWidgetState();
}

class _WebViewCommonWidgetState extends State<WebViewCommonWidget> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            if(progress==100){
              isLoading=false;
              setState(() {

              });
            }
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
                ''');
          },
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith(CommonApiUrl().privacyUrl)) {
          //     debugPrint('blocking navigation to ${request.url}');
          //     return NavigationDecision.prevent;
          //   }
          //   debugPrint('allowing navigation to ${request.url}');
          //   return NavigationDecision.navigate;
          // },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
            if(change.url != null && change.url!.contains("https://php.parastechnologies.in/de-ride/public/api/webservice/success")){
              Navigator.pop(context,true);
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }
@override
  void dispose() {
    debugPrint('url dispose');
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const ToolBarWidget(tittle: 'Add Card',),
      ),
      body: SafeArea(
        child: Visibility(
          visible: isLoading==false,
            replacement: const Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
            child: WebViewWidget(controller: _controller))/*Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: ToolBarWidget(tittle: ""),
            ),
            Expanded( 
              child: Visibility(
                  visible:true,
                  replacement: const Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CupertinoActivityIndicator(radius: 15,),
                    ),
                  ),
                  child: WebViewWidget(controller: _controller)),
            ),
          ],
        ),*/
      ),
    );
  }
}
