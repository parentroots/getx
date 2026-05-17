import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = 'Search',
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      onChanged: onChanged,
      hintText: hintText,
      leading: const Icon(Icons.search),
      trailing: [
        if (controller?.text.isNotEmpty ?? false)
          IconButton(
            tooltip: 'Clear',
            onPressed: controller?.clear,
            icon: const Icon(Icons.close),
          ),
      ],
    );
  }
}
