import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/app_text.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.activeColor,
    this.tileColor,
    this.selectedTileColor,
    this.shape,
    this.contentPadding,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String title;
  final String? subtitle;
  
  final Color? activeColor;
  final Color? tileColor;
  final Color? selectedTileColor;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultTileColor = tileColor ?? Colors.transparent;
    final defaultSelectedTileColor = selectedTileColor ?? 
        (isDark ? theme.primaryColor.withOpacity(0.15) : theme.primaryColor.withOpacity(0.05));

    return Theme(
      data: theme.copyWith(
        splashColor: theme.primaryColor.withOpacity(0.1),
        highlightColor: theme.primaryColor.withOpacity(0.05),
      ),
      child: RadioListTile<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: activeColor ?? theme.primaryColor,
        tileColor: isSelected ? defaultSelectedTileColor : defaultTileColor,
        shape: shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        title: AppText(
          title,
          variant: TextVariant.title,
          weight: isSelected ? TextWeight.medium : TextWeight.regular,
        ),
        subtitle: subtitle != null
            ? AppText(
                subtitle!,
                variant: TextVariant.body,
                color: Colors.grey,
              )
            : null,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}

class AppMultiRadio<T> extends StatelessWidget {
  const AppMultiRadio({
    super.key,
    required this.items,
    required this.groupValue,
    required this.onChanged,
    this.itemTitleBuilder,
    this.itemSubtitleBuilder,
    this.activeColor,
    this.separator,
  });

  final List<T> items;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String Function(T)? itemTitleBuilder;
  final String? Function(T)? itemSubtitleBuilder;
  final Color? activeColor;
  final Widget? separator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(items.length, (index) {
        final item = items[index];
        final title = itemTitleBuilder != null ? itemTitleBuilder!(item) : item.toString();
        final subtitle = itemSubtitleBuilder?.call(item);

        final radio = AppRadio<T>(
          value: item,
          groupValue: groupValue,
          onChanged: onChanged,
          title: title,
          subtitle: subtitle,
          activeColor: activeColor,
        );

        if (separator != null && index < items.length - 1) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              radio,
              separator!,
            ],
          );
        }

        return radio;
      }),
    );
  }
}
