import 'dart:developer';

import 'package:deride_user/core/presentation/rating/view/rating_main_screen.dart';
import 'package:deride_user/core/presentation/rating/widget/top_rating_widget.dart';
import 'package:deride_user/core/presentation/receipt/view/car_receipt/car_receipt_screen.dart';
import 'package:deride_user/main.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../utils/app_constant/app_colors.dart';
import '../../../../utils/app_constant/app_strings.dart';
import '../../../../utils/widget/tool_bar_widget.dart';
import '../provider/rating_provider.dart';
import '../widget/review_widget.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = '/reviewView';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  /* void navigate() {
    navigatorKey.currentState!.push(
        MaterialPageRoute(builder: ((context) =>  CarReceiptScreen())));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RatingProvider>(builder: (context, provider, _) {
        return SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          //  Future.delayed(const Duration(seconds: 5), navigate);//
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          color: AppColors.color232323,
                          size: 25,
                        ),
                      ),
                      TextWidget(
                        msg: AppStrings.ratings,
                        font: FontMixin.mediumFamily,
                        fontWeight: FontMixin.fontWeightMedium,
                        color: AppColors.color001E00,
                        textSize: 20,
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                  context.sizeH(2),
                  Expanded(
                    child: provider.dataLoading
                        ? const Center(child: CircularProgressIndicator())
                        : provider.getRatingList.isEmpty
                            ? Center(
                                child: LottieBuilder.asset(
                                "assets/animation/no_data.json",
                                height: 300,
                              ) //   Container(
                                //    child: Text(AppStrings.NoDataFound),
                                //  ),
                                )
                            : Column(
                              children: [
                                AverageRatingWidget(
                                  rating: provider.ratindListModel?.rating
                                          .toString() ??
                                      "0",
                                  totalReview: provider
                                          .ratindListModel?.ratingCount
                                          .toString() ??
                                      "0",
                                ),
                                context.sizeH(4),
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(
                                                color: AppColors.colorECECEC),
                                    shrinkWrap: true,
                                    itemCount: provider.getRatingList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // log("image is  "+provider.getRatingList[index].driver_profile_pic.toString());
                                      var model =
                                          provider.getRatingList[index];
                                      return ReviewWidget(
                                        image: model.customerProfilePic ?? "",
                                        name: model.name,
                                        date: model.createdAt.toString(),
                                        description: model.review ?? "",
                                        rating: model.rating.toString(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                  )
                ],
              )),
        );
      }),
    );
  }
}
