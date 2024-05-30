import 'package:expenses/app/constants.dart';
import 'package:expenses/models/group_expense.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
part 'personal_expense.g.dart';


@RealmModel()
class $PersonalExpense {
  @PrimaryKey()
  late final ObjectId id;
  late double amount;
  late String? description;
  late String? groupExpense;
  late final DateTime date;
  late final String image;

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
