import 'package:intl/intl.dart';

class CurrencyHelper {
  static final NumberFormat _formatter = NumberFormat.currency(
    symbol: 'KES ',
    decimalDigits: 0,
  );

  static String format(double amount) {
    return _formatter.format(amount);
  }
}
