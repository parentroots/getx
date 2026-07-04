import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:getx_template/component/layout/common_text.dart';

/// A country model containing dialing details and matching flag emoji.
class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String flagEmoji;

  CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flagEmoji,
  });
}

class CommonCountryPicker {
  /// Shows a beautiful, searchable bottom sheet to select a country.
  static Future<CountryModel?> show({
    required BuildContext context,
    List<CountryModel>? customCountries,
    String? selectedCountryCode,
    String title = 'Select Country',
    String searchHint = 'Search by name, code or dial code...',
    Color? primaryColor,
  }) async {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Load countries dynamically from the package
    final List<CountryModel> countries = customCountries ??
        CountryService().getAll().map((c) {
          return CountryModel(
            name: c.name,
            code: c.countryCode,
            dialCode: '+${c.phoneCode}',
            flagEmoji: c.flagEmoji,
          );
        }).toList();

    return showModalBottomSheet<CountryModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (BuildContext builderContext) {
        return _CountryPickerBottomSheet(
          countries: countries,
          selectedCountryCode: selectedCountryCode,
          title: title,
          searchHint: searchHint,
          isDark: isDark,
          primaryColor: primaryColor ?? theme.primaryColor,
        );
      },
    );
  }
}

class _CountryPickerBottomSheet extends StatefulWidget {
  final List<CountryModel> countries;
  final String? selectedCountryCode;
  final String title;
  final String searchHint;
  final bool isDark;
  final Color primaryColor;

  const _CountryPickerBottomSheet({
    required this.countries,
    this.selectedCountryCode,
    required this.title,
    required this.searchHint,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  State<_CountryPickerBottomSheet> createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<_CountryPickerBottomSheet> {
  late List<CountryModel> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  // Popular countries shortcuts
  late List<CountryModel> _popularCountries;

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
    
    // Define popular countries from the list (e.g. BD, US, GB, IN, CA, AU, AE)
    final popularCodes = {'BD', 'US', 'GB', 'IN', 'CA', 'AU', 'AE'};
    _popularCountries = widget.countries
        .where((c) => popularCodes.contains(c.code.toUpperCase()))
        .toList();
    
    // Sort popular countries to match the order of popularCodes
    final orderList = ['BD', 'US', 'GB', 'IN', 'CA', 'AU', 'AE'];
    _popularCountries.sort((a, b) {
      return orderList.indexOf(a.code.toUpperCase()).compareTo(
            orderList.indexOf(b.code.toUpperCase()),
          );
    });
  }

  void _filter(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCountries = widget.countries;
      } else {
        final lowercaseQuery = query.toLowerCase();
        _filteredCountries = widget.countries.where((c) {
          return c.name.toLowerCase().contains(lowercaseQuery) ||
              c.dialCode.contains(query) ||
              c.code.toLowerCase().contains(lowercaseQuery);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildHighlightedText(
    String text,
    String query,
    TextStyle baseStyle,
    TextStyle highlightStyle,
  ) {
    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }
    final index = text.toLowerCase().indexOf(query.toLowerCase());
    if (index == -1) {
      return Text(text, style: baseStyle);
    }

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: text.substring(0, index)),
          TextSpan(
            text: text.substring(index, index + query.length),
            style: highlightStyle,
          ),
          TextSpan(text: text.substring(index + query.length)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Style configurations based on theme
    final backgroundColor = widget.isDark ? const Color(0xFF111827) : Colors.white;
    final secondaryTextColor = widget.isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final dividerColor = widget.isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final searchFillColor = widget.isDark ? const Color(0xFF1F2937) : Colors.grey.shade100;
    final highlightStyle = TextStyle(
      color: widget.primaryColor,
      fontWeight: FontWeight.bold,
    );

    // Grouping filtered countries alphabetically
    final Map<String, List<CountryModel>> groupedCountries = {};
    for (var country in _filteredCountries) {
      final firstLetter = country.name.isNotEmpty
          ? country.name[0].toUpperCase()
          : '#';
      if (RegExp(r'[A-Z]').hasMatch(firstLetter)) {
        groupedCountries.putIfAbsent(firstLetter, () => []).add(country);
      } else {
        groupedCountries.putIfAbsent('#', () => []).add(country);
      }
    }

    // Sort the keys
    final sortedKeys = groupedCountries.keys.toList()..sort();
    
    // Build flat list items for display
    final List<dynamic> flatListItems = [];
    for (var key in sortedKeys) {
      flatListItems.add(key); // Section Header
      flatListItems.addAll(groupedCountries[key]!); // Country Items
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.r),
          topRight: Radius.circular(28.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20.r,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag Handle bar
          Container(
            margin: EdgeInsets.only(top: 10.h, bottom: 8.h),
            height: 5.h,
            width: 45.w,
            decoration: BoxDecoration(
              color: widget.isDark ? Colors.grey.shade800 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.5.r),
            ),
          ),
          
          // Header Row with Title & Close Icon
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  widget.title,
                  variant: TextVariant.title,
                  weight: TextWeight.bold,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16.r,
                      color: widget.isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Search Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: TextField(
              controller: _searchController,
              onChanged: _filter,
              style: TextStyle(
                fontSize: 15.sp,
                color: widget.isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: widget.searchHint,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade500,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade500,
                  size: 20.r,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filter('');
                        },
                        child: Icon(
                          Icons.cancel_rounded,
                          color: Colors.grey.shade500,
                          size: 20.r,
                        ),
                      )
                    : null,
                filled: true,
                fillColor: searchFillColor,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: BorderSide(
                    color: widget.primaryColor.withValues(alpha: 0.5),
                    width: 1.5.r,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Horizontal Popular Countries section (only show when not searching)
          if (_searchQuery.isEmpty && _popularCountries.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CommonText(
                  "Popular Countries",
                  variant: TextVariant.caption,
                  color: secondaryTextColor,
                  weight: TextWeight.medium,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 48.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _popularCountries.length,
                itemBuilder: (context, index) {
                  final country = _popularCountries[index];
                  final isSelected = widget.selectedCountryCode?.toUpperCase() ==
                      country.code.toUpperCase();
                  
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(country),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? widget.primaryColor.withValues(alpha: 0.15)
                              : (widget.isDark ? const Color(0xFF1F2937) : Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? widget.primaryColor
                                : (widget.isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                            width: 1.r,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              country.flagEmoji,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            SizedBox(width: 6.w),
                            CommonText(
                              country.code,
                              variant: TextVariant.body,
                              weight: isSelected ? TextWeight.bold : TextWeight.medium,
                              color: isSelected
                                  ? widget.primaryColor
                                  : (widget.isDark ? Colors.white : Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
          ],
          
          Divider(height: 1.h, thickness: 1.r, color: dividerColor),
          
          // Country List
          Expanded(
            child: flatListItems.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.public_off_rounded,
                            size: 48.r,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 12.h),
                          CommonText(
                            'No countries found matching "$_searchQuery"',
                            variant: TextVariant.body,
                            color: Colors.grey,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: flatListItems.length,
                    itemBuilder: (context, index) {
                      final item = flatListItems[index];
                      
                      // Render Section Header (Letter)
                      if (item is String) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
                          color: widget.isDark
                              ? const Color(0xFF1F2937).withValues(alpha: 0.4)
                              : Colors.grey.shade50,
                          child: CommonText(
                            item,
                            variant: TextVariant.body,
                            weight: TextWeight.bold,
                            color: widget.primaryColor,
                          ),
                        );
                      }
                      
                      // Render Country Item
                      final CountryModel country = item as CountryModel;
                      final isSelected = widget.selectedCountryCode?.toUpperCase() ==
                          country.code.toUpperCase();
                      
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop(country);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? widget.primaryColor.withValues(alpha: 0.06)
                                : Colors.transparent,
                          ),
                          child: Row(
                            children: [
                              Text(
                                country.flagEmoji,
                                style: TextStyle(fontSize: 26.sp),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: _buildHighlightedText(
                                  country.name,
                                  _searchQuery,
                                  theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: widget.isDark ? Colors.white : Colors.black87,
                                  ),
                                  highlightStyle,
                                ),
                              ),
                              CommonText(
                                country.dialCode,
                                variant: TextVariant.body,
                                color: isSelected ? widget.primaryColor : secondaryTextColor,
                                weight: isSelected ? TextWeight.bold : TextWeight.medium,
                              ),
                              if (isSelected) ...[
                                SizedBox(width: 12.w),
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: widget.primaryColor,
                                  size: 20.r,
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
