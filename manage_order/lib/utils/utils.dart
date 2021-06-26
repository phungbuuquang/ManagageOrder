import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(
    int value, {
    int fractionDigits = 0,
  }) {
    ArgumentError.checkNotNull(value, 'value');

    return NumberFormat.currency(
            customPattern: '###,###',
            // using Netherlands because this country also
            // uses the comma for thousands and dot for decimal separators.
            locale: 'vi_VN')
        .format(value);
  }
}
