import 'package:flutter/material.dart';

class CountryModel {
  final String name;
  final String code;
  final String dialCode;
  final String flagEmoji;

  const CountryModel({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flagEmoji,
  });
}

const List<CountryModel> _defaultCountries = [
  CountryModel(name: 'United States', code: 'US', dialCode: '+1', flagEmoji: '🇺🇸'),
  CountryModel(name: 'United Kingdom', code: 'GB', dialCode: '+44', flagEmoji: '🇬🇧'),
  CountryModel(name: 'Bangladesh', code: 'BD', dialCode: '+880', flagEmoji: '🇧🇩'),
  CountryModel(name: 'India', code: 'IN', dialCode: '+91', flagEmoji: '🇮🇳'),
  CountryModel(name: 'Canada', code: 'CA', dialCode: '+1', flagEmoji: '🇨🇦'),
  CountryModel(name: 'Australia', code: 'AU', dialCode: '+61', flagEmoji: '🇦🇺'),
  CountryModel(name: 'Germany', code: 'DE', dialCode: '+49', flagEmoji: '🇩🇪'),
  CountryModel(name: 'France', code: 'FR', dialCode: '+33', flagEmoji: '🇫🇷'),
  CountryModel(name: 'Japan', code: 'JP', dialCode: '+81', flagEmoji: '🇯🇵'),
  // Add more as needed or pass a full list dynamically.
];

class AppCountryPicker {
  /// Shows a beautiful, searchable bottom sheet to select a country.
  static Future<CountryModel?> show({
    required BuildContext context,
    List<CountryModel>? customCountries,
    String title = 'Select Country',
    String searchHint = 'Search...',
    Color? primaryColor,
  }) async {
    final List<CountryModel> countries = customCountries ?? _defaultCountries;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return showModalBottomSheet<CountryModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builderContext) {
        return _CountryPickerBottomSheet(
          countries: countries,
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
  final String title;
  final String searchHint;
  final bool isDark;
  final Color primaryColor;

  const _CountryPickerBottomSheet({
    required this.countries,
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

  @override
  void initState() {
    super.initState();
    _filteredCountries = widget.countries;
  }

  void _filter(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCountries = widget.countries;
      });
    } else {
      setState(() {
        _filteredCountries = widget.countries
            .where((c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.dialCode.contains(query) ||
                c.code.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: widget.isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 16),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Title
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: widget.searchHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: widget.isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Country List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return ListTile(
                  leading: Text(
                    country.flagEmoji,
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(country.name),
                  trailing: Text(
                    country.dialCode,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(country);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
