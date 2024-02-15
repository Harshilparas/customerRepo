import 'package:country_code_picker/country_code_picker.dart';
import 'package:deride_user/utils/app_constant/app_colors.dart';
import 'package:deride_user/utils/app_constant/app_image_strings.dart';

import 'package:deride_user/utils/fonts.dart';
import 'package:deride_user/utils/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextfeild extends StatefulWidget {
  final FocusNode? focusNode;
  String? msg;
  String? tittle;
  String? font;
  bool obscureText;
  bool? isPassword;
  TextEditingController? editController;
  double? textSize;
  String? image;
  String? selectedImage;
  String? backImage = "";
  Color? color;
  Color? hintColor;
  VoidCallback? onChange;
  VoidCallback? onTap;
  final ValueChanged<String>? onChangeText;
  TextInputType? textInputType = TextInputType.none;
  bool? isEnable = true;
  bool? isDropDown = false;
  int? length = 100;
  double? heightBox = 55;
  int? maxLine;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;

  CommonTextfeild(
      {Key? key,
      this.msg,
      this.tittle,
      this.isPassword,
      this.focusNode,
      this.obscureText = false,
      this.validator,
      this.heightBox,
      this.onSaved,
      this.font,
      this.editController,
      this.textSize,
      this.image,
      this.color,
      this.selectedImage,
      this.onChange,
      this.onTap,
      this.textInputType,
      this.isEnable,
      this.backImage,
      this.length,
      this.isDropDown,
      this.onChangeText,
      this.hintColor,
      this.maxLine})
      : super(key: key);

  @override
  State<CommonTextfeild> createState() => _CommonTextfeildState();
}

class _CommonTextfeildState extends State<CommonTextfeild> {
  final bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.tittle != null,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 0),
                child: TextWidget(
                  msg: widget.tittle ?? "",
                  color: AppColors.color5E6D55,
                  font: FontMixin.regularFamily,
                  textSize: 14.0,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                      focusNode: widget.focusNode,
                       textCapitalization: TextCapitalization.words,
                      validator: widget.validator,
                      onSaved: widget.onSaved,
                      controller: widget.editController,
                      keyboardType: widget.textInputType,
                      onChanged: widget.onChangeText,
                      maxLines: widget.maxLine ?? 1,
                      enabled: widget.isEnable,
                      obscureText: widget.obscureText,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(widget.length),
                      ],
                      style: TextStyle(
                          fontFamily: widget.font,
                          fontSize: widget.textSize,
                          color: widget.color),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.msg,
                        hintStyle: TextStyle(
                          fontFamily: FontMixin.mediumFamily,
                          fontWeight: FontMixin.fontWeightMedium,
                          fontSize: 13.0,
                          color: widget.hintColor ?? AppColors.color001E00,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      )),
                ),
                Visibility(
                  visible: widget.isPassword ?? false,
                  child: InkWell(
                    onTap: widget.onChange,
                    child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: widget.obscureText
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: AppColors.color292D32,
                              )
                            : const Icon(
                                Icons.remove_red_eye,
                                color: AppColors.color292D32,
                              )),
                  ),
                ),
                Visibility(
                  visible: widget.isDropDown!,
                  child: InkWell(
                    onTap: widget.onChange,
                    child: Image.asset(
                      AppImagesPath.dropDownIcon,
                      height: 15,
                      width: 15,
                      color: AppColors.color001E00,
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 1,
              color: AppColors.colorD2D2D2,
            )
          ],
        ),
      ),
    );
  }
}

///
class CommonTextfeildPhone extends StatefulWidget {
  final FocusNode? focusNode;
  String? msg;
  String? tittle;
  String? font;
  bool obscureText;
  bool? isPassword;
  TextEditingController? editController;
  double? textSize;
  String? image;
  String? selectedImage;
  String? backImage = "";
  Color? color;
  Color? hintColor;
  void Function(dynamic)? onChange;
  VoidCallback? onTap;
  final ValueChanged<String>? onChangeText;
  TextInputType? textInputType = TextInputType.none;
  bool? isEnable = true;
  bool? isDropDown = false;
  int? length = 100;
  double? heightBox = 55;
  int? maxLine;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  String? initailSeelection;

  CommonTextfeildPhone(
      {Key? key,
      this.msg,
      this.tittle,
      this.isPassword,
      this.focusNode,
      this.obscureText = false,
        this.initailSeelection,
      this.validator,
      this.heightBox,
      this.onSaved,
      this.font,
      this.editController,
      this.textSize,
      this.image,
      this.color,
      this.selectedImage,
      this.onChange,
      this.onTap,
      this.textInputType,
      this.isEnable,
      this.backImage,
      this.length,
      this.isDropDown,
      this.onChangeText,
      this.hintColor,

      this.maxLine})
      : super(key: key);

  @override
  State<CommonTextfeildPhone> createState() => _CommonTextfeildPhoneState();
}

class _CommonTextfeildPhoneState extends State<CommonTextfeildPhone> {
  final bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.tittle != null,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 0),
                child: TextWidget(
                  msg: widget.tittle ?? "",
                  color: AppColors.color5E6D55,
                  font: FontMixin.regularFamily,
                  textSize: 14.0,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CountryCodePicker(
                  initialSelection:  widget.initailSeelection??'IT',
                  favorite: const ['+1', 'CA'],
                  showDropDownButton: true,
                  flagWidth: 20,
                  onChanged: widget.onChange!,
                ),
                Expanded(
                  child: TextFormField(
                      focusNode: widget.focusNode,
                      validator: widget.validator,
                      onSaved: widget.onSaved,
                      controller: widget.editController,
                      keyboardType: widget.textInputType,
                      onChanged: widget.onChangeText,
                      maxLines: widget.maxLine ?? 1,
                      enabled: widget.isEnable,
                      obscureText: widget.obscureText,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(widget.length),
                      ],
                      style: TextStyle(
                          fontFamily: widget.font,
                          fontSize: widget.textSize,
                          color: widget.color),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.msg,
                        hintStyle: TextStyle(
                          fontFamily: FontMixin.mediumFamily,
                          fontWeight: FontMixin.fontWeightMedium,
                          fontSize: 13.0,
                          color: widget.hintColor ?? AppColors.color001E00,
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      )),
                ),
              ],
            ),
            Container(
              height: 1,
              color: AppColors.colorD2D2D2,
            )
          ],
        ),
      ),
    );
  }
}

//
class CommonDropDown extends StatelessWidget {
  String? hint;
  String? selected;

  List<String>? list;
  String? tittle;

  Function(String) onCallBack;
  CommonDropDown(
      {Key? key,
      this.selected,
      this.list,
      this.hint,
      required this.onCallBack,
      required this.tittle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: TextWidget(
            msg: tittle ?? "",
            color: AppColors.color5E6D55,
            font: FontMixin.regularFamily,
            textSize: 14.0,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(hint!),
            value: selected,
            iconSize: 10.0,
            icon: Image.asset(
              AppImagesPath.dropDownIcon,
              height: 15,
              width: 15,
            ),
            iconEnabledColor: Colors.black,
            style: const TextStyle(
                fontFamily: FontMixin.mediumFamily,
                fontSize: 13.0,
                color: AppColors.color001E00,
                fontWeight: FontWeight.w500),
            underline: const SizedBox(),
            onChanged: (c) {
              print(c);
              onCallBack(c!);
            },
            items: list!.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            height: 1,
            color: AppColors.colorD2D2D2,
          ),
        )
      ],
    );
  }
}
