import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isToday() {
    final today = DateTime.now();
    return today.year == year && today.month == month && today.day == day;
  }

  bool isYesturday() {
    final yesturday = DateTime.now().subtract(const Duration(days: 1));
    return yesturday.year == year &&
        yesturday.month == month &&
        yesturday.day == day;
  }

  bool isBetween(DateTime startDate, DateTime endDate) {
    return isAfter(startDate) && isBefore(endDate);
  }

  get formatedTime {
    DateFormat format;
    if (year != DateTime.now().year) {
      format = DateFormat("E, d MMM yyyy");
    } else if (isToday()) {
      return "Today";
    } else if (isYesturday()) {
      return "Yesterday";
    } else {
      format = DateFormat("E, d MMM");
    }
    return format.format(this);
  }

  get shortDate {
    DateFormat format = DateFormat("d MMM");
    return format.format(this);
  }

  get simpleDate {
    return DateTime(year, month, day);
  }

  get nameOfDay {
    DateFormat format = DateFormat("EEEE");
    return format.format(this);
  }

  get time {
    DateFormat format = DateFormat("HH:mm");
    return format.format(this);
  }
}
