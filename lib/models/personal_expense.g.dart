// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_expense.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class PersonalExpense extends $PersonalExpense
    with RealmEntity, RealmObjectBase, RealmObject {
  PersonalExpense(
    ObjectId id,
    double amount,
    DateTime date,
    String image, {
    String? description,
    String? groupExpense,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'groupExpense', groupExpense);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'image', image);
  }

  PersonalExpense._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get groupExpense =>
      RealmObjectBase.get<String>(this, 'groupExpense') as String?;
  @override
  set groupExpense(String? value) =>
      RealmObjectBase.set(this, 'groupExpense', value);

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => throw RealmUnsupportedSetError();

  @override
  String get image => RealmObjectBase.get<String>(this, 'image') as String;
  @override
  set image(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<PersonalExpense>> get changes =>
      RealmObjectBase.getChanges<PersonalExpense>(this);

  @override
  PersonalExpense freeze() =>
      RealmObjectBase.freezeObject<PersonalExpense>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PersonalExpense._);
    return const SchemaObject(
        ObjectType.realmObject, PersonalExpense, 'PersonalExpense', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('groupExpense', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.timestamp),
      SchemaProperty('image', RealmPropertyType.string),
    ]);
  }
}
