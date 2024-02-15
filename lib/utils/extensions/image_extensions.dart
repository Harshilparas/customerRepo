//TODO:EXTENSION_SVG_PICTURE
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// Emit a svg picture
/// [Widget]
///  This widget is used to show svg picture
//
extension SVGExtension on String {
  Widget get svg {
    return SvgPicture.asset(
      this,
      fit: BoxFit.fill,
      semanticsLabel: 'SVG Image',
    );
  }
}

//TODO: EXTENSION_IMAGE_
extension ImageExtension on String {
  Widget image({BoxFit? fit}) {
    return Image.asset(
      this,
      fit: fit,
    );
  }
}
