// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ShipmentsTable extends Shipments
    with TableInfo<$ShipmentsTable, Shipment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShipmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackingNumberMeta = const VerificationMeta(
    'trackingNumber',
  );
  @override
  late final GeneratedColumn<String> trackingNumber = GeneratedColumn<String>(
    'tracking_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 8,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderPhoneMeta = const VerificationMeta(
    'senderPhone',
  );
  @override
  late final GeneratedColumn<String> senderPhone = GeneratedColumn<String>(
    'sender_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderAddressMeta = const VerificationMeta(
    'senderAddress',
  );
  @override
  late final GeneratedColumn<String> senderAddress = GeneratedColumn<String>(
    'sender_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverNameMeta = const VerificationMeta(
    'receiverName',
  );
  @override
  late final GeneratedColumn<String> receiverName = GeneratedColumn<String>(
    'receiver_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverPhoneMeta = const VerificationMeta(
    'receiverPhone',
  );
  @override
  late final GeneratedColumn<String> receiverPhone = GeneratedColumn<String>(
    'receiver_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverAddressMeta = const VerificationMeta(
    'receiverAddress',
  );
  @override
  late final GeneratedColumn<String> receiverAddress = GeneratedColumn<String>(
    'receiver_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packageCategoryMeta = const VerificationMeta(
    'packageCategory',
  );
  @override
  late final GeneratedColumn<String> packageCategory = GeneratedColumn<String>(
    'package_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentStatusMeta = const VerificationMeta(
    'currentStatus',
  );
  @override
  late final GeneratedColumn<String> currentStatus = GeneratedColumn<String>(
    'current_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originHubIdMeta = const VerificationMeta(
    'originHubId',
  );
  @override
  late final GeneratedColumn<String> originHubId = GeneratedColumn<String>(
    'origin_hub_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _destinationHubIdMeta = const VerificationMeta(
    'destinationHubId',
  );
  @override
  late final GeneratedColumn<String> destinationHubId = GeneratedColumn<String>(
    'destination_hub_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignedDriverIdMeta = const VerificationMeta(
    'assignedDriverId',
  );
  @override
  late final GeneratedColumn<String> assignedDriverId = GeneratedColumn<String>(
    'assigned_driver_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedDeliveryMeta = const VerificationMeta(
    'expectedDelivery',
  );
  @override
  late final GeneratedColumn<DateTime> expectedDelivery =
      GeneratedColumn<DateTime>(
        'expected_delivery',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trackingNumber,
    senderId,
    senderName,
    senderPhone,
    senderAddress,
    receiverName,
    receiverPhone,
    receiverAddress,
    packageCategory,
    weightKg,
    priority,
    currentStatus,
    originHubId,
    destinationHubId,
    assignedDriverId,
    expectedDelivery,
    version,
    isDirty,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shipments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shipment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tracking_number')) {
      context.handle(
        _trackingNumberMeta,
        trackingNumber.isAcceptableOrUnknown(
          data['tracking_number']!,
          _trackingNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackingNumberMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_senderNameMeta);
    }
    if (data.containsKey('sender_phone')) {
      context.handle(
        _senderPhoneMeta,
        senderPhone.isAcceptableOrUnknown(
          data['sender_phone']!,
          _senderPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senderPhoneMeta);
    }
    if (data.containsKey('sender_address')) {
      context.handle(
        _senderAddressMeta,
        senderAddress.isAcceptableOrUnknown(
          data['sender_address']!,
          _senderAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_senderAddressMeta);
    }
    if (data.containsKey('receiver_name')) {
      context.handle(
        _receiverNameMeta,
        receiverName.isAcceptableOrUnknown(
          data['receiver_name']!,
          _receiverNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receiverNameMeta);
    }
    if (data.containsKey('receiver_phone')) {
      context.handle(
        _receiverPhoneMeta,
        receiverPhone.isAcceptableOrUnknown(
          data['receiver_phone']!,
          _receiverPhoneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receiverPhoneMeta);
    }
    if (data.containsKey('receiver_address')) {
      context.handle(
        _receiverAddressMeta,
        receiverAddress.isAcceptableOrUnknown(
          data['receiver_address']!,
          _receiverAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receiverAddressMeta);
    }
    if (data.containsKey('package_category')) {
      context.handle(
        _packageCategoryMeta,
        packageCategory.isAcceptableOrUnknown(
          data['package_category']!,
          _packageCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageCategoryMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('current_status')) {
      context.handle(
        _currentStatusMeta,
        currentStatus.isAcceptableOrUnknown(
          data['current_status']!,
          _currentStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentStatusMeta);
    }
    if (data.containsKey('origin_hub_id')) {
      context.handle(
        _originHubIdMeta,
        originHubId.isAcceptableOrUnknown(
          data['origin_hub_id']!,
          _originHubIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originHubIdMeta);
    }
    if (data.containsKey('destination_hub_id')) {
      context.handle(
        _destinationHubIdMeta,
        destinationHubId.isAcceptableOrUnknown(
          data['destination_hub_id']!,
          _destinationHubIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinationHubIdMeta);
    }
    if (data.containsKey('assigned_driver_id')) {
      context.handle(
        _assignedDriverIdMeta,
        assignedDriverId.isAcceptableOrUnknown(
          data['assigned_driver_id']!,
          _assignedDriverIdMeta,
        ),
      );
    }
    if (data.containsKey('expected_delivery')) {
      context.handle(
        _expectedDeliveryMeta,
        expectedDelivery.isAcceptableOrUnknown(
          data['expected_delivery']!,
          _expectedDeliveryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_expectedDeliveryMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shipment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shipment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      trackingNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tracking_number'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      )!,
      senderPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_phone'],
      )!,
      senderAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_address'],
      )!,
      receiverName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver_name'],
      )!,
      receiverPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver_phone'],
      )!,
      receiverAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver_address'],
      )!,
      packageCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_category'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      currentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_status'],
      )!,
      originHubId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin_hub_id'],
      )!,
      destinationHubId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destination_hub_id'],
      )!,
      assignedDriverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_driver_id'],
      ),
      expectedDelivery: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_delivery'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShipmentsTable createAlias(String alias) {
    return $ShipmentsTable(attachedDatabase, alias);
  }
}

class Shipment extends DataClass implements Insertable<Shipment> {
  final String id;
  final String trackingNumber;
  final String senderId;
  final String senderName;
  final String senderPhone;
  final String senderAddress;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final String packageCategory;
  final double weightKg;
  final String priority;
  final String currentStatus;
  final String originHubId;
  final String destinationHubId;
  final String? assignedDriverId;
  final DateTime expectedDelivery;
  final int version;
  final bool isDirty;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Shipment({
    required this.id,
    required this.trackingNumber,
    required this.senderId,
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.packageCategory,
    required this.weightKg,
    required this.priority,
    required this.currentStatus,
    required this.originHubId,
    required this.destinationHubId,
    this.assignedDriverId,
    required this.expectedDelivery,
    required this.version,
    required this.isDirty,
    required this.syncStatus,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tracking_number'] = Variable<String>(trackingNumber);
    map['sender_id'] = Variable<String>(senderId);
    map['sender_name'] = Variable<String>(senderName);
    map['sender_phone'] = Variable<String>(senderPhone);
    map['sender_address'] = Variable<String>(senderAddress);
    map['receiver_name'] = Variable<String>(receiverName);
    map['receiver_phone'] = Variable<String>(receiverPhone);
    map['receiver_address'] = Variable<String>(receiverAddress);
    map['package_category'] = Variable<String>(packageCategory);
    map['weight_kg'] = Variable<double>(weightKg);
    map['priority'] = Variable<String>(priority);
    map['current_status'] = Variable<String>(currentStatus);
    map['origin_hub_id'] = Variable<String>(originHubId);
    map['destination_hub_id'] = Variable<String>(destinationHubId);
    if (!nullToAbsent || assignedDriverId != null) {
      map['assigned_driver_id'] = Variable<String>(assignedDriverId);
    }
    map['expected_delivery'] = Variable<DateTime>(expectedDelivery);
    map['version'] = Variable<int>(version);
    map['is_dirty'] = Variable<bool>(isDirty);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShipmentsCompanion toCompanion(bool nullToAbsent) {
    return ShipmentsCompanion(
      id: Value(id),
      trackingNumber: Value(trackingNumber),
      senderId: Value(senderId),
      senderName: Value(senderName),
      senderPhone: Value(senderPhone),
      senderAddress: Value(senderAddress),
      receiverName: Value(receiverName),
      receiverPhone: Value(receiverPhone),
      receiverAddress: Value(receiverAddress),
      packageCategory: Value(packageCategory),
      weightKg: Value(weightKg),
      priority: Value(priority),
      currentStatus: Value(currentStatus),
      originHubId: Value(originHubId),
      destinationHubId: Value(destinationHubId),
      assignedDriverId: assignedDriverId == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedDriverId),
      expectedDelivery: Value(expectedDelivery),
      version: Value(version),
      isDirty: Value(isDirty),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Shipment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shipment(
      id: serializer.fromJson<String>(json['id']),
      trackingNumber: serializer.fromJson<String>(json['trackingNumber']),
      senderId: serializer.fromJson<String>(json['senderId']),
      senderName: serializer.fromJson<String>(json['senderName']),
      senderPhone: serializer.fromJson<String>(json['senderPhone']),
      senderAddress: serializer.fromJson<String>(json['senderAddress']),
      receiverName: serializer.fromJson<String>(json['receiverName']),
      receiverPhone: serializer.fromJson<String>(json['receiverPhone']),
      receiverAddress: serializer.fromJson<String>(json['receiverAddress']),
      packageCategory: serializer.fromJson<String>(json['packageCategory']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      priority: serializer.fromJson<String>(json['priority']),
      currentStatus: serializer.fromJson<String>(json['currentStatus']),
      originHubId: serializer.fromJson<String>(json['originHubId']),
      destinationHubId: serializer.fromJson<String>(json['destinationHubId']),
      assignedDriverId: serializer.fromJson<String?>(json['assignedDriverId']),
      expectedDelivery: serializer.fromJson<DateTime>(json['expectedDelivery']),
      version: serializer.fromJson<int>(json['version']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'trackingNumber': serializer.toJson<String>(trackingNumber),
      'senderId': serializer.toJson<String>(senderId),
      'senderName': serializer.toJson<String>(senderName),
      'senderPhone': serializer.toJson<String>(senderPhone),
      'senderAddress': serializer.toJson<String>(senderAddress),
      'receiverName': serializer.toJson<String>(receiverName),
      'receiverPhone': serializer.toJson<String>(receiverPhone),
      'receiverAddress': serializer.toJson<String>(receiverAddress),
      'packageCategory': serializer.toJson<String>(packageCategory),
      'weightKg': serializer.toJson<double>(weightKg),
      'priority': serializer.toJson<String>(priority),
      'currentStatus': serializer.toJson<String>(currentStatus),
      'originHubId': serializer.toJson<String>(originHubId),
      'destinationHubId': serializer.toJson<String>(destinationHubId),
      'assignedDriverId': serializer.toJson<String?>(assignedDriverId),
      'expectedDelivery': serializer.toJson<DateTime>(expectedDelivery),
      'version': serializer.toJson<int>(version),
      'isDirty': serializer.toJson<bool>(isDirty),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Shipment copyWith({
    String? id,
    String? trackingNumber,
    String? senderId,
    String? senderName,
    String? senderPhone,
    String? senderAddress,
    String? receiverName,
    String? receiverPhone,
    String? receiverAddress,
    String? packageCategory,
    double? weightKg,
    String? priority,
    String? currentStatus,
    String? originHubId,
    String? destinationHubId,
    Value<String?> assignedDriverId = const Value.absent(),
    DateTime? expectedDelivery,
    int? version,
    bool? isDirty,
    String? syncStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Shipment(
    id: id ?? this.id,
    trackingNumber: trackingNumber ?? this.trackingNumber,
    senderId: senderId ?? this.senderId,
    senderName: senderName ?? this.senderName,
    senderPhone: senderPhone ?? this.senderPhone,
    senderAddress: senderAddress ?? this.senderAddress,
    receiverName: receiverName ?? this.receiverName,
    receiverPhone: receiverPhone ?? this.receiverPhone,
    receiverAddress: receiverAddress ?? this.receiverAddress,
    packageCategory: packageCategory ?? this.packageCategory,
    weightKg: weightKg ?? this.weightKg,
    priority: priority ?? this.priority,
    currentStatus: currentStatus ?? this.currentStatus,
    originHubId: originHubId ?? this.originHubId,
    destinationHubId: destinationHubId ?? this.destinationHubId,
    assignedDriverId: assignedDriverId.present
        ? assignedDriverId.value
        : this.assignedDriverId,
    expectedDelivery: expectedDelivery ?? this.expectedDelivery,
    version: version ?? this.version,
    isDirty: isDirty ?? this.isDirty,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Shipment copyWithCompanion(ShipmentsCompanion data) {
    return Shipment(
      id: data.id.present ? data.id.value : this.id,
      trackingNumber: data.trackingNumber.present
          ? data.trackingNumber.value
          : this.trackingNumber,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      senderPhone: data.senderPhone.present
          ? data.senderPhone.value
          : this.senderPhone,
      senderAddress: data.senderAddress.present
          ? data.senderAddress.value
          : this.senderAddress,
      receiverName: data.receiverName.present
          ? data.receiverName.value
          : this.receiverName,
      receiverPhone: data.receiverPhone.present
          ? data.receiverPhone.value
          : this.receiverPhone,
      receiverAddress: data.receiverAddress.present
          ? data.receiverAddress.value
          : this.receiverAddress,
      packageCategory: data.packageCategory.present
          ? data.packageCategory.value
          : this.packageCategory,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      priority: data.priority.present ? data.priority.value : this.priority,
      currentStatus: data.currentStatus.present
          ? data.currentStatus.value
          : this.currentStatus,
      originHubId: data.originHubId.present
          ? data.originHubId.value
          : this.originHubId,
      destinationHubId: data.destinationHubId.present
          ? data.destinationHubId.value
          : this.destinationHubId,
      assignedDriverId: data.assignedDriverId.present
          ? data.assignedDriverId.value
          : this.assignedDriverId,
      expectedDelivery: data.expectedDelivery.present
          ? data.expectedDelivery.value
          : this.expectedDelivery,
      version: data.version.present ? data.version.value : this.version,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shipment(')
          ..write('id: $id, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('senderPhone: $senderPhone, ')
          ..write('senderAddress: $senderAddress, ')
          ..write('receiverName: $receiverName, ')
          ..write('receiverPhone: $receiverPhone, ')
          ..write('receiverAddress: $receiverAddress, ')
          ..write('packageCategory: $packageCategory, ')
          ..write('weightKg: $weightKg, ')
          ..write('priority: $priority, ')
          ..write('currentStatus: $currentStatus, ')
          ..write('originHubId: $originHubId, ')
          ..write('destinationHubId: $destinationHubId, ')
          ..write('assignedDriverId: $assignedDriverId, ')
          ..write('expectedDelivery: $expectedDelivery, ')
          ..write('version: $version, ')
          ..write('isDirty: $isDirty, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    trackingNumber,
    senderId,
    senderName,
    senderPhone,
    senderAddress,
    receiverName,
    receiverPhone,
    receiverAddress,
    packageCategory,
    weightKg,
    priority,
    currentStatus,
    originHubId,
    destinationHubId,
    assignedDriverId,
    expectedDelivery,
    version,
    isDirty,
    syncStatus,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shipment &&
          other.id == this.id &&
          other.trackingNumber == this.trackingNumber &&
          other.senderId == this.senderId &&
          other.senderName == this.senderName &&
          other.senderPhone == this.senderPhone &&
          other.senderAddress == this.senderAddress &&
          other.receiverName == this.receiverName &&
          other.receiverPhone == this.receiverPhone &&
          other.receiverAddress == this.receiverAddress &&
          other.packageCategory == this.packageCategory &&
          other.weightKg == this.weightKg &&
          other.priority == this.priority &&
          other.currentStatus == this.currentStatus &&
          other.originHubId == this.originHubId &&
          other.destinationHubId == this.destinationHubId &&
          other.assignedDriverId == this.assignedDriverId &&
          other.expectedDelivery == this.expectedDelivery &&
          other.version == this.version &&
          other.isDirty == this.isDirty &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ShipmentsCompanion extends UpdateCompanion<Shipment> {
  final Value<String> id;
  final Value<String> trackingNumber;
  final Value<String> senderId;
  final Value<String> senderName;
  final Value<String> senderPhone;
  final Value<String> senderAddress;
  final Value<String> receiverName;
  final Value<String> receiverPhone;
  final Value<String> receiverAddress;
  final Value<String> packageCategory;
  final Value<double> weightKg;
  final Value<String> priority;
  final Value<String> currentStatus;
  final Value<String> originHubId;
  final Value<String> destinationHubId;
  final Value<String?> assignedDriverId;
  final Value<DateTime> expectedDelivery;
  final Value<int> version;
  final Value<bool> isDirty;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ShipmentsCompanion({
    this.id = const Value.absent(),
    this.trackingNumber = const Value.absent(),
    this.senderId = const Value.absent(),
    this.senderName = const Value.absent(),
    this.senderPhone = const Value.absent(),
    this.senderAddress = const Value.absent(),
    this.receiverName = const Value.absent(),
    this.receiverPhone = const Value.absent(),
    this.receiverAddress = const Value.absent(),
    this.packageCategory = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.priority = const Value.absent(),
    this.currentStatus = const Value.absent(),
    this.originHubId = const Value.absent(),
    this.destinationHubId = const Value.absent(),
    this.assignedDriverId = const Value.absent(),
    this.expectedDelivery = const Value.absent(),
    this.version = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShipmentsCompanion.insert({
    required String id,
    required String trackingNumber,
    required String senderId,
    required String senderName,
    required String senderPhone,
    required String senderAddress,
    required String receiverName,
    required String receiverPhone,
    required String receiverAddress,
    required String packageCategory,
    required double weightKg,
    required String priority,
    required String currentStatus,
    required String originHubId,
    required String destinationHubId,
    this.assignedDriverId = const Value.absent(),
    required DateTime expectedDelivery,
    this.version = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       trackingNumber = Value(trackingNumber),
       senderId = Value(senderId),
       senderName = Value(senderName),
       senderPhone = Value(senderPhone),
       senderAddress = Value(senderAddress),
       receiverName = Value(receiverName),
       receiverPhone = Value(receiverPhone),
       receiverAddress = Value(receiverAddress),
       packageCategory = Value(packageCategory),
       weightKg = Value(weightKg),
       priority = Value(priority),
       currentStatus = Value(currentStatus),
       originHubId = Value(originHubId),
       destinationHubId = Value(destinationHubId),
       expectedDelivery = Value(expectedDelivery),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Shipment> custom({
    Expression<String>? id,
    Expression<String>? trackingNumber,
    Expression<String>? senderId,
    Expression<String>? senderName,
    Expression<String>? senderPhone,
    Expression<String>? senderAddress,
    Expression<String>? receiverName,
    Expression<String>? receiverPhone,
    Expression<String>? receiverAddress,
    Expression<String>? packageCategory,
    Expression<double>? weightKg,
    Expression<String>? priority,
    Expression<String>? currentStatus,
    Expression<String>? originHubId,
    Expression<String>? destinationHubId,
    Expression<String>? assignedDriverId,
    Expression<DateTime>? expectedDelivery,
    Expression<int>? version,
    Expression<bool>? isDirty,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackingNumber != null) 'tracking_number': trackingNumber,
      if (senderId != null) 'sender_id': senderId,
      if (senderName != null) 'sender_name': senderName,
      if (senderPhone != null) 'sender_phone': senderPhone,
      if (senderAddress != null) 'sender_address': senderAddress,
      if (receiverName != null) 'receiver_name': receiverName,
      if (receiverPhone != null) 'receiver_phone': receiverPhone,
      if (receiverAddress != null) 'receiver_address': receiverAddress,
      if (packageCategory != null) 'package_category': packageCategory,
      if (weightKg != null) 'weight_kg': weightKg,
      if (priority != null) 'priority': priority,
      if (currentStatus != null) 'current_status': currentStatus,
      if (originHubId != null) 'origin_hub_id': originHubId,
      if (destinationHubId != null) 'destination_hub_id': destinationHubId,
      if (assignedDriverId != null) 'assigned_driver_id': assignedDriverId,
      if (expectedDelivery != null) 'expected_delivery': expectedDelivery,
      if (version != null) 'version': version,
      if (isDirty != null) 'is_dirty': isDirty,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShipmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? trackingNumber,
    Value<String>? senderId,
    Value<String>? senderName,
    Value<String>? senderPhone,
    Value<String>? senderAddress,
    Value<String>? receiverName,
    Value<String>? receiverPhone,
    Value<String>? receiverAddress,
    Value<String>? packageCategory,
    Value<double>? weightKg,
    Value<String>? priority,
    Value<String>? currentStatus,
    Value<String>? originHubId,
    Value<String>? destinationHubId,
    Value<String?>? assignedDriverId,
    Value<DateTime>? expectedDelivery,
    Value<int>? version,
    Value<bool>? isDirty,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ShipmentsCompanion(
      id: id ?? this.id,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      senderAddress: senderAddress ?? this.senderAddress,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      packageCategory: packageCategory ?? this.packageCategory,
      weightKg: weightKg ?? this.weightKg,
      priority: priority ?? this.priority,
      currentStatus: currentStatus ?? this.currentStatus,
      originHubId: originHubId ?? this.originHubId,
      destinationHubId: destinationHubId ?? this.destinationHubId,
      assignedDriverId: assignedDriverId ?? this.assignedDriverId,
      expectedDelivery: expectedDelivery ?? this.expectedDelivery,
      version: version ?? this.version,
      isDirty: isDirty ?? this.isDirty,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (trackingNumber.present) {
      map['tracking_number'] = Variable<String>(trackingNumber.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (senderPhone.present) {
      map['sender_phone'] = Variable<String>(senderPhone.value);
    }
    if (senderAddress.present) {
      map['sender_address'] = Variable<String>(senderAddress.value);
    }
    if (receiverName.present) {
      map['receiver_name'] = Variable<String>(receiverName.value);
    }
    if (receiverPhone.present) {
      map['receiver_phone'] = Variable<String>(receiverPhone.value);
    }
    if (receiverAddress.present) {
      map['receiver_address'] = Variable<String>(receiverAddress.value);
    }
    if (packageCategory.present) {
      map['package_category'] = Variable<String>(packageCategory.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (currentStatus.present) {
      map['current_status'] = Variable<String>(currentStatus.value);
    }
    if (originHubId.present) {
      map['origin_hub_id'] = Variable<String>(originHubId.value);
    }
    if (destinationHubId.present) {
      map['destination_hub_id'] = Variable<String>(destinationHubId.value);
    }
    if (assignedDriverId.present) {
      map['assigned_driver_id'] = Variable<String>(assignedDriverId.value);
    }
    if (expectedDelivery.present) {
      map['expected_delivery'] = Variable<DateTime>(expectedDelivery.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShipmentsCompanion(')
          ..write('id: $id, ')
          ..write('trackingNumber: $trackingNumber, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('senderPhone: $senderPhone, ')
          ..write('senderAddress: $senderAddress, ')
          ..write('receiverName: $receiverName, ')
          ..write('receiverPhone: $receiverPhone, ')
          ..write('receiverAddress: $receiverAddress, ')
          ..write('packageCategory: $packageCategory, ')
          ..write('weightKg: $weightKg, ')
          ..write('priority: $priority, ')
          ..write('currentStatus: $currentStatus, ')
          ..write('originHubId: $originHubId, ')
          ..write('destinationHubId: $destinationHubId, ')
          ..write('assignedDriverId: $assignedDriverId, ')
          ..write('expectedDelivery: $expectedDelivery, ')
          ..write('version: $version, ')
          ..write('isDirty: $isDirty, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShipmentEventsTable extends ShipmentEvents
    with TableInfo<$ShipmentEventsTable, ShipmentEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShipmentEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shipmentIdMeta = const VerificationMeta(
    'shipmentId',
  );
  @override
  late final GeneratedColumn<String> shipmentId = GeneratedColumn<String>(
    'shipment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousStatusMeta = const VerificationMeta(
    'previousStatus',
  );
  @override
  late final GeneratedColumn<String> previousStatus = GeneratedColumn<String>(
    'previous_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newStatusMeta = const VerificationMeta(
    'newStatus',
  );
  @override
  late final GeneratedColumn<String> newStatus = GeneratedColumn<String>(
    'new_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedByMeta = const VerificationMeta(
    'updatedBy',
  );
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
    'updated_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shipmentId,
    previousStatus,
    newStatus,
    locationName,
    latitude,
    longitude,
    remarks,
    updatedBy,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shipment_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShipmentEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shipment_id')) {
      context.handle(
        _shipmentIdMeta,
        shipmentId.isAcceptableOrUnknown(data['shipment_id']!, _shipmentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shipmentIdMeta);
    }
    if (data.containsKey('previous_status')) {
      context.handle(
        _previousStatusMeta,
        previousStatus.isAcceptableOrUnknown(
          data['previous_status']!,
          _previousStatusMeta,
        ),
      );
    }
    if (data.containsKey('new_status')) {
      context.handle(
        _newStatusMeta,
        newStatus.isAcceptableOrUnknown(data['new_status']!, _newStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_newStatusMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_locationNameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('updated_by')) {
      context.handle(
        _updatedByMeta,
        updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShipmentEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShipmentEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shipmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shipment_id'],
      )!,
      previousStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_status'],
      ),
      newStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_status'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      updatedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_by'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ShipmentEventsTable createAlias(String alias) {
    return $ShipmentEventsTable(attachedDatabase, alias);
  }
}

class ShipmentEvent extends DataClass implements Insertable<ShipmentEvent> {
  final String id;
  final String shipmentId;
  final String? previousStatus;
  final String newStatus;
  final String locationName;
  final double? latitude;
  final double? longitude;
  final String? remarks;
  final String updatedBy;
  final DateTime createdAt;
  const ShipmentEvent({
    required this.id,
    required this.shipmentId,
    this.previousStatus,
    required this.newStatus,
    required this.locationName,
    this.latitude,
    this.longitude,
    this.remarks,
    required this.updatedBy,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shipment_id'] = Variable<String>(shipmentId);
    if (!nullToAbsent || previousStatus != null) {
      map['previous_status'] = Variable<String>(previousStatus);
    }
    map['new_status'] = Variable<String>(newStatus);
    map['location_name'] = Variable<String>(locationName);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    map['updated_by'] = Variable<String>(updatedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShipmentEventsCompanion toCompanion(bool nullToAbsent) {
    return ShipmentEventsCompanion(
      id: Value(id),
      shipmentId: Value(shipmentId),
      previousStatus: previousStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(previousStatus),
      newStatus: Value(newStatus),
      locationName: Value(locationName),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      updatedBy: Value(updatedBy),
      createdAt: Value(createdAt),
    );
  }

  factory ShipmentEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShipmentEvent(
      id: serializer.fromJson<String>(json['id']),
      shipmentId: serializer.fromJson<String>(json['shipmentId']),
      previousStatus: serializer.fromJson<String?>(json['previousStatus']),
      newStatus: serializer.fromJson<String>(json['newStatus']),
      locationName: serializer.fromJson<String>(json['locationName']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      updatedBy: serializer.fromJson<String>(json['updatedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shipmentId': serializer.toJson<String>(shipmentId),
      'previousStatus': serializer.toJson<String?>(previousStatus),
      'newStatus': serializer.toJson<String>(newStatus),
      'locationName': serializer.toJson<String>(locationName),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'remarks': serializer.toJson<String?>(remarks),
      'updatedBy': serializer.toJson<String>(updatedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ShipmentEvent copyWith({
    String? id,
    String? shipmentId,
    Value<String?> previousStatus = const Value.absent(),
    String? newStatus,
    String? locationName,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> remarks = const Value.absent(),
    String? updatedBy,
    DateTime? createdAt,
  }) => ShipmentEvent(
    id: id ?? this.id,
    shipmentId: shipmentId ?? this.shipmentId,
    previousStatus: previousStatus.present
        ? previousStatus.value
        : this.previousStatus,
    newStatus: newStatus ?? this.newStatus,
    locationName: locationName ?? this.locationName,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    remarks: remarks.present ? remarks.value : this.remarks,
    updatedBy: updatedBy ?? this.updatedBy,
    createdAt: createdAt ?? this.createdAt,
  );
  ShipmentEvent copyWithCompanion(ShipmentEventsCompanion data) {
    return ShipmentEvent(
      id: data.id.present ? data.id.value : this.id,
      shipmentId: data.shipmentId.present
          ? data.shipmentId.value
          : this.shipmentId,
      previousStatus: data.previousStatus.present
          ? data.previousStatus.value
          : this.previousStatus,
      newStatus: data.newStatus.present ? data.newStatus.value : this.newStatus,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShipmentEvent(')
          ..write('id: $id, ')
          ..write('shipmentId: $shipmentId, ')
          ..write('previousStatus: $previousStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('locationName: $locationName, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('remarks: $remarks, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shipmentId,
    previousStatus,
    newStatus,
    locationName,
    latitude,
    longitude,
    remarks,
    updatedBy,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShipmentEvent &&
          other.id == this.id &&
          other.shipmentId == this.shipmentId &&
          other.previousStatus == this.previousStatus &&
          other.newStatus == this.newStatus &&
          other.locationName == this.locationName &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.remarks == this.remarks &&
          other.updatedBy == this.updatedBy &&
          other.createdAt == this.createdAt);
}

class ShipmentEventsCompanion extends UpdateCompanion<ShipmentEvent> {
  final Value<String> id;
  final Value<String> shipmentId;
  final Value<String?> previousStatus;
  final Value<String> newStatus;
  final Value<String> locationName;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> remarks;
  final Value<String> updatedBy;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ShipmentEventsCompanion({
    this.id = const Value.absent(),
    this.shipmentId = const Value.absent(),
    this.previousStatus = const Value.absent(),
    this.newStatus = const Value.absent(),
    this.locationName = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.remarks = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShipmentEventsCompanion.insert({
    required String id,
    required String shipmentId,
    this.previousStatus = const Value.absent(),
    required String newStatus,
    required String locationName,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.remarks = const Value.absent(),
    required String updatedBy,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shipmentId = Value(shipmentId),
       newStatus = Value(newStatus),
       locationName = Value(locationName),
       updatedBy = Value(updatedBy),
       createdAt = Value(createdAt);
  static Insertable<ShipmentEvent> custom({
    Expression<String>? id,
    Expression<String>? shipmentId,
    Expression<String>? previousStatus,
    Expression<String>? newStatus,
    Expression<String>? locationName,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? remarks,
    Expression<String>? updatedBy,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shipmentId != null) 'shipment_id': shipmentId,
      if (previousStatus != null) 'previous_status': previousStatus,
      if (newStatus != null) 'new_status': newStatus,
      if (locationName != null) 'location_name': locationName,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (remarks != null) 'remarks': remarks,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShipmentEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? shipmentId,
    Value<String?>? previousStatus,
    Value<String>? newStatus,
    Value<String>? locationName,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? remarks,
    Value<String>? updatedBy,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ShipmentEventsCompanion(
      id: id ?? this.id,
      shipmentId: shipmentId ?? this.shipmentId,
      previousStatus: previousStatus ?? this.previousStatus,
      newStatus: newStatus ?? this.newStatus,
      locationName: locationName ?? this.locationName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      remarks: remarks ?? this.remarks,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shipmentId.present) {
      map['shipment_id'] = Variable<String>(shipmentId.value);
    }
    if (previousStatus.present) {
      map['previous_status'] = Variable<String>(previousStatus.value);
    }
    if (newStatus.present) {
      map['new_status'] = Variable<String>(newStatus.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShipmentEventsCompanion(')
          ..write('id: $id, ')
          ..write('shipmentId: $shipmentId, ')
          ..write('previousStatus: $previousStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('locationName: $locationName, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('remarks: $remarks, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProofOfDeliveriesTable extends ProofOfDeliveries
    with TableInfo<$ProofOfDeliveriesTable, ProofOfDelivery> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProofOfDeliveriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shipmentIdMeta = const VerificationMeta(
    'shipmentId',
  );
  @override
  late final GeneratedColumn<String> shipmentId = GeneratedColumn<String>(
    'shipment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _receiverNameMeta = const VerificationMeta(
    'receiverName',
  );
  @override
  late final GeneratedColumn<String> receiverName = GeneratedColumn<String>(
    'receiver_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _signaturePathMeta = const VerificationMeta(
    'signaturePath',
  );
  @override
  late final GeneratedColumn<String> signaturePath = GeneratedColumn<String>(
    'signature_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deliveryLatitudeMeta = const VerificationMeta(
    'deliveryLatitude',
  );
  @override
  late final GeneratedColumn<double> deliveryLatitude = GeneratedColumn<double>(
    'delivery_latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryLongitudeMeta = const VerificationMeta(
    'deliveryLongitude',
  );
  @override
  late final GeneratedColumn<double> deliveryLongitude =
      GeneratedColumn<double>(
        'delivery_longitude',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _deliveryTimestampMeta = const VerificationMeta(
    'deliveryTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> deliveryTimestamp =
      GeneratedColumn<DateTime>(
        'delivery_timestamp',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _submittedByMeta = const VerificationMeta(
    'submittedBy',
  );
  @override
  late final GeneratedColumn<String> submittedBy = GeneratedColumn<String>(
    'submitted_by',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shipmentId,
    receiverName,
    signaturePath,
    photoPath,
    deliveryLatitude,
    deliveryLongitude,
    deliveryTimestamp,
    notes,
    submittedBy,
    syncStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'proof_of_deliveries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProofOfDelivery> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shipment_id')) {
      context.handle(
        _shipmentIdMeta,
        shipmentId.isAcceptableOrUnknown(data['shipment_id']!, _shipmentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shipmentIdMeta);
    }
    if (data.containsKey('receiver_name')) {
      context.handle(
        _receiverNameMeta,
        receiverName.isAcceptableOrUnknown(
          data['receiver_name']!,
          _receiverNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_receiverNameMeta);
    }
    if (data.containsKey('signature_path')) {
      context.handle(
        _signaturePathMeta,
        signaturePath.isAcceptableOrUnknown(
          data['signature_path']!,
          _signaturePathMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('delivery_latitude')) {
      context.handle(
        _deliveryLatitudeMeta,
        deliveryLatitude.isAcceptableOrUnknown(
          data['delivery_latitude']!,
          _deliveryLatitudeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryLatitudeMeta);
    }
    if (data.containsKey('delivery_longitude')) {
      context.handle(
        _deliveryLongitudeMeta,
        deliveryLongitude.isAcceptableOrUnknown(
          data['delivery_longitude']!,
          _deliveryLongitudeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryLongitudeMeta);
    }
    if (data.containsKey('delivery_timestamp')) {
      context.handle(
        _deliveryTimestampMeta,
        deliveryTimestamp.isAcceptableOrUnknown(
          data['delivery_timestamp']!,
          _deliveryTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryTimestampMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('submitted_by')) {
      context.handle(
        _submittedByMeta,
        submittedBy.isAcceptableOrUnknown(
          data['submitted_by']!,
          _submittedByMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submittedByMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProofOfDelivery map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProofOfDelivery(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shipmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shipment_id'],
      )!,
      receiverName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receiver_name'],
      )!,
      signaturePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signature_path'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      deliveryLatitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delivery_latitude'],
      )!,
      deliveryLongitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delivery_longitude'],
      )!,
      deliveryTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivery_timestamp'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      submittedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}submitted_by'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProofOfDeliveriesTable createAlias(String alias) {
    return $ProofOfDeliveriesTable(attachedDatabase, alias);
  }
}

class ProofOfDelivery extends DataClass implements Insertable<ProofOfDelivery> {
  final String id;
  final String shipmentId;
  final String receiverName;
  final String? signaturePath;
  final String? photoPath;
  final double deliveryLatitude;
  final double deliveryLongitude;
  final DateTime deliveryTimestamp;
  final String? notes;
  final String submittedBy;
  final String syncStatus;
  final DateTime createdAt;
  const ProofOfDelivery({
    required this.id,
    required this.shipmentId,
    required this.receiverName,
    this.signaturePath,
    this.photoPath,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    required this.deliveryTimestamp,
    this.notes,
    required this.submittedBy,
    required this.syncStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shipment_id'] = Variable<String>(shipmentId);
    map['receiver_name'] = Variable<String>(receiverName);
    if (!nullToAbsent || signaturePath != null) {
      map['signature_path'] = Variable<String>(signaturePath);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['delivery_latitude'] = Variable<double>(deliveryLatitude);
    map['delivery_longitude'] = Variable<double>(deliveryLongitude);
    map['delivery_timestamp'] = Variable<DateTime>(deliveryTimestamp);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['submitted_by'] = Variable<String>(submittedBy);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProofOfDeliveriesCompanion toCompanion(bool nullToAbsent) {
    return ProofOfDeliveriesCompanion(
      id: Value(id),
      shipmentId: Value(shipmentId),
      receiverName: Value(receiverName),
      signaturePath: signaturePath == null && nullToAbsent
          ? const Value.absent()
          : Value(signaturePath),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      deliveryLatitude: Value(deliveryLatitude),
      deliveryLongitude: Value(deliveryLongitude),
      deliveryTimestamp: Value(deliveryTimestamp),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      submittedBy: Value(submittedBy),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
    );
  }

  factory ProofOfDelivery.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProofOfDelivery(
      id: serializer.fromJson<String>(json['id']),
      shipmentId: serializer.fromJson<String>(json['shipmentId']),
      receiverName: serializer.fromJson<String>(json['receiverName']),
      signaturePath: serializer.fromJson<String?>(json['signaturePath']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      deliveryLatitude: serializer.fromJson<double>(json['deliveryLatitude']),
      deliveryLongitude: serializer.fromJson<double>(json['deliveryLongitude']),
      deliveryTimestamp: serializer.fromJson<DateTime>(
        json['deliveryTimestamp'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      submittedBy: serializer.fromJson<String>(json['submittedBy']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shipmentId': serializer.toJson<String>(shipmentId),
      'receiverName': serializer.toJson<String>(receiverName),
      'signaturePath': serializer.toJson<String?>(signaturePath),
      'photoPath': serializer.toJson<String?>(photoPath),
      'deliveryLatitude': serializer.toJson<double>(deliveryLatitude),
      'deliveryLongitude': serializer.toJson<double>(deliveryLongitude),
      'deliveryTimestamp': serializer.toJson<DateTime>(deliveryTimestamp),
      'notes': serializer.toJson<String?>(notes),
      'submittedBy': serializer.toJson<String>(submittedBy),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProofOfDelivery copyWith({
    String? id,
    String? shipmentId,
    String? receiverName,
    Value<String?> signaturePath = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    double? deliveryLatitude,
    double? deliveryLongitude,
    DateTime? deliveryTimestamp,
    Value<String?> notes = const Value.absent(),
    String? submittedBy,
    String? syncStatus,
    DateTime? createdAt,
  }) => ProofOfDelivery(
    id: id ?? this.id,
    shipmentId: shipmentId ?? this.shipmentId,
    receiverName: receiverName ?? this.receiverName,
    signaturePath: signaturePath.present
        ? signaturePath.value
        : this.signaturePath,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
    deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
    deliveryTimestamp: deliveryTimestamp ?? this.deliveryTimestamp,
    notes: notes.present ? notes.value : this.notes,
    submittedBy: submittedBy ?? this.submittedBy,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  ProofOfDelivery copyWithCompanion(ProofOfDeliveriesCompanion data) {
    return ProofOfDelivery(
      id: data.id.present ? data.id.value : this.id,
      shipmentId: data.shipmentId.present
          ? data.shipmentId.value
          : this.shipmentId,
      receiverName: data.receiverName.present
          ? data.receiverName.value
          : this.receiverName,
      signaturePath: data.signaturePath.present
          ? data.signaturePath.value
          : this.signaturePath,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      deliveryLatitude: data.deliveryLatitude.present
          ? data.deliveryLatitude.value
          : this.deliveryLatitude,
      deliveryLongitude: data.deliveryLongitude.present
          ? data.deliveryLongitude.value
          : this.deliveryLongitude,
      deliveryTimestamp: data.deliveryTimestamp.present
          ? data.deliveryTimestamp.value
          : this.deliveryTimestamp,
      notes: data.notes.present ? data.notes.value : this.notes,
      submittedBy: data.submittedBy.present
          ? data.submittedBy.value
          : this.submittedBy,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProofOfDelivery(')
          ..write('id: $id, ')
          ..write('shipmentId: $shipmentId, ')
          ..write('receiverName: $receiverName, ')
          ..write('signaturePath: $signaturePath, ')
          ..write('photoPath: $photoPath, ')
          ..write('deliveryLatitude: $deliveryLatitude, ')
          ..write('deliveryLongitude: $deliveryLongitude, ')
          ..write('deliveryTimestamp: $deliveryTimestamp, ')
          ..write('notes: $notes, ')
          ..write('submittedBy: $submittedBy, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shipmentId,
    receiverName,
    signaturePath,
    photoPath,
    deliveryLatitude,
    deliveryLongitude,
    deliveryTimestamp,
    notes,
    submittedBy,
    syncStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProofOfDelivery &&
          other.id == this.id &&
          other.shipmentId == this.shipmentId &&
          other.receiverName == this.receiverName &&
          other.signaturePath == this.signaturePath &&
          other.photoPath == this.photoPath &&
          other.deliveryLatitude == this.deliveryLatitude &&
          other.deliveryLongitude == this.deliveryLongitude &&
          other.deliveryTimestamp == this.deliveryTimestamp &&
          other.notes == this.notes &&
          other.submittedBy == this.submittedBy &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt);
}

class ProofOfDeliveriesCompanion extends UpdateCompanion<ProofOfDelivery> {
  final Value<String> id;
  final Value<String> shipmentId;
  final Value<String> receiverName;
  final Value<String?> signaturePath;
  final Value<String?> photoPath;
  final Value<double> deliveryLatitude;
  final Value<double> deliveryLongitude;
  final Value<DateTime> deliveryTimestamp;
  final Value<String?> notes;
  final Value<String> submittedBy;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ProofOfDeliveriesCompanion({
    this.id = const Value.absent(),
    this.shipmentId = const Value.absent(),
    this.receiverName = const Value.absent(),
    this.signaturePath = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.deliveryLatitude = const Value.absent(),
    this.deliveryLongitude = const Value.absent(),
    this.deliveryTimestamp = const Value.absent(),
    this.notes = const Value.absent(),
    this.submittedBy = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProofOfDeliveriesCompanion.insert({
    required String id,
    required String shipmentId,
    required String receiverName,
    this.signaturePath = const Value.absent(),
    this.photoPath = const Value.absent(),
    required double deliveryLatitude,
    required double deliveryLongitude,
    required DateTime deliveryTimestamp,
    this.notes = const Value.absent(),
    required String submittedBy,
    this.syncStatus = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shipmentId = Value(shipmentId),
       receiverName = Value(receiverName),
       deliveryLatitude = Value(deliveryLatitude),
       deliveryLongitude = Value(deliveryLongitude),
       deliveryTimestamp = Value(deliveryTimestamp),
       submittedBy = Value(submittedBy),
       createdAt = Value(createdAt);
  static Insertable<ProofOfDelivery> custom({
    Expression<String>? id,
    Expression<String>? shipmentId,
    Expression<String>? receiverName,
    Expression<String>? signaturePath,
    Expression<String>? photoPath,
    Expression<double>? deliveryLatitude,
    Expression<double>? deliveryLongitude,
    Expression<DateTime>? deliveryTimestamp,
    Expression<String>? notes,
    Expression<String>? submittedBy,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shipmentId != null) 'shipment_id': shipmentId,
      if (receiverName != null) 'receiver_name': receiverName,
      if (signaturePath != null) 'signature_path': signaturePath,
      if (photoPath != null) 'photo_path': photoPath,
      if (deliveryLatitude != null) 'delivery_latitude': deliveryLatitude,
      if (deliveryLongitude != null) 'delivery_longitude': deliveryLongitude,
      if (deliveryTimestamp != null) 'delivery_timestamp': deliveryTimestamp,
      if (notes != null) 'notes': notes,
      if (submittedBy != null) 'submitted_by': submittedBy,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProofOfDeliveriesCompanion copyWith({
    Value<String>? id,
    Value<String>? shipmentId,
    Value<String>? receiverName,
    Value<String?>? signaturePath,
    Value<String?>? photoPath,
    Value<double>? deliveryLatitude,
    Value<double>? deliveryLongitude,
    Value<DateTime>? deliveryTimestamp,
    Value<String?>? notes,
    Value<String>? submittedBy,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ProofOfDeliveriesCompanion(
      id: id ?? this.id,
      shipmentId: shipmentId ?? this.shipmentId,
      receiverName: receiverName ?? this.receiverName,
      signaturePath: signaturePath ?? this.signaturePath,
      photoPath: photoPath ?? this.photoPath,
      deliveryLatitude: deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude: deliveryLongitude ?? this.deliveryLongitude,
      deliveryTimestamp: deliveryTimestamp ?? this.deliveryTimestamp,
      notes: notes ?? this.notes,
      submittedBy: submittedBy ?? this.submittedBy,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shipmentId.present) {
      map['shipment_id'] = Variable<String>(shipmentId.value);
    }
    if (receiverName.present) {
      map['receiver_name'] = Variable<String>(receiverName.value);
    }
    if (signaturePath.present) {
      map['signature_path'] = Variable<String>(signaturePath.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (deliveryLatitude.present) {
      map['delivery_latitude'] = Variable<double>(deliveryLatitude.value);
    }
    if (deliveryLongitude.present) {
      map['delivery_longitude'] = Variable<double>(deliveryLongitude.value);
    }
    if (deliveryTimestamp.present) {
      map['delivery_timestamp'] = Variable<DateTime>(deliveryTimestamp.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (submittedBy.present) {
      map['submitted_by'] = Variable<String>(submittedBy.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProofOfDeliveriesCompanion(')
          ..write('id: $id, ')
          ..write('shipmentId: $shipmentId, ')
          ..write('receiverName: $receiverName, ')
          ..write('signaturePath: $signaturePath, ')
          ..write('photoPath: $photoPath, ')
          ..write('deliveryLatitude: $deliveryLatitude, ')
          ..write('deliveryLongitude: $deliveryLongitude, ')
          ..write('deliveryTimestamp: $deliveryTimestamp, ')
          ..write('notes: $notes, ')
          ..write('submittedBy: $submittedBy, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _operationIdMeta = const VerificationMeta(
    'operationId',
  );
  @override
  late final GeneratedColumn<String> operationId = GeneratedColumn<String>(
    'operation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shipmentIdMeta = const VerificationMeta(
    'shipmentId',
  );
  @override
  late final GeneratedColumn<String> shipmentId = GeneratedColumn<String>(
    'shipment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localTimestampMeta = const VerificationMeta(
    'localTimestamp',
  );
  @override
  late final GeneratedColumn<DateTime> localTimestamp =
      GeneratedColumn<DateTime>(
        'local_timestamp',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    operationId,
    userId,
    shipmentId,
    operationType,
    payloadJson,
    localTimestamp,
    syncStatus,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('operation_id')) {
      context.handle(
        _operationIdMeta,
        operationId.isAcceptableOrUnknown(
          data['operation_id']!,
          _operationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('shipment_id')) {
      context.handle(
        _shipmentIdMeta,
        shipmentId.isAcceptableOrUnknown(data['shipment_id']!, _shipmentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shipmentIdMeta);
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('local_timestamp')) {
      context.handle(
        _localTimestampMeta,
        localTimestamp.isAcceptableOrUnknown(
          data['local_timestamp']!,
          _localTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_localTimestampMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {operationId};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      operationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      shipmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shipment_id'],
      )!,
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      localTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_timestamp'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String operationId;
  final String userId;
  final String shipmentId;
  final String operationType;
  final String payloadJson;
  final DateTime localTimestamp;
  final String syncStatus;
  final int retryCount;
  final String? lastError;
  const SyncQueueData({
    required this.operationId,
    required this.userId,
    required this.shipmentId,
    required this.operationType,
    required this.payloadJson,
    required this.localTimestamp,
    required this.syncStatus,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['operation_id'] = Variable<String>(operationId);
    map['user_id'] = Variable<String>(userId);
    map['shipment_id'] = Variable<String>(shipmentId);
    map['operation_type'] = Variable<String>(operationType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['local_timestamp'] = Variable<DateTime>(localTimestamp);
    map['sync_status'] = Variable<String>(syncStatus);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      operationId: Value(operationId),
      userId: Value(userId),
      shipmentId: Value(shipmentId),
      operationType: Value(operationType),
      payloadJson: Value(payloadJson),
      localTimestamp: Value(localTimestamp),
      syncStatus: Value(syncStatus),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      operationId: serializer.fromJson<String>(json['operationId']),
      userId: serializer.fromJson<String>(json['userId']),
      shipmentId: serializer.fromJson<String>(json['shipmentId']),
      operationType: serializer.fromJson<String>(json['operationType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      localTimestamp: serializer.fromJson<DateTime>(json['localTimestamp']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'operationId': serializer.toJson<String>(operationId),
      'userId': serializer.toJson<String>(userId),
      'shipmentId': serializer.toJson<String>(shipmentId),
      'operationType': serializer.toJson<String>(operationType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'localTimestamp': serializer.toJson<DateTime>(localTimestamp),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueData copyWith({
    String? operationId,
    String? userId,
    String? shipmentId,
    String? operationType,
    String? payloadJson,
    DateTime? localTimestamp,
    String? syncStatus,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => SyncQueueData(
    operationId: operationId ?? this.operationId,
    userId: userId ?? this.userId,
    shipmentId: shipmentId ?? this.shipmentId,
    operationType: operationType ?? this.operationType,
    payloadJson: payloadJson ?? this.payloadJson,
    localTimestamp: localTimestamp ?? this.localTimestamp,
    syncStatus: syncStatus ?? this.syncStatus,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      operationId: data.operationId.present
          ? data.operationId.value
          : this.operationId,
      userId: data.userId.present ? data.userId.value : this.userId,
      shipmentId: data.shipmentId.present
          ? data.shipmentId.value
          : this.shipmentId,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      localTimestamp: data.localTimestamp.present
          ? data.localTimestamp.value
          : this.localTimestamp,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('operationId: $operationId, ')
          ..write('userId: $userId, ')
          ..write('shipmentId: $shipmentId, ')
          ..write('operationType: $operationType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('localTimestamp: $localTimestamp, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    operationId,
    userId,
    shipmentId,
    operationType,
    payloadJson,
    localTimestamp,
    syncStatus,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.operationId == this.operationId &&
          other.userId == this.userId &&
          other.shipmentId == this.shipmentId &&
          other.operationType == this.operationType &&
          other.payloadJson == this.payloadJson &&
          other.localTimestamp == this.localTimestamp &&
          other.syncStatus == this.syncStatus &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> operationId;
  final Value<String> userId;
  final Value<String> shipmentId;
  final Value<String> operationType;
  final Value<String> payloadJson;
  final Value<DateTime> localTimestamp;
  final Value<String> syncStatus;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.operationId = const Value.absent(),
    this.userId = const Value.absent(),
    this.shipmentId = const Value.absent(),
    this.operationType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.localTimestamp = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String operationId,
    required String userId,
    required String shipmentId,
    required String operationType,
    required String payloadJson,
    required DateTime localTimestamp,
    this.syncStatus = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : operationId = Value(operationId),
       userId = Value(userId),
       shipmentId = Value(shipmentId),
       operationType = Value(operationType),
       payloadJson = Value(payloadJson),
       localTimestamp = Value(localTimestamp);
  static Insertable<SyncQueueData> custom({
    Expression<String>? operationId,
    Expression<String>? userId,
    Expression<String>? shipmentId,
    Expression<String>? operationType,
    Expression<String>? payloadJson,
    Expression<DateTime>? localTimestamp,
    Expression<String>? syncStatus,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (operationId != null) 'operation_id': operationId,
      if (userId != null) 'user_id': userId,
      if (shipmentId != null) 'shipment_id': shipmentId,
      if (operationType != null) 'operation_type': operationType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (localTimestamp != null) 'local_timestamp': localTimestamp,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith({
    Value<String>? operationId,
    Value<String>? userId,
    Value<String>? shipmentId,
    Value<String>? operationType,
    Value<String>? payloadJson,
    Value<DateTime>? localTimestamp,
    Value<String>? syncStatus,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return SyncQueueCompanion(
      operationId: operationId ?? this.operationId,
      userId: userId ?? this.userId,
      shipmentId: shipmentId ?? this.shipmentId,
      operationType: operationType ?? this.operationType,
      payloadJson: payloadJson ?? this.payloadJson,
      localTimestamp: localTimestamp ?? this.localTimestamp,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (operationId.present) {
      map['operation_id'] = Variable<String>(operationId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (shipmentId.present) {
      map['shipment_id'] = Variable<String>(shipmentId.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (localTimestamp.present) {
      map['local_timestamp'] = Variable<DateTime>(localTimestamp.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('operationId: $operationId, ')
          ..write('userId: $userId, ')
          ..write('shipmentId: $shipmentId, ')
          ..write('operationType: $operationType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('localTimestamp: $localTimestamp, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hubIdMeta = const VerificationMeta('hubId');
  @override
  late final GeneratedColumn<String> hubId = GeneratedColumn<String>(
    'hub_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fullName,
    email,
    phone,
    role,
    hubId,
    avatarUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('hub_id')) {
      context.handle(
        _hubIdMeta,
        hubId.isAcceptableOrUnknown(data['hub_id']!, _hubIdMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      hubId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hub_id'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String? hubId;
  final String? avatarUrl;
  const Profile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.hubId,
    this.avatarUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || hubId != null) {
      map['hub_id'] = Variable<String>(hubId);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      fullName: Value(fullName),
      email: Value(email),
      phone: Value(phone),
      role: Value(role),
      hubId: hubId == null && nullToAbsent
          ? const Value.absent()
          : Value(hubId),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      hubId: serializer.fromJson<String?>(json['hubId']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'role': serializer.toJson<String>(role),
      'hubId': serializer.toJson<String?>(hubId),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
    };
  }

  Profile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? role,
    Value<String?> hubId = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
  }) => Profile(
    id: id ?? this.id,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    role: role ?? this.role,
    hubId: hubId.present ? hubId.value : this.hubId,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      hubId: data.hubId.present ? data.hubId.value : this.hubId,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('hubId: $hubId, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fullName, email, phone, role, hubId, avatarUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.hubId == this.hubId &&
          other.avatarUrl == this.avatarUrl);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> role;
  final Value<String?> hubId;
  final Value<String?> avatarUrl;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.hubId = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String fullName,
    required String email,
    required String phone,
    required String role,
    this.hubId = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fullName = Value(fullName),
       email = Value(email),
       phone = Value(phone),
       role = Value(role);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<String>? hubId,
    Expression<String>? avatarUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (hubId != null) 'hub_id': hubId,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? fullName,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? role,
    Value<String?>? hubId,
    Value<String?>? avatarUrl,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      hubId: hubId ?? this.hubId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (hubId.present) {
      map['hub_id'] = Variable<String>(hubId.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('hubId: $hubId, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShipmentsTable shipments = $ShipmentsTable(this);
  late final $ShipmentEventsTable shipmentEvents = $ShipmentEventsTable(this);
  late final $ProofOfDeliveriesTable proofOfDeliveries =
      $ProofOfDeliveriesTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    shipments,
    shipmentEvents,
    proofOfDeliveries,
    syncQueue,
    profiles,
  ];
}

typedef $$ShipmentsTableCreateCompanionBuilder =
    ShipmentsCompanion Function({
      required String id,
      required String trackingNumber,
      required String senderId,
      required String senderName,
      required String senderPhone,
      required String senderAddress,
      required String receiverName,
      required String receiverPhone,
      required String receiverAddress,
      required String packageCategory,
      required double weightKg,
      required String priority,
      required String currentStatus,
      required String originHubId,
      required String destinationHubId,
      Value<String?> assignedDriverId,
      required DateTime expectedDelivery,
      Value<int> version,
      Value<bool> isDirty,
      Value<String> syncStatus,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ShipmentsTableUpdateCompanionBuilder =
    ShipmentsCompanion Function({
      Value<String> id,
      Value<String> trackingNumber,
      Value<String> senderId,
      Value<String> senderName,
      Value<String> senderPhone,
      Value<String> senderAddress,
      Value<String> receiverName,
      Value<String> receiverPhone,
      Value<String> receiverAddress,
      Value<String> packageCategory,
      Value<double> weightKg,
      Value<String> priority,
      Value<String> currentStatus,
      Value<String> originHubId,
      Value<String> destinationHubId,
      Value<String?> assignedDriverId,
      Value<DateTime> expectedDelivery,
      Value<int> version,
      Value<bool> isDirty,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ShipmentsTableFilterComposer
    extends Composer<_$AppDatabase, $ShipmentsTable> {
  $$ShipmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderPhone => $composableBuilder(
    column: $table.senderPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderAddress => $composableBuilder(
    column: $table.senderAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiverPhone => $composableBuilder(
    column: $table.receiverPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiverAddress => $composableBuilder(
    column: $table.receiverAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageCategory => $composableBuilder(
    column: $table.packageCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentStatus => $composableBuilder(
    column: $table.currentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originHubId => $composableBuilder(
    column: $table.originHubId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinationHubId => $composableBuilder(
    column: $table.destinationHubId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedDriverId => $composableBuilder(
    column: $table.assignedDriverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedDelivery => $composableBuilder(
    column: $table.expectedDelivery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShipmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShipmentsTable> {
  $$ShipmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderPhone => $composableBuilder(
    column: $table.senderPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderAddress => $composableBuilder(
    column: $table.senderAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiverPhone => $composableBuilder(
    column: $table.receiverPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiverAddress => $composableBuilder(
    column: $table.receiverAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageCategory => $composableBuilder(
    column: $table.packageCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStatus => $composableBuilder(
    column: $table.currentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originHubId => $composableBuilder(
    column: $table.originHubId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinationHubId => $composableBuilder(
    column: $table.destinationHubId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedDriverId => $composableBuilder(
    column: $table.assignedDriverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedDelivery => $composableBuilder(
    column: $table.expectedDelivery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShipmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShipmentsTable> {
  $$ShipmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trackingNumber => $composableBuilder(
    column: $table.trackingNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderPhone => $composableBuilder(
    column: $table.senderPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderAddress => $composableBuilder(
    column: $table.senderAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiverPhone => $composableBuilder(
    column: $table.receiverPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiverAddress => $composableBuilder(
    column: $table.receiverAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packageCategory => $composableBuilder(
    column: $table.packageCategory,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get currentStatus => $composableBuilder(
    column: $table.currentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originHubId => $composableBuilder(
    column: $table.originHubId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinationHubId => $composableBuilder(
    column: $table.destinationHubId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get assignedDriverId => $composableBuilder(
    column: $table.assignedDriverId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expectedDelivery => $composableBuilder(
    column: $table.expectedDelivery,
    builder: (column) => column,
  );

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShipmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShipmentsTable,
          Shipment,
          $$ShipmentsTableFilterComposer,
          $$ShipmentsTableOrderingComposer,
          $$ShipmentsTableAnnotationComposer,
          $$ShipmentsTableCreateCompanionBuilder,
          $$ShipmentsTableUpdateCompanionBuilder,
          (Shipment, BaseReferences<_$AppDatabase, $ShipmentsTable, Shipment>),
          Shipment,
          PrefetchHooks Function()
        > {
  $$ShipmentsTableTableManager(_$AppDatabase db, $ShipmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShipmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShipmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShipmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> trackingNumber = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> senderName = const Value.absent(),
                Value<String> senderPhone = const Value.absent(),
                Value<String> senderAddress = const Value.absent(),
                Value<String> receiverName = const Value.absent(),
                Value<String> receiverPhone = const Value.absent(),
                Value<String> receiverAddress = const Value.absent(),
                Value<String> packageCategory = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String> currentStatus = const Value.absent(),
                Value<String> originHubId = const Value.absent(),
                Value<String> destinationHubId = const Value.absent(),
                Value<String?> assignedDriverId = const Value.absent(),
                Value<DateTime> expectedDelivery = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShipmentsCompanion(
                id: id,
                trackingNumber: trackingNumber,
                senderId: senderId,
                senderName: senderName,
                senderPhone: senderPhone,
                senderAddress: senderAddress,
                receiverName: receiverName,
                receiverPhone: receiverPhone,
                receiverAddress: receiverAddress,
                packageCategory: packageCategory,
                weightKg: weightKg,
                priority: priority,
                currentStatus: currentStatus,
                originHubId: originHubId,
                destinationHubId: destinationHubId,
                assignedDriverId: assignedDriverId,
                expectedDelivery: expectedDelivery,
                version: version,
                isDirty: isDirty,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String trackingNumber,
                required String senderId,
                required String senderName,
                required String senderPhone,
                required String senderAddress,
                required String receiverName,
                required String receiverPhone,
                required String receiverAddress,
                required String packageCategory,
                required double weightKg,
                required String priority,
                required String currentStatus,
                required String originHubId,
                required String destinationHubId,
                Value<String?> assignedDriverId = const Value.absent(),
                required DateTime expectedDelivery,
                Value<int> version = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShipmentsCompanion.insert(
                id: id,
                trackingNumber: trackingNumber,
                senderId: senderId,
                senderName: senderName,
                senderPhone: senderPhone,
                senderAddress: senderAddress,
                receiverName: receiverName,
                receiverPhone: receiverPhone,
                receiverAddress: receiverAddress,
                packageCategory: packageCategory,
                weightKg: weightKg,
                priority: priority,
                currentStatus: currentStatus,
                originHubId: originHubId,
                destinationHubId: destinationHubId,
                assignedDriverId: assignedDriverId,
                expectedDelivery: expectedDelivery,
                version: version,
                isDirty: isDirty,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShipmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShipmentsTable,
      Shipment,
      $$ShipmentsTableFilterComposer,
      $$ShipmentsTableOrderingComposer,
      $$ShipmentsTableAnnotationComposer,
      $$ShipmentsTableCreateCompanionBuilder,
      $$ShipmentsTableUpdateCompanionBuilder,
      (Shipment, BaseReferences<_$AppDatabase, $ShipmentsTable, Shipment>),
      Shipment,
      PrefetchHooks Function()
    >;
typedef $$ShipmentEventsTableCreateCompanionBuilder =
    ShipmentEventsCompanion Function({
      required String id,
      required String shipmentId,
      Value<String?> previousStatus,
      required String newStatus,
      required String locationName,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> remarks,
      required String updatedBy,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ShipmentEventsTableUpdateCompanionBuilder =
    ShipmentEventsCompanion Function({
      Value<String> id,
      Value<String> shipmentId,
      Value<String?> previousStatus,
      Value<String> newStatus,
      Value<String> locationName,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> remarks,
      Value<String> updatedBy,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ShipmentEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ShipmentEventsTable> {
  $$ShipmentEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousStatus => $composableBuilder(
    column: $table.previousStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShipmentEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShipmentEventsTable> {
  $$ShipmentEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousStatus => $composableBuilder(
    column: $table.previousStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedBy => $composableBuilder(
    column: $table.updatedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShipmentEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShipmentEventsTable> {
  $$ShipmentEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get previousStatus => $composableBuilder(
    column: $table.previousStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get newStatus =>
      $composableBuilder(column: $table.newStatus, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get updatedBy =>
      $composableBuilder(column: $table.updatedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ShipmentEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShipmentEventsTable,
          ShipmentEvent,
          $$ShipmentEventsTableFilterComposer,
          $$ShipmentEventsTableOrderingComposer,
          $$ShipmentEventsTableAnnotationComposer,
          $$ShipmentEventsTableCreateCompanionBuilder,
          $$ShipmentEventsTableUpdateCompanionBuilder,
          (
            ShipmentEvent,
            BaseReferences<_$AppDatabase, $ShipmentEventsTable, ShipmentEvent>,
          ),
          ShipmentEvent,
          PrefetchHooks Function()
        > {
  $$ShipmentEventsTableTableManager(
    _$AppDatabase db,
    $ShipmentEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShipmentEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShipmentEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShipmentEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shipmentId = const Value.absent(),
                Value<String?> previousStatus = const Value.absent(),
                Value<String> newStatus = const Value.absent(),
                Value<String> locationName = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String> updatedBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShipmentEventsCompanion(
                id: id,
                shipmentId: shipmentId,
                previousStatus: previousStatus,
                newStatus: newStatus,
                locationName: locationName,
                latitude: latitude,
                longitude: longitude,
                remarks: remarks,
                updatedBy: updatedBy,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shipmentId,
                Value<String?> previousStatus = const Value.absent(),
                required String newStatus,
                required String locationName,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                required String updatedBy,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ShipmentEventsCompanion.insert(
                id: id,
                shipmentId: shipmentId,
                previousStatus: previousStatus,
                newStatus: newStatus,
                locationName: locationName,
                latitude: latitude,
                longitude: longitude,
                remarks: remarks,
                updatedBy: updatedBy,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShipmentEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShipmentEventsTable,
      ShipmentEvent,
      $$ShipmentEventsTableFilterComposer,
      $$ShipmentEventsTableOrderingComposer,
      $$ShipmentEventsTableAnnotationComposer,
      $$ShipmentEventsTableCreateCompanionBuilder,
      $$ShipmentEventsTableUpdateCompanionBuilder,
      (
        ShipmentEvent,
        BaseReferences<_$AppDatabase, $ShipmentEventsTable, ShipmentEvent>,
      ),
      ShipmentEvent,
      PrefetchHooks Function()
    >;
typedef $$ProofOfDeliveriesTableCreateCompanionBuilder =
    ProofOfDeliveriesCompanion Function({
      required String id,
      required String shipmentId,
      required String receiverName,
      Value<String?> signaturePath,
      Value<String?> photoPath,
      required double deliveryLatitude,
      required double deliveryLongitude,
      required DateTime deliveryTimestamp,
      Value<String?> notes,
      required String submittedBy,
      Value<String> syncStatus,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ProofOfDeliveriesTableUpdateCompanionBuilder =
    ProofOfDeliveriesCompanion Function({
      Value<String> id,
      Value<String> shipmentId,
      Value<String> receiverName,
      Value<String?> signaturePath,
      Value<String?> photoPath,
      Value<double> deliveryLatitude,
      Value<double> deliveryLongitude,
      Value<DateTime> deliveryTimestamp,
      Value<String?> notes,
      Value<String> submittedBy,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ProofOfDeliveriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProofOfDeliveriesTable> {
  $$ProofOfDeliveriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signaturePath => $composableBuilder(
    column: $table.signaturePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deliveryLatitude => $composableBuilder(
    column: $table.deliveryLatitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get deliveryLongitude => $composableBuilder(
    column: $table.deliveryLongitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveryTimestamp => $composableBuilder(
    column: $table.deliveryTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get submittedBy => $composableBuilder(
    column: $table.submittedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProofOfDeliveriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProofOfDeliveriesTable> {
  $$ProofOfDeliveriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signaturePath => $composableBuilder(
    column: $table.signaturePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deliveryLatitude => $composableBuilder(
    column: $table.deliveryLatitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get deliveryLongitude => $composableBuilder(
    column: $table.deliveryLongitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveryTimestamp => $composableBuilder(
    column: $table.deliveryTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get submittedBy => $composableBuilder(
    column: $table.submittedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProofOfDeliveriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProofOfDeliveriesTable> {
  $$ProofOfDeliveriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiverName => $composableBuilder(
    column: $table.receiverName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signaturePath => $composableBuilder(
    column: $table.signaturePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get deliveryLatitude => $composableBuilder(
    column: $table.deliveryLatitude,
    builder: (column) => column,
  );

  GeneratedColumn<double> get deliveryLongitude => $composableBuilder(
    column: $table.deliveryLongitude,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deliveryTimestamp => $composableBuilder(
    column: $table.deliveryTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get submittedBy => $composableBuilder(
    column: $table.submittedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ProofOfDeliveriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProofOfDeliveriesTable,
          ProofOfDelivery,
          $$ProofOfDeliveriesTableFilterComposer,
          $$ProofOfDeliveriesTableOrderingComposer,
          $$ProofOfDeliveriesTableAnnotationComposer,
          $$ProofOfDeliveriesTableCreateCompanionBuilder,
          $$ProofOfDeliveriesTableUpdateCompanionBuilder,
          (
            ProofOfDelivery,
            BaseReferences<
              _$AppDatabase,
              $ProofOfDeliveriesTable,
              ProofOfDelivery
            >,
          ),
          ProofOfDelivery,
          PrefetchHooks Function()
        > {
  $$ProofOfDeliveriesTableTableManager(
    _$AppDatabase db,
    $ProofOfDeliveriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProofOfDeliveriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProofOfDeliveriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProofOfDeliveriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shipmentId = const Value.absent(),
                Value<String> receiverName = const Value.absent(),
                Value<String?> signaturePath = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<double> deliveryLatitude = const Value.absent(),
                Value<double> deliveryLongitude = const Value.absent(),
                Value<DateTime> deliveryTimestamp = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> submittedBy = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProofOfDeliveriesCompanion(
                id: id,
                shipmentId: shipmentId,
                receiverName: receiverName,
                signaturePath: signaturePath,
                photoPath: photoPath,
                deliveryLatitude: deliveryLatitude,
                deliveryLongitude: deliveryLongitude,
                deliveryTimestamp: deliveryTimestamp,
                notes: notes,
                submittedBy: submittedBy,
                syncStatus: syncStatus,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shipmentId,
                required String receiverName,
                Value<String?> signaturePath = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                required double deliveryLatitude,
                required double deliveryLongitude,
                required DateTime deliveryTimestamp,
                Value<String?> notes = const Value.absent(),
                required String submittedBy,
                Value<String> syncStatus = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ProofOfDeliveriesCompanion.insert(
                id: id,
                shipmentId: shipmentId,
                receiverName: receiverName,
                signaturePath: signaturePath,
                photoPath: photoPath,
                deliveryLatitude: deliveryLatitude,
                deliveryLongitude: deliveryLongitude,
                deliveryTimestamp: deliveryTimestamp,
                notes: notes,
                submittedBy: submittedBy,
                syncStatus: syncStatus,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProofOfDeliveriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProofOfDeliveriesTable,
      ProofOfDelivery,
      $$ProofOfDeliveriesTableFilterComposer,
      $$ProofOfDeliveriesTableOrderingComposer,
      $$ProofOfDeliveriesTableAnnotationComposer,
      $$ProofOfDeliveriesTableCreateCompanionBuilder,
      $$ProofOfDeliveriesTableUpdateCompanionBuilder,
      (
        ProofOfDelivery,
        BaseReferences<_$AppDatabase, $ProofOfDeliveriesTable, ProofOfDelivery>,
      ),
      ProofOfDelivery,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      required String operationId,
      required String userId,
      required String shipmentId,
      required String operationType,
      required String payloadJson,
      required DateTime localTimestamp,
      Value<String> syncStatus,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<String> operationId,
      Value<String> userId,
      Value<String> shipmentId,
      Value<String> operationType,
      Value<String> payloadJson,
      Value<DateTime> localTimestamp,
      Value<String> syncStatus,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localTimestamp => $composableBuilder(
    column: $table.localTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localTimestamp => $composableBuilder(
    column: $table.localTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get operationId => $composableBuilder(
    column: $table.operationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get shipmentId => $composableBuilder(
    column: $table.shipmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get localTimestamp => $composableBuilder(
    column: $table.localTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> operationId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> shipmentId = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> localTimestamp = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion(
                operationId: operationId,
                userId: userId,
                shipmentId: shipmentId,
                operationType: operationType,
                payloadJson: payloadJson,
                localTimestamp: localTimestamp,
                syncStatus: syncStatus,
                retryCount: retryCount,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String operationId,
                required String userId,
                required String shipmentId,
                required String operationType,
                required String payloadJson,
                required DateTime localTimestamp,
                Value<String> syncStatus = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                operationId: operationId,
                userId: userId,
                shipmentId: shipmentId,
                operationType: operationType,
                payloadJson: payloadJson,
                localTimestamp: localTimestamp,
                syncStatus: syncStatus,
                retryCount: retryCount,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      required String id,
      required String fullName,
      required String email,
      required String phone,
      required String role,
      Value<String?> hubId,
      Value<String?> avatarUrl,
      Value<int> rowid,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<String> id,
      Value<String> fullName,
      Value<String> email,
      Value<String> phone,
      Value<String> role,
      Value<String?> hubId,
      Value<String?> avatarUrl,
      Value<int> rowid,
    });

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hubId => $composableBuilder(
    column: $table.hubId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hubId => $composableBuilder(
    column: $table.hubId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get hubId =>
      $composableBuilder(column: $table.hubId, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
          Profile,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> hubId = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                fullName: fullName,
                email: email,
                phone: phone,
                role: role,
                hubId: hubId,
                avatarUrl: avatarUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fullName,
                required String email,
                required String phone,
                required String role,
                Value<String?> hubId = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                fullName: fullName,
                email: email,
                phone: phone,
                role: role,
                hubId: hubId,
                avatarUrl: avatarUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
      Profile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShipmentsTableTableManager get shipments =>
      $$ShipmentsTableTableManager(_db, _db.shipments);
  $$ShipmentEventsTableTableManager get shipmentEvents =>
      $$ShipmentEventsTableTableManager(_db, _db.shipmentEvents);
  $$ProofOfDeliveriesTableTableManager get proofOfDeliveries =>
      $$ProofOfDeliveriesTableTableManager(_db, _db.proofOfDeliveries);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
}
