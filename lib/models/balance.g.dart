// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Balance extends $Balance with RealmEntity, RealmObjectBase, RealmObject {
  Balance(
    ObjectId id,
    double amount,
    DateTime dateTime,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'dateTime', dateTime);
  }

  Balance._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  double get amount => RealmObjectBase.get<double>(this, 'amount') as double;
  @override
  set amount(double value) => RealmObjectBase.set(this, 'amount', value);

  @override
  DateTime get dateTime =>
      RealmObjectBase.get<DateTime>(this, 'dateTime') as DateTime;
  @override
  set dateTime(DateTime value) => RealmObjectBase.set(this, 'dateTime', value);

  @override
  Stream<RealmObjectChanges<Balance>> get changes =>
      RealmObjectBase.getChanges<Balance>(this);

  @override
  Balance freeze() => RealmObjectBase.freezeObject<Balance>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Balance._);
    return const SchemaObject(ObjectType.realmObject, Balance, 'Balance', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.double),
      SchemaProperty('dateTime', RealmPropertyType.timestamp),
    ]);
  }
}
