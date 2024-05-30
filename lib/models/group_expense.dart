import 'package:realm/realm.dart';
part 'group_expense.g.dart';

@RealmModel()
class $GroupExpense {
  @PrimaryKey()
  late String category;
  late String Description;
  late String image;

}
