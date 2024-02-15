import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/mixin/dev.mixin.dart';
import '../../../../../utils/widget/image_picker_widget.dart';
import '../../../../../utils/widget/toast_widget.dart';

class ImagePickerProvider extends ChangeNotifier {
  final _imagePicker = ImagePicker();
  dynamic _imagePickerError;
  XFile? _imageFile;

  // set the image file
  set setImageFile(XFile? file) {
    _imageFile = file;
    notifyListeners();
  }

  // Set the image error
  set setImageError(err) {
    _imagePickerError = err;
    notifyListeners();
  }

  // getter
  XFile? get imageFile => _imageFile;

  String get imageFilePath => _imageFile?.path ?? '';

  dynamic get imagePickerError => _imagePickerError;

  ImagePicker get imagePicker => _imagePicker;

  //
  /// [Widget] TO SHOW THE IMAGE PICKER
  Future<String> showImagePicker({required BuildContext context}) async {
    ImagePickerHelper.showPicker(
      context: context,
      imagePicker: _imagePicker,
      successCallBack: (file) {
        setImageFile = file;
        Dev.log('${file?.name}:${file?.path}');
        return file!.path;
      },
      failedCallBack: (error) {
        Dev.log(error);
        showToast(message: error);
        setImageError = error;
        setImageFile = null;
        return '';
      },
    );
    return '';
  }
}
