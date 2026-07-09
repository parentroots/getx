import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static String date(DateTime value) =>
      DateFormat.yMMMd().format(value);

  static String time(DateTime value) =>
      DateFormat.jm().format(value);

  static String dateTime(DateTime value) =>
      DateFormat.yMMMd().add_jm().format(value);

  static String apiDate(DateTime value) =>
      DateFormat('yyyy-MM-dd').format(value);
}
