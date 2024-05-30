import 'package:realm/realm.dart';
part 'balance.g.dart';

@RealmModel()
class $Balance {
  @PrimaryKey()
  late final ObjectId id;
  late double amount;
  late DateTime dateTime;
}
