import 'package:cached_network_image/cached_network_image.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';
import 'package:flutter/material.dart';

/// Circular image
Widget cachedNetworkImage({
  required String imageUrl,
  required BuildContext context,
  double? height,
  double? borderRadius = 100,
  Color? borderColor,
  double? borderWidth,
  Color? backgroundColor,
  bool showBorder = false,
  double? width,
}) {
  return Container(
    height: height ?? 50,
    width: width ?? 50,
    decoration: BoxDecoration(
      /*   boxShadow: [
        BoxShadow(
          color: (AppColor.grayA0A0A0).withOpacity(0.2).withOpacity(0.10),
          blurRadius: 25.0,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 0.0),
        )
      ],*/
      border: (showBorder ?? false)
          ? Border.all(
              color: borderColor ?? AppColors.colorWhite,
              width: borderWidth ?? 2)
          : null,
      borderRadius: BorderRadius.circular(((borderRadius ?? 0))),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular((borderRadius ?? 0)),
        child: imageUrl.isEmpty
            ? Image.asset(
                AppImagesPath.imageNotFound,
                fit: BoxFit.cover,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    color: AppColors.color40AFD2D,
                    value: progress.progress,
                  ),
                ),
                errorWidget: (c, o, s) {
                  return Image.asset(
                    AppImagesPath.imageNotFound,
                    fit: BoxFit.cover,
                  );
                },
              )),
  );
}
