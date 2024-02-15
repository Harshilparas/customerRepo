// ignore_for_file: prefer_const_constructors

import 'package:deride_user/core/presentation/home/provider/home_view_provider.dart';
import 'package:deride_user/core/presentation/setting/model/history_model.dart';
import 'package:deride_user/core/presentation/setting/widget/history_detail_customer_detail_view.dart';
import 'package:deride_user/core/presentation/setting/widget/history_detail_map_view.dart';
import 'package:deride_user/core/presentation/setting/widget/history_detail_route_payment_widget.dart';
import 'package:deride_user/core/presentation/setting/widget/history_details_rating_given_widget.dart';
import 'package:deride_user/network/locator/locator.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_strings.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/mixin/dev.mixin.dart';
import 'package:deride_user/utils/widget/tool_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../../../network/basic/network_constant.dart';
import '../../../../utils/app_constant/app_image_strings.dart';

class HistoryDetailsView extends StatelessWidget {
  final HistoryOrder? item;

  const HistoryDetailsView({super.key, this.item});

  static const routeName = '/historyDetails';

  @override
  Widget build(BuildContext context) {
    Dev.log("item>>>${item?.toJson()}");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const ToolBarWidget(tittle: AppStrings.tripDetails),
              ),
              ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: context.screenHeight * 0.3),
                  child: HistoryDetailsMapView(item: item)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: AppColors.colorWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: context.screenWidth,
                          child: HistoryDetailsCustomerDetailsView(
                            item: item ,
                              key: key,
                           )),
                      context.sizeH(2.5),
                      RoutePaymentWidget(
                        item: item,


                      ),
                      context.sizeH(2.5),
                      RatingGivenView(key: key, item: item),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
