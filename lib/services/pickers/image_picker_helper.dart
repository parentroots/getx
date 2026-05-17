import 'package:image_picker/image_picker.dart';

abstract final class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) {
    return _picker.pickImage(source: source, imageQuality: 85);
  }

  static Future<List<XFile>> pickMultipleImages() =>
      _picker.pickMultiImage(imageQuality: 85);
}
