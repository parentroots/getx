import 'package:file_picker/file_picker.dart';

abstract final class FilePickerHelper {
  static Future<List<PlatformFile>?> pick({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) {
    return FilePicker.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );
  }
}
