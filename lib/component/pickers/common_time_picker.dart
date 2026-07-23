import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

/// A premium, responsive iOS-style (Cupertino) time picker
/// displayed in a beautifully styled and dark-mode-ready bottom sheet.
class CommonTimePicker {
  /// Shows an iOS-style time picker in a custom bottom sheet.
  static Future<TimeOfDay?> show({
    required BuildContext context,
    TimeOfDay? initialTime,
    String title = 'Select Time',
    String confirmText = 'Done',
    String cancelText = 'Cancel',
    Color? confirmColor,
    Color? cancelColor,
    int minuteInterval = 1,
  }) async {
    final now = DateTime.now();
    DateTime selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      initialTime?.hour ?? now.hour,
      initialTime?.minute ?? now.minute,
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final DateTime? result = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: context.appColors.transparent,
      isScrollControlled: true,
      builder: (BuildContext builder) {
        return Container(
          height: 320.h,
          decoration: BoxDecoration(
            color: context.appColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: context.appColors.black.withValues(alpha: 0.1),
                blurRadius: 10.r,
                offset: Offset(0, -5.r),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                height: 4.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: context.appColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              
              // Header actions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: CommonText(
                        cancelText,
                        style: context.textTheme.bodyMedium,
                        color: cancelColor ?? context.appColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CommonText(
                      title,
                      style: context.textTheme.titleMedium,
                      fontWeight: FontWeight.bold,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(selectedDateTime),
                      child: CommonText(
                        confirmText,
                        style: context.textTheme.bodyMedium,
                        color: confirmColor ?? context.appColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              Divider(height: 1.h, thickness: 1.r),
              
              // Cupertino Time Picker
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: isDark ? Brightness.dark : Brightness.light,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: context.appColors.text,
                        fontSize: 22.sp,
                        fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: selectedDateTime,
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: false,
                    minuteInterval: minuteInterval,
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDateTime = newDate;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      return TimeOfDay.fromDateTime(result);
    }
    return null;
  }
}
