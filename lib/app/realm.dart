import 'package:expenses/models/balance.dart';
import 'package:expenses/models/category.dart';
import 'package:expenses/models/expense.dart';
import 'package:realm/realm.dart';

var config = Configuration.local([Category.schema, Expense.schema,Balance.schema]);
var realm = Realm(config);
