import 'package:expenses/models/balance.dart';
import 'package:expenses/models/group_expense.dart';
import 'package:expenses/models/personal_expense.dart';
import 'package:realm/realm.dart';

var config = Configuration.local(
    [PersonalExpense.schema, GroupExpense.schema, Balance.schema]);
var realm = Realm(config);
