import 'package:intl/intl.dart';

class DateTimeHelper {
  static bool isExpired(String datetime) {
    final now = DateTime.now();
    final format = DateFormat('yyyy-MM-dd HH:mm:ss');

    var date = format.parseStrict(datetime);
    return now.isAfter(date);
  }
}
