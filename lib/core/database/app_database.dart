import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Shipments extends Table {
  TextColumn get id => text()();
  TextColumn get trackingNumber => text().withLength(min: 8, max: 32)();
  TextColumn get senderId => text()();
  TextColumn get senderName => text()();
  TextColumn get senderPhone => text()();
  TextColumn get senderAddress => text()();
  TextColumn get receiverName => text()();
  TextColumn get receiverPhone => text()();
  TextColumn get receiverAddress => text()();
  TextColumn get packageCategory => text()();
  RealColumn get weightKg => real()();
  TextColumn get priority => text()(); // standard, express, overnight
  TextColumn get currentStatus => text()(); // created, in_transit, delivered, etc.
  TextColumn get originHubId => text()();
  TextColumn get destinationHubId => text()();
  TextColumn get assignedDriverId => text().nullable()();
  DateTimeColumn get expectedDelivery => dateTime()();
  IntColumn get version => integer().withDefault(const Constant(1))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))(); // synced, pending, conflict
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ShipmentEvents extends Table {
  TextColumn get id => text()();
  TextColumn get shipmentId => text()();
  TextColumn get previousStatus => text().nullable()();
  TextColumn get newStatus => text()();
  TextColumn get locationName => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get remarks => text().nullable()();
  TextColumn get updatedBy => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProofOfDeliveries extends Table {
  TextColumn get id => text()();
  TextColumn get shipmentId => text()();
  TextColumn get receiverName => text()();
  TextColumn get signaturePath => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  RealColumn get deliveryLatitude => real()();
  RealColumn get deliveryLongitude => real()();
  DateTimeColumn get deliveryTimestamp => dateTime()();
  TextColumn get notes => text().nullable()();
  TextColumn get submittedBy => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class SyncQueue extends Table {
  TextColumn get operationId => text()();
  TextColumn get userId => text()();
  TextColumn get shipmentId => text()();
  TextColumn get operationType => text()(); // CREATE_SHIPMENT, UPDATE_STATUS, SUBMIT_POD
  TextColumn get payloadJson => text()();
  DateTimeColumn get localTimestamp => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))(); // pending, syncing, synced, failed, conflict
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {operationId};
}

class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()();
  TextColumn get role => text()(); // shipper, hub_manager, driver
  TextColumn get hubId => text().nullable()();
  TextColumn get avatarUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Shipments, ShipmentEvents, ProofOfDeliveries, SyncQueue, Profiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'logiflow_yuva_db');
  }
}
