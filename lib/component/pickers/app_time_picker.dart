import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTimePicker {
  /// Shows an iOS-style (Cupertino) time picker in a beautiful bottom sheet.
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
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return Container(
          height: 320,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        cancelText,
                        style: TextStyle(
                          color: cancelColor ?? Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(selectedDateTime),
                      child: Text(
                        confirmText,
                        style: TextStyle(
                          color: confirmColor ?? theme.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Divider(height: 1),
              
              // Cupertino Time Picker
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: isDark ? Brightness.dark : Brightness.light,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 22,
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
