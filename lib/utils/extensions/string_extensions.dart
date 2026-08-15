extension StringExtensions on String {
  String get trimmed => trim();
  bool get isValidEmail {
    final value = trim();
    final parts = value.split('@');
    return parts.length == 2 &&
        parts.first.isNotEmpty &&
        parts.last.contains('.') &&
        !parts.last.startsWith('.') &&
        !parts.last.endsWith('.');
  }

  String capitalizeFirst() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
