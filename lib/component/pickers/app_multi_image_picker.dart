import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:image_picker/image_picker.dart';

class AppMultiImagePicker extends StatefulWidget {
  const AppMultiImagePicker({
    super.key,
    required this.onImagesChanged,
    this.initialImages = const [],
    this.maxImages = 10,
    this.imageQuality = 70, // Memory management: Compress image quality
    this.maxWidth = 1080,   // Memory management: Resize huge images
    this.maxHeight = 1080,
    this.crossAxisCount = 3,
    this.spacing = 8.0,
    this.imageSize = 100.0,
    this.addButtonWidget,
    this.errorColor = Colors.red,
  });

  final Function(List<File>) onImagesChanged;
  final List<File> initialImages;
  final int maxImages;
  final int imageQuality;
  final double maxWidth;
  final double maxHeight;
  
  final int crossAxisCount;
  final double spacing;
  final double imageSize;
  
  final Widget? addButtonWidget;
  final Color errorColor;

  @override
  State<AppMultiImagePicker> createState() => _AppMultiImagePickerState();
}

class _AppMultiImagePickerState extends State<AppMultiImagePicker> {
  late List<File> _selectedImages;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedImages = List.from(widget.initialImages);
  }

  Future<void> _pickImages() async {
    if (_selectedImages.length >= widget.maxImages) return;

    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: widget.imageQuality,
        maxWidth: widget.maxWidth,
        maxHeight: widget.maxHeight,
      );

      if (pickedFiles.isNotEmpty) {
        int remainingSlots = widget.maxImages - _selectedImages.length;
        List<XFile> allowedFiles = pickedFiles.take(remainingSlots).toList();

        setState(() {
          _selectedImages.addAll(allowedFiles.map((xfile) => File(xfile.path)));
        });

        widget.onImagesChanged(_selectedImages);
      }
    } catch (e) {
      debugPrint("Error picking images: $e");
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
    widget.onImagesChanged(_selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing.w,
      runSpacing: widget.spacing.h,
      children: [
        ...List.generate(_selectedImages.length, (index) {
          return _buildImageItem(index);
        }),
        if (_selectedImages.length < widget.maxImages)
          _buildAddButton(),
      ],
    );
  }

  Widget _buildImageItem(int index) {
    final responsiveSize = widget.imageSize.w;
    return Stack(
      children: [
        Container(
          width: responsiveSize,
          height: responsiveSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade300, width: 1.r),
            image: DecorationImage(
              image: FileImage(_selectedImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4.h,
          right: 4.w,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 16.r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    final responsiveSize = widget.imageSize.w;
    return GestureDetector(
      onTap: _pickImages,
      child: widget.addButtonWidget ?? Container(
        width: responsiveSize,
        height: responsiveSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid, width: 1.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, size: 32.r, color: Colors.grey.shade600),
            SizedBox(height: 8.h),
            AppText(
              '${_selectedImages.length}/${widget.maxImages}',
              variant: TextVariant.caption,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
