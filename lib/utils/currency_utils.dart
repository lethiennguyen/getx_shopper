import 'package:intl/intl.dart';

class CurrencyUtils {
  static final NumberFormat _currencyFormatter = NumberFormat('#,##0', 'vi_VN');

  static String formatPriceDigits(int price) {
    String formatted = _currencyFormatter.format(price);

    // chỉ lấy số
    String onlyDigits = formatted.replaceAll(RegExp(r'\D'), '');

    // Nếu dài quá thì cắt bớt
    if (onlyDigits.length > 9) {
      return '${formatted.substring(0, 9)}... VNĐ';
    }
    return '$formatted VNĐ';
  }

  static String formatPrice(int price) {
    String formatted = _currencyFormatter.format(price);
    return '$formatted VNĐ';
  }
}
