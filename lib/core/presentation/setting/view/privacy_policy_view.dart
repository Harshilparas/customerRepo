import 'package:deride_user/core/presentation/setting/provider/policy_provider.dart';
import 'package:deride_user/network/basic/network_constant.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/widget/loding_widget.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});
  static const routeName = '/privacyPolicy';

  @override
  Widget build(BuildContext context) {
    Provider.of<PolicyProvider>(context, listen: false)
        .getWebViewData(NetworkConstant.privacyPolicyEndPoint);
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<PolicyProvider>(builder: (context, pro, _) {
            return Column(
              children: [
                const ToolBarWidget(tittle: AppStrings.privacyPolicy),
                context.sizeH(5),
                Visibility(
                    visible: !pro.isLoadingWeb,
                    replacement: Center(
                      child: circularIndicator(),
                    ),
                    child: Expanded(
                        child: WebViewWidget(controller: pro.controller!)))
              ],
            );
          }),
        ),
      ),
    );
  }
}
