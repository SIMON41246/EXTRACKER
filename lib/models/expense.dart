import 'package:expenses/app/constants.dart';
import 'package:expenses/models/category.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
part 'expense.g.dart';


@RealmModel()
class $Expense {
  @PrimaryKey()
  late final ObjectId id;
  late double amount;
  late String? note;
  late $Category? category;
  late final DateTime date;
  late final String? recurrence = Recurrence.none;

  get dayInWeek {
    DateFormat format = DateFormat("EEEE");
    return format.format(date);
  }

  get dayInMonth {
    return date.day;
  }

  get month {
    DateFormat format = DateFormat("MMM");
    return format.format(date);
  }

  get year {
    return date.year;
  }
}
