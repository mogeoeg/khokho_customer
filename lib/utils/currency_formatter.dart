import 'package:intl/intl.dart';

class CurrencyFormatter {
  // Format amount in Indian currency
  static String format(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: amount % 1 == 0 ? 0 : 2, // 0 decimals for whole numbers
    );
    return formatter.format(amount);
  }
}
