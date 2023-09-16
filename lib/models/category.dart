import 'dart:ui';
import 'package:realm/realm.dart';
part 'category.g.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  late String name;
  late int colorvalue;

  set color(Color value) {
    colorvalue = value.value;
  }

  Color get color {
    return Color(colorvalue);
  }
}
