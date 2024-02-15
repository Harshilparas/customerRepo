import 'package:deride_user/core/presentation/setting/provider/policy_provider.dart';
import 'package:deride_user/network/basic/network_constant.dart';

import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../utils/app_constant/app_strings.dart';

class TermsPolicy extends StatelessWidget {
  const TermsPolicy({super.key});
  static const routeName = '/termspolicy';

  @override
  Widget build(BuildContext context) {
    // <----------- Passing the content Url ----------- > //
    Provider.of<PolicyProvider>(context, listen: false)
        .getWebViewData(NetworkConstant.termsPolicyEndPoint);
    return Scaffold(
      body: SafeArea(
        child: Consumer<PolicyProvider>(builder: (context, pro, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const ToolBarWidget(tittle: AppStrings.termCondition),
                context.sizeH(5),
                Visibility(
                    visible: !pro.isLoadingWeb,
                    replacement: Center(
                      child: circularIndicator(),
                    ),
                    child: Expanded(
                        child: WebViewWidget(controller: pro.controller!)))
              ],
            ),
          );
        }),
      ),
    );
  }
}
