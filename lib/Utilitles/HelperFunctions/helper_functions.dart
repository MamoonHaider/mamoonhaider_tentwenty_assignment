import 'package:intl/intl.dart';

class HelperFunctions {
  static String formatDateToMonthName(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final formatter = DateFormat('MMMM dd, yyyy');
      return formatter.format(date);
    } catch (e) {
      return dateStr;
    }
  }
}
