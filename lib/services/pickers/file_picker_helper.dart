import 'package:file_picker/file_picker.dart';

abstract final class FilePickerHelper {
  static Future<FilePickerResult?> pick({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) {
    return FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );
  }
}
