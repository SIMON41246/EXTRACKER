// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_expense.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class GroupExpense extends $GroupExpense
    with RealmEntity, RealmObjectBase, RealmObject {
  GroupExpense(
    String category,
    String Description,
    String image,
  ) {
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'Description', Description);
    RealmObjectBase.set(this, 'image', image);
  }

  GroupExpense._();

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get Description =>
      RealmObjectBase.get<String>(this, 'Description') as String;
  @override
  set Description(String value) =>
      RealmObjectBase.set(this, 'Description', value);

  @override
  String get image => RealmObjectBase.get<String>(this, 'image') as String;
  @override
  set image(String value) => RealmObjectBase.set(this, 'image', value);

  @override
  Stream<RealmObjectChanges<GroupExpense>> get changes =>
      RealmObjectBase.getChanges<GroupExpense>(this);

  @override
  GroupExpense freeze() => RealmObjectBase.freezeObject<GroupExpense>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(GroupExpense._);
    return const SchemaObject(
        ObjectType.realmObject, GroupExpense, 'GroupExpense', [
      SchemaProperty('category', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('Description', RealmPropertyType.string),
      SchemaProperty('image', RealmPropertyType.string),
    ]);
  }
}
