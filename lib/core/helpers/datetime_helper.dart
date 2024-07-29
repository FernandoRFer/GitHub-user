import 'package:intl/intl.dart';

abstract class AppDateTimeHelper {
  static const defaultFormat = "dd/MM/yyyy HH:mm:ss";

  static String getFormattedDateTimeNow({String? format = defaultFormat}) {
    return DateFormat(format, "pt_BR").format(DateTime.now());
  }

  static String dateTimeFormat(String? date, {String? format = defaultFormat}) {
    try {
      if (date != null) {
        return DateFormat(
          format,
        ).format(DateTime.parse(date));
      }
      return "";
    } on Exception {
      return "Formato de data inválido";
    }
  }
}
