import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/extensions/alignment_extension.dart';
import 'package:deride_user/utils/extensions/image_extensions.dart';
import 'package:deride_user/utils/extensions/sizebox_extension.dart';
import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../app_constant/app_image_strings.dart';

class ImagePickerHelper {
  final BuildContext context;
  final ImagePicker imagePicker;
  final Function(XFile? file) successCallBack;
  final Function(String error) failedCallBack;

  ImagePickerHelper.showPicker({
    required this.context,
    required this.imagePicker,
    required this.successCallBack,
    required this.failedCallBack,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BottomSheetImageSource(
        selectCamera: () async {
          Navigator.pop(context);
          pickImage(ImageSource.camera);
        },
        selectGallery: () async {
          Navigator.pop(context);
          pickImage(ImageSource.gallery);
        },
      ),
    );
  }

  pickImage(ImageSource source) async {
    try {
      XFile? file = await imagePicker.pickImage(source: source);
      successCallBack(file);
    } catch (e) {
      failedCallBack(e.toString());
    }
  }

  bool isImageExceedOver3MB(int? byte) {
    if (byte == null) return false;
    return byte > 12000000;
  }
}

class BottomSheetImageSource extends StatelessWidget {
  final Function selectCamera;
  final Function selectGallery;

  const BottomSheetImageSource(
      {Key? key, required this.selectCamera, required this.selectGallery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: Padding(
        padding: EdgeInsets.only(
          left: context.screenWidth * 0.2,
          right: context.screenWidth * 0.2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => selectCamera(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: AppImagesPath.cameraIcon.image(),
                  ),
                  context.sizeH(2),
                  TextWidget(
                    msg: 'Camera',
                    font: FontMixin.mediumFamily,
                    fontWeight: FontMixin.fontWeightMedium,
                    textSize: 18,
                    color: AppColors.color080809,
                  )
                ],
              ),
            ),
            context.sizeW(10),
            InkWell(
              onTap: () => selectGallery(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: AppImagesPath.galleryIcon.image(),
                  ),
                  context.sizeH(2),
                  TextWidget(
                    msg: 'Gallery',
                    font: FontMixin.mediumFamily,
                    fontWeight: FontMixin.fontWeightMedium,
                    textSize: 18,
                    color: AppColors.color080809,
                  )
                ],
              ),
            ),
          ],
        ).center(),
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double radius;
  final bool shadow;
  final bool withPadding;
  final Clip clipBehavior;

  const RoundedContainer({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.height,
    this.radius = 32.0,
    this.shadow = false,
    this.withPadding = true,
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Container(
        clipBehavior: clipBehavior,
        height: height,
        padding: withPadding ? const EdgeInsets.all(8.0) : null,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            (shadow)
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                : const BoxShadow()
          ],
        ),
        child: child,
      ),
    );
  }
}
