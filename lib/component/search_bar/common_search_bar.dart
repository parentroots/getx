import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/utils/helper/debouncer.dart';

/// A premium, highly customizable Search Bar widget.
/// Integrates a built-in debouncer to optimize typing changes,
/// and supports extensive visual styling (borders, heights, colors, leading/trailing actions).
class CommonSearchBar extends StatefulWidget {
  const CommonSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onCleared,
    this.hintText = 'Search',
    this.debounceMilliseconds = 400,
    this.backgroundColor,
    this.elevation = 0.0,
    this.borderRadius = 12.0,
    this.padding,
    this.margin,
    this.width,
    this.height = 48.0,
    this.autoFocus = false,
    this.enabled = true,
    this.focusNode,
    this.textStyle,
    this.hintStyle,
    this.leading,
    this.trailing,
  });

  /// Optional text controller. If omitted, a local controller is managed internally.
  final TextEditingController? controller;

  /// Callback when text changes. If [debounceMilliseconds] is > 0, this callback is debounced.
  final ValueChanged<String>? onChanged;

  /// Callback when the keyboard search action is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Callback when the input is cleared using the close button.
  final VoidCallback? onCleared;

  /// Input placeholder text.
  final String hintText;

  /// Number of milliseconds to delay the [onChanged] callback. Set to 0 to disable debouncing.
  final int debounceMilliseconds;

  /// Fill background color of the search bar.
  final Color? backgroundColor;

  /// Shadow elevation (defaults to 0.0).
  final double elevation;

  /// Corner radius of the search bar (defaults to 12.0).
  final double borderRadius;

  /// Internal padding inside the search bar boundary.
  final EdgeInsetsGeometry? padding;

  /// Outer margin/padding surrounding the search bar.
  final EdgeInsetsGeometry? margin;

  /// Total width of the search bar.
  final double? width;

  /// Height of the search bar (defaults to 48.0).
  final double? height;

  /// Auto-focus the input field on layout load.
  final bool autoFocus;

  /// Enable or disable input actions.
  final bool enabled;

  /// Custom focus controller.
  final FocusNode? focusNode;

  /// Input text styling.
  final TextStyle? textStyle;

  /// Placeholder hint text styling.
  final TextStyle? hintStyle;

  /// Custom prefix widget (defaults to a search magnifying glass).
  final Widget? leading;

  /// Custom actions appended to the trailing edge.
  final List<Widget>? trailing;

  @override
  State<CommonSearchBar> createState() => _CommonSearchBarState();
}

class _CommonSearchBarState extends State<CommonSearchBar> {
  late TextEditingController _controller;
  bool _isLocalController = false;
  Debouncer? _debouncer;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = TextEditingController();
      _isLocalController = true;
    } else {
      _controller = widget.controller!;
    }

    _controller.addListener(_onTextChanged);

    if (widget.debounceMilliseconds > 0) {
      _debouncer = Debouncer(
        delay: Duration(milliseconds: widget.debounceMilliseconds),
      );
    }
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void didUpdateWidget(CommonSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.debounceMilliseconds != oldWidget.debounceMilliseconds) {
      _debouncer?.dispose();
      if (widget.debounceMilliseconds > 0) {
        _debouncer = Debouncer(
          delay: Duration(milliseconds: widget.debounceMilliseconds),
        );
      } else {
        _debouncer = null;
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (_isLocalController) {
      _controller.dispose();
    }
    _debouncer?.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    if (_debouncer != null) {
      _debouncer!(() {
        widget.onChanged?.call(value);
      });
    } else {
      widget.onChanged?.call(value);
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultBgColor = widget.backgroundColor ?? context.appColors.border;
    final resolvedRadius = BorderRadius.circular(widget.borderRadius.r);

    final searchBarStyle = ButtonStyle(
      backgroundColor: WidgetStateProperty.all(defaultBgColor),
      elevation: WidgetStateProperty.all(widget.elevation),
      padding: WidgetStateProperty.all(
        widget.padding ?? EdgeInsets.symmetric(horizontal: 12.w),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: resolvedRadius),
      ),
    );

    Widget searchBar = SearchBar(
      controller: _controller,
      focusNode: widget.focusNode,
      autoFocus: widget.autoFocus,
      onChanged: _handleChanged,
      onSubmitted: widget.onSubmitted,
      hintText: widget.hintText,
      hintStyle: WidgetStateProperty.all(
        widget.hintStyle ??
            theme.textTheme.bodyMedium?.copyWith(
              color: context.appColors.textColor.withOpacity(0.5),
            ),
      ),
      textStyle: WidgetStateProperty.all(
        widget.textStyle ?? theme.textTheme.bodyMedium,
      ),
      leading: widget.leading ?? Icon(Icons.search, color: context.appColors.textColor),
      trailing: [
        if (_controller.text.isNotEmpty && widget.enabled)
          IconButton(
            tooltip: 'Clear',
            onPressed: () {
              _controller.clear();
              widget.onChanged?.call('');
              widget.onCleared?.call();
            },
            icon: Icon(Icons.close, color: context.appColors.textColor  ),
          ),
        ...?widget.trailing,
      ],

    );

    if (widget.height != null || widget.width != null) {
      searchBar = SizedBox(
        width: widget.width?.w,
        height: widget.height?.h,
        child: searchBar,
      );
    }

    if (widget.margin != null) {
      searchBar = Padding(
        padding: widget.margin!,
        child: searchBar,
      );
    }

    return searchBar;
  }
}
