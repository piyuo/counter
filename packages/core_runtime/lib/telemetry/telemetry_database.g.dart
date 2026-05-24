// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_database.dart';

// ignore_for_file: type=lint
class $TelemetryQueueTable extends TelemetryQueue
    with TableInfo<$TelemetryQueueTable, TelemetryQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TelemetryQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serializedPayloadMeta = const VerificationMeta(
    'serializedPayload',
  );
  @override
  late final GeneratedColumn<String> serializedPayload =
      GeneratedColumn<String>(
        'serialized_payload',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _createdAtMsMeta = const VerificationMeta(
    'createdAtMs',
  );
  @override
  late final GeneratedColumn<int> createdAtMs = GeneratedColumn<int>(
    'created_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMsMeta = const VerificationMeta(
    'startMs',
  );
  @override
  late final GeneratedColumn<int> startMs = GeneratedColumn<int>(
    'start_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadedAtMsMeta = const VerificationMeta(
    'uploadedAtMs',
  );
  @override
  late final GeneratedColumn<int> uploadedAtMs = GeneratedColumn<int>(
    'delivered_at_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serializedPayload,
    createdAtMs,
    startMs,
    uploadedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'telemetry_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<TelemetryQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('serialized_payload')) {
      context.handle(
        _serializedPayloadMeta,
        serializedPayload.isAcceptableOrUnknown(
          data['serialized_payload']!,
          _serializedPayloadMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serializedPayloadMeta);
    }
    if (data.containsKey('created_at_ms')) {
      context.handle(
        _createdAtMsMeta,
        createdAtMs.isAcceptableOrUnknown(
          data['created_at_ms']!,
          _createdAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMsMeta);
    }
    if (data.containsKey('start_ms')) {
      context.handle(
        _startMsMeta,
        startMs.isAcceptableOrUnknown(data['start_ms']!, _startMsMeta),
      );
    } else if (isInserting) {
      context.missing(_startMsMeta);
    }
    if (data.containsKey('delivered_at_ms')) {
      context.handle(
        _uploadedAtMsMeta,
        uploadedAtMs.isAcceptableOrUnknown(
          data['delivered_at_ms']!,
          _uploadedAtMsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TelemetryQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TelemetryQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serializedPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serialized_payload'],
      )!,
      createdAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_ms'],
      )!,
      startMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_ms'],
      )!,
      uploadedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delivered_at_ms'],
      ),
    );
  }

  @override
  $TelemetryQueueTable createAlias(String alias) {
    return $TelemetryQueueTable(attachedDatabase, alias);
  }
}

class TelemetryQueueData extends DataClass
    implements Insertable<TelemetryQueueData> {
  /// UUID v4 string; primary key. Matches [core_domain.TelemetryPayload.payloadId].
  final String id;
  final String serializedPayload;

  /// Milliseconds since epoch — when this item was first enqueued.
  final int createdAtMs;

  /// Milliseconds since epoch — observed window start time (UTC).
  final int startMs;

  /// Milliseconds since epoch — when this item was successfully uploaded.
  /// NULL if not yet uploaded.
  /// Uses legacy column name for backward compatibility with existing databases.
  final int? uploadedAtMs;
  const TelemetryQueueData({
    required this.id,
    required this.serializedPayload,
    required this.createdAtMs,
    required this.startMs,
    this.uploadedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['serialized_payload'] = Variable<String>(serializedPayload);
    map['created_at_ms'] = Variable<int>(createdAtMs);
    map['start_ms'] = Variable<int>(startMs);
    if (!nullToAbsent || uploadedAtMs != null) {
      map['delivered_at_ms'] = Variable<int>(uploadedAtMs);
    }
    return map;
  }

  TelemetryQueueCompanion toCompanion(bool nullToAbsent) {
    return TelemetryQueueCompanion(
      id: Value(id),
      serializedPayload: Value(serializedPayload),
      createdAtMs: Value(createdAtMs),
      startMs: Value(startMs),
      uploadedAtMs: uploadedAtMs == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedAtMs),
    );
  }

  factory TelemetryQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TelemetryQueueData(
      id: serializer.fromJson<String>(json['id']),
      serializedPayload: serializer.fromJson<String>(json['serializedPayload']),
      createdAtMs: serializer.fromJson<int>(json['createdAtMs']),
      startMs: serializer.fromJson<int>(json['startMs']),
      uploadedAtMs: serializer.fromJson<int?>(json['uploadedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serializedPayload': serializer.toJson<String>(serializedPayload),
      'createdAtMs': serializer.toJson<int>(createdAtMs),
      'startMs': serializer.toJson<int>(startMs),
      'uploadedAtMs': serializer.toJson<int?>(uploadedAtMs),
    };
  }

  TelemetryQueueData copyWith({
    String? id,
    String? serializedPayload,
    int? createdAtMs,
    int? startMs,
    Value<int?> uploadedAtMs = const Value.absent(),
  }) => TelemetryQueueData(
    id: id ?? this.id,
    serializedPayload: serializedPayload ?? this.serializedPayload,
    createdAtMs: createdAtMs ?? this.createdAtMs,
    startMs: startMs ?? this.startMs,
    uploadedAtMs: uploadedAtMs.present ? uploadedAtMs.value : this.uploadedAtMs,
  );
  TelemetryQueueData copyWithCompanion(TelemetryQueueCompanion data) {
    return TelemetryQueueData(
      id: data.id.present ? data.id.value : this.id,
      serializedPayload: data.serializedPayload.present
          ? data.serializedPayload.value
          : this.serializedPayload,
      createdAtMs: data.createdAtMs.present
          ? data.createdAtMs.value
          : this.createdAtMs,
      startMs: data.startMs.present ? data.startMs.value : this.startMs,
      uploadedAtMs: data.uploadedAtMs.present
          ? data.uploadedAtMs.value
          : this.uploadedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TelemetryQueueData(')
          ..write('id: $id, ')
          ..write('serializedPayload: $serializedPayload, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('startMs: $startMs, ')
          ..write('uploadedAtMs: $uploadedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, serializedPayload, createdAtMs, startMs, uploadedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TelemetryQueueData &&
          other.id == this.id &&
          other.serializedPayload == this.serializedPayload &&
          other.createdAtMs == this.createdAtMs &&
          other.startMs == this.startMs &&
          other.uploadedAtMs == this.uploadedAtMs);
}

class TelemetryQueueCompanion extends UpdateCompanion<TelemetryQueueData> {
  final Value<String> id;
  final Value<String> serializedPayload;
  final Value<int> createdAtMs;
  final Value<int> startMs;
  final Value<int?> uploadedAtMs;
  final Value<int> rowid;
  const TelemetryQueueCompanion({
    this.id = const Value.absent(),
    this.serializedPayload = const Value.absent(),
    this.createdAtMs = const Value.absent(),
    this.startMs = const Value.absent(),
    this.uploadedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TelemetryQueueCompanion.insert({
    required String id,
    required String serializedPayload,
    required int createdAtMs,
    required int startMs,
    this.uploadedAtMs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       serializedPayload = Value(serializedPayload),
       createdAtMs = Value(createdAtMs),
       startMs = Value(startMs);
  static Insertable<TelemetryQueueData> custom({
    Expression<String>? id,
    Expression<String>? serializedPayload,
    Expression<int>? createdAtMs,
    Expression<int>? startMs,
    Expression<int>? uploadedAtMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serializedPayload != null) 'serialized_payload': serializedPayload,
      if (createdAtMs != null) 'created_at_ms': createdAtMs,
      if (startMs != null) 'start_ms': startMs,
      if (uploadedAtMs != null) 'delivered_at_ms': uploadedAtMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TelemetryQueueCompanion copyWith({
    Value<String>? id,
    Value<String>? serializedPayload,
    Value<int>? createdAtMs,
    Value<int>? startMs,
    Value<int?>? uploadedAtMs,
    Value<int>? rowid,
  }) {
    return TelemetryQueueCompanion(
      id: id ?? this.id,
      serializedPayload: serializedPayload ?? this.serializedPayload,
      createdAtMs: createdAtMs ?? this.createdAtMs,
      startMs: startMs ?? this.startMs,
      uploadedAtMs: uploadedAtMs ?? this.uploadedAtMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serializedPayload.present) {
      map['serialized_payload'] = Variable<String>(serializedPayload.value);
    }
    if (createdAtMs.present) {
      map['created_at_ms'] = Variable<int>(createdAtMs.value);
    }
    if (startMs.present) {
      map['start_ms'] = Variable<int>(startMs.value);
    }
    if (uploadedAtMs.present) {
      map['delivered_at_ms'] = Variable<int>(uploadedAtMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TelemetryQueueCompanion(')
          ..write('id: $id, ')
          ..write('serializedPayload: $serializedPayload, ')
          ..write('createdAtMs: $createdAtMs, ')
          ..write('startMs: $startMs, ')
          ..write('uploadedAtMs: $uploadedAtMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TelemetryUploadLogTable extends TelemetryUploadLog
    with TableInfo<$TelemetryUploadLogTable, TelemetryUploadLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TelemetryUploadLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _successMeta = const VerificationMeta(
    'success',
  );
  @override
  late final GeneratedColumn<bool> success = GeneratedColumn<bool>(
    'success',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("success" IN (0, 1))',
    ),
  );
  static const VerificationMeta _attemptedAtMsMeta = const VerificationMeta(
    'attemptedAtMs',
  );
  @override
  late final GeneratedColumn<int> attemptedAtMs = GeneratedColumn<int>(
    'attempted_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadSizeKbMeta = const VerificationMeta(
    'payloadSizeKb',
  );
  @override
  late final GeneratedColumn<int> payloadSizeKb = GeneratedColumn<int>(
    'size_kb',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadCountMeta = const VerificationMeta(
    'payloadCount',
  );
  @override
  late final GeneratedColumn<int> payloadCount = GeneratedColumn<int>(
    'payload_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    success,
    attemptedAtMs,
    payloadSizeKb,
    payloadCount,
    retryCount,
    error,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'telemetry_upload_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<TelemetryUploadLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('success')) {
      context.handle(
        _successMeta,
        success.isAcceptableOrUnknown(data['success']!, _successMeta),
      );
    } else if (isInserting) {
      context.missing(_successMeta);
    }
    if (data.containsKey('attempted_at_ms')) {
      context.handle(
        _attemptedAtMsMeta,
        attemptedAtMs.isAcceptableOrUnknown(
          data['attempted_at_ms']!,
          _attemptedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptedAtMsMeta);
    }
    if (data.containsKey('size_kb')) {
      context.handle(
        _payloadSizeKbMeta,
        payloadSizeKb.isAcceptableOrUnknown(
          data['size_kb']!,
          _payloadSizeKbMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadSizeKbMeta);
    }
    if (data.containsKey('payload_count')) {
      context.handle(
        _payloadCountMeta,
        payloadCount.isAcceptableOrUnknown(
          data['payload_count']!,
          _payloadCountMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TelemetryUploadLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TelemetryUploadLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      success: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}success'],
      )!,
      attemptedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempted_at_ms'],
      )!,
      payloadSizeKb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_kb'],
      )!,
      payloadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payload_count'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      ),
    );
  }

  @override
  $TelemetryUploadLogTable createAlias(String alias) {
    return $TelemetryUploadLogTable(attachedDatabase, alias);
  }
}

class TelemetryUploadLogData extends DataClass
    implements Insertable<TelemetryUploadLogData> {
  /// Semantic primary key in UTC hour/status format: yyyyMMddHHs.
  ///
  /// Success digit:
  /// - 1: success
  /// - 0: failed
  ///
  /// Allows 2 records per hour (success/failure) without ID collisions during retries.
  final int id;

  /// True if the upload attempt succeeded.
  final bool success;

  /// Milliseconds since epoch — timestamp of the upload attempt.
  final int attemptedAtMs;

  /// Serialized payload size sent in this attempt, rounded to KB.
  final int payloadSizeKb;

  /// Number of payload items included in this upload attempt.
  final int payloadCount;

  /// Retry number captured for this upload attempt.
  final int retryCount;

  /// Human-readable error message from failed attempts.
  final String? error;
  const TelemetryUploadLogData({
    required this.id,
    required this.success,
    required this.attemptedAtMs,
    required this.payloadSizeKb,
    required this.payloadCount,
    required this.retryCount,
    this.error,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['success'] = Variable<bool>(success);
    map['attempted_at_ms'] = Variable<int>(attemptedAtMs);
    map['size_kb'] = Variable<int>(payloadSizeKb);
    map['payload_count'] = Variable<int>(payloadCount);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String>(error);
    }
    return map;
  }

  TelemetryUploadLogCompanion toCompanion(bool nullToAbsent) {
    return TelemetryUploadLogCompanion(
      id: Value(id),
      success: Value(success),
      attemptedAtMs: Value(attemptedAtMs),
      payloadSizeKb: Value(payloadSizeKb),
      payloadCount: Value(payloadCount),
      retryCount: Value(retryCount),
      error: error == null && nullToAbsent
          ? const Value.absent()
          : Value(error),
    );
  }

  factory TelemetryUploadLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TelemetryUploadLogData(
      id: serializer.fromJson<int>(json['id']),
      success: serializer.fromJson<bool>(json['success']),
      attemptedAtMs: serializer.fromJson<int>(json['attemptedAtMs']),
      payloadSizeKb: serializer.fromJson<int>(json['payloadSizeKb']),
      payloadCount: serializer.fromJson<int>(json['payloadCount']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      error: serializer.fromJson<String?>(json['error']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'success': serializer.toJson<bool>(success),
      'attemptedAtMs': serializer.toJson<int>(attemptedAtMs),
      'payloadSizeKb': serializer.toJson<int>(payloadSizeKb),
      'payloadCount': serializer.toJson<int>(payloadCount),
      'retryCount': serializer.toJson<int>(retryCount),
      'error': serializer.toJson<String?>(error),
    };
  }

  TelemetryUploadLogData copyWith({
    int? id,
    bool? success,
    int? attemptedAtMs,
    int? payloadSizeKb,
    int? payloadCount,
    int? retryCount,
    Value<String?> error = const Value.absent(),
  }) => TelemetryUploadLogData(
    id: id ?? this.id,
    success: success ?? this.success,
    attemptedAtMs: attemptedAtMs ?? this.attemptedAtMs,
    payloadSizeKb: payloadSizeKb ?? this.payloadSizeKb,
    payloadCount: payloadCount ?? this.payloadCount,
    retryCount: retryCount ?? this.retryCount,
    error: error.present ? error.value : this.error,
  );
  TelemetryUploadLogData copyWithCompanion(TelemetryUploadLogCompanion data) {
    return TelemetryUploadLogData(
      id: data.id.present ? data.id.value : this.id,
      success: data.success.present ? data.success.value : this.success,
      attemptedAtMs: data.attemptedAtMs.present
          ? data.attemptedAtMs.value
          : this.attemptedAtMs,
      payloadSizeKb: data.payloadSizeKb.present
          ? data.payloadSizeKb.value
          : this.payloadSizeKb,
      payloadCount: data.payloadCount.present
          ? data.payloadCount.value
          : this.payloadCount,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      error: data.error.present ? data.error.value : this.error,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TelemetryUploadLogData(')
          ..write('id: $id, ')
          ..write('success: $success, ')
          ..write('attemptedAtMs: $attemptedAtMs, ')
          ..write('payloadSizeKb: $payloadSizeKb, ')
          ..write('payloadCount: $payloadCount, ')
          ..write('retryCount: $retryCount, ')
          ..write('error: $error')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    success,
    attemptedAtMs,
    payloadSizeKb,
    payloadCount,
    retryCount,
    error,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TelemetryUploadLogData &&
          other.id == this.id &&
          other.success == this.success &&
          other.attemptedAtMs == this.attemptedAtMs &&
          other.payloadSizeKb == this.payloadSizeKb &&
          other.payloadCount == this.payloadCount &&
          other.retryCount == this.retryCount &&
          other.error == this.error);
}

class TelemetryUploadLogCompanion
    extends UpdateCompanion<TelemetryUploadLogData> {
  final Value<int> id;
  final Value<bool> success;
  final Value<int> attemptedAtMs;
  final Value<int> payloadSizeKb;
  final Value<int> payloadCount;
  final Value<int> retryCount;
  final Value<String?> error;
  const TelemetryUploadLogCompanion({
    this.id = const Value.absent(),
    this.success = const Value.absent(),
    this.attemptedAtMs = const Value.absent(),
    this.payloadSizeKb = const Value.absent(),
    this.payloadCount = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.error = const Value.absent(),
  });
  TelemetryUploadLogCompanion.insert({
    this.id = const Value.absent(),
    required bool success,
    required int attemptedAtMs,
    required int payloadSizeKb,
    this.payloadCount = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.error = const Value.absent(),
  }) : success = Value(success),
       attemptedAtMs = Value(attemptedAtMs),
       payloadSizeKb = Value(payloadSizeKb);
  static Insertable<TelemetryUploadLogData> custom({
    Expression<int>? id,
    Expression<bool>? success,
    Expression<int>? attemptedAtMs,
    Expression<int>? payloadSizeKb,
    Expression<int>? payloadCount,
    Expression<int>? retryCount,
    Expression<String>? error,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (success != null) 'success': success,
      if (attemptedAtMs != null) 'attempted_at_ms': attemptedAtMs,
      if (payloadSizeKb != null) 'size_kb': payloadSizeKb,
      if (payloadCount != null) 'payload_count': payloadCount,
      if (retryCount != null) 'retry_count': retryCount,
      if (error != null) 'error': error,
    });
  }

  TelemetryUploadLogCompanion copyWith({
    Value<int>? id,
    Value<bool>? success,
    Value<int>? attemptedAtMs,
    Value<int>? payloadSizeKb,
    Value<int>? payloadCount,
    Value<int>? retryCount,
    Value<String?>? error,
  }) {
    return TelemetryUploadLogCompanion(
      id: id ?? this.id,
      success: success ?? this.success,
      attemptedAtMs: attemptedAtMs ?? this.attemptedAtMs,
      payloadSizeKb: payloadSizeKb ?? this.payloadSizeKb,
      payloadCount: payloadCount ?? this.payloadCount,
      retryCount: retryCount ?? this.retryCount,
      error: error ?? this.error,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (success.present) {
      map['success'] = Variable<bool>(success.value);
    }
    if (attemptedAtMs.present) {
      map['attempted_at_ms'] = Variable<int>(attemptedAtMs.value);
    }
    if (payloadSizeKb.present) {
      map['size_kb'] = Variable<int>(payloadSizeKb.value);
    }
    if (payloadCount.present) {
      map['payload_count'] = Variable<int>(payloadCount.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TelemetryUploadLogCompanion(')
          ..write('id: $id, ')
          ..write('success: $success, ')
          ..write('attemptedAtMs: $attemptedAtMs, ')
          ..write('payloadSizeKb: $payloadSizeKb, ')
          ..write('payloadCount: $payloadCount, ')
          ..write('retryCount: $retryCount, ')
          ..write('error: $error')
          ..write(')'))
        .toString();
  }
}

abstract class _$TelemetryDatabase extends GeneratedDatabase {
  _$TelemetryDatabase(QueryExecutor e) : super(e);
  $TelemetryDatabaseManager get managers => $TelemetryDatabaseManager(this);
  late final $TelemetryQueueTable telemetryQueue = $TelemetryQueueTable(this);
  late final $TelemetryUploadLogTable telemetryUploadLog =
      $TelemetryUploadLogTable(this);
  late final Index telemetryQueuePendingReadyIdx = Index(
    'telemetry_queue_pending_ready_idx',
    'CREATE INDEX telemetry_queue_pending_ready_idx ON telemetry_queue (created_at_ms) WHERE delivered_at_ms IS NULL',
  );
  late final Index telemetryQueueCreatedAtIdx = Index(
    'telemetry_queue_created_at_idx',
    'CREATE INDEX telemetry_queue_created_at_idx ON telemetry_queue (created_at_ms)',
  );
  late final Index telemetryUploadLogsAttemptedAtIdx = Index(
    'telemetry_upload_logs_attempted_at_idx',
    'CREATE INDEX telemetry_upload_logs_attempted_at_idx ON telemetry_upload_log (attempted_at_ms DESC)',
  );
  late final Index telemetryUploadLogsAttemptedAtSuccessIdx = Index(
    'telemetry_upload_logs_attempted_at_success_idx',
    'CREATE INDEX telemetry_upload_logs_attempted_at_success_idx ON telemetry_upload_log (attempted_at_ms DESC, success)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    telemetryQueue,
    telemetryUploadLog,
    telemetryQueuePendingReadyIdx,
    telemetryQueueCreatedAtIdx,
    telemetryUploadLogsAttemptedAtIdx,
    telemetryUploadLogsAttemptedAtSuccessIdx,
  ];
}

typedef $$TelemetryQueueTableCreateCompanionBuilder =
    TelemetryQueueCompanion Function({
      required String id,
      required String serializedPayload,
      required int createdAtMs,
      required int startMs,
      Value<int?> uploadedAtMs,
      Value<int> rowid,
    });
typedef $$TelemetryQueueTableUpdateCompanionBuilder =
    TelemetryQueueCompanion Function({
      Value<String> id,
      Value<String> serializedPayload,
      Value<int> createdAtMs,
      Value<int> startMs,
      Value<int?> uploadedAtMs,
      Value<int> rowid,
    });

class $$TelemetryQueueTableFilterComposer
    extends Composer<_$TelemetryDatabase, $TelemetryQueueTable> {
  $$TelemetryQueueTableFilterComposer({
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

  ColumnFilters<String> get serializedPayload => $composableBuilder(
    column: $table.serializedPayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMs => $composableBuilder(
    column: $table.startMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uploadedAtMs => $composableBuilder(
    column: $table.uploadedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TelemetryQueueTableOrderingComposer
    extends Composer<_$TelemetryDatabase, $TelemetryQueueTable> {
  $$TelemetryQueueTableOrderingComposer({
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

  ColumnOrderings<String> get serializedPayload => $composableBuilder(
    column: $table.serializedPayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMs => $composableBuilder(
    column: $table.startMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uploadedAtMs => $composableBuilder(
    column: $table.uploadedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TelemetryQueueTableAnnotationComposer
    extends Composer<_$TelemetryDatabase, $TelemetryQueueTable> {
  $$TelemetryQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serializedPayload => $composableBuilder(
    column: $table.serializedPayload,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMs => $composableBuilder(
    column: $table.createdAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startMs =>
      $composableBuilder(column: $table.startMs, builder: (column) => column);

  GeneratedColumn<int> get uploadedAtMs => $composableBuilder(
    column: $table.uploadedAtMs,
    builder: (column) => column,
  );
}

class $$TelemetryQueueTableTableManager
    extends
        RootTableManager<
          _$TelemetryDatabase,
          $TelemetryQueueTable,
          TelemetryQueueData,
          $$TelemetryQueueTableFilterComposer,
          $$TelemetryQueueTableOrderingComposer,
          $$TelemetryQueueTableAnnotationComposer,
          $$TelemetryQueueTableCreateCompanionBuilder,
          $$TelemetryQueueTableUpdateCompanionBuilder,
          (
            TelemetryQueueData,
            BaseReferences<
              _$TelemetryDatabase,
              $TelemetryQueueTable,
              TelemetryQueueData
            >,
          ),
          TelemetryQueueData,
          PrefetchHooks Function()
        > {
  $$TelemetryQueueTableTableManager(
    _$TelemetryDatabase db,
    $TelemetryQueueTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TelemetryQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TelemetryQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TelemetryQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> serializedPayload = const Value.absent(),
                Value<int> createdAtMs = const Value.absent(),
                Value<int> startMs = const Value.absent(),
                Value<int?> uploadedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TelemetryQueueCompanion(
                id: id,
                serializedPayload: serializedPayload,
                createdAtMs: createdAtMs,
                startMs: startMs,
                uploadedAtMs: uploadedAtMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String serializedPayload,
                required int createdAtMs,
                required int startMs,
                Value<int?> uploadedAtMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TelemetryQueueCompanion.insert(
                id: id,
                serializedPayload: serializedPayload,
                createdAtMs: createdAtMs,
                startMs: startMs,
                uploadedAtMs: uploadedAtMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TelemetryQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$TelemetryDatabase,
      $TelemetryQueueTable,
      TelemetryQueueData,
      $$TelemetryQueueTableFilterComposer,
      $$TelemetryQueueTableOrderingComposer,
      $$TelemetryQueueTableAnnotationComposer,
      $$TelemetryQueueTableCreateCompanionBuilder,
      $$TelemetryQueueTableUpdateCompanionBuilder,
      (
        TelemetryQueueData,
        BaseReferences<
          _$TelemetryDatabase,
          $TelemetryQueueTable,
          TelemetryQueueData
        >,
      ),
      TelemetryQueueData,
      PrefetchHooks Function()
    >;
typedef $$TelemetryUploadLogTableCreateCompanionBuilder =
    TelemetryUploadLogCompanion Function({
      Value<int> id,
      required bool success,
      required int attemptedAtMs,
      required int payloadSizeKb,
      Value<int> payloadCount,
      Value<int> retryCount,
      Value<String?> error,
    });
typedef $$TelemetryUploadLogTableUpdateCompanionBuilder =
    TelemetryUploadLogCompanion Function({
      Value<int> id,
      Value<bool> success,
      Value<int> attemptedAtMs,
      Value<int> payloadSizeKb,
      Value<int> payloadCount,
      Value<int> retryCount,
      Value<String?> error,
    });

class $$TelemetryUploadLogTableFilterComposer
    extends Composer<_$TelemetryDatabase, $TelemetryUploadLogTable> {
  $$TelemetryUploadLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get success => $composableBuilder(
    column: $table.success,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptedAtMs => $composableBuilder(
    column: $table.attemptedAtMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payloadSizeKb => $composableBuilder(
    column: $table.payloadSizeKb,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payloadCount => $composableBuilder(
    column: $table.payloadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TelemetryUploadLogTableOrderingComposer
    extends Composer<_$TelemetryDatabase, $TelemetryUploadLogTable> {
  $$TelemetryUploadLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get success => $composableBuilder(
    column: $table.success,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptedAtMs => $composableBuilder(
    column: $table.attemptedAtMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payloadSizeKb => $composableBuilder(
    column: $table.payloadSizeKb,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payloadCount => $composableBuilder(
    column: $table.payloadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TelemetryUploadLogTableAnnotationComposer
    extends Composer<_$TelemetryDatabase, $TelemetryUploadLogTable> {
  $$TelemetryUploadLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get success =>
      $composableBuilder(column: $table.success, builder: (column) => column);

  GeneratedColumn<int> get attemptedAtMs => $composableBuilder(
    column: $table.attemptedAtMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payloadSizeKb => $composableBuilder(
    column: $table.payloadSizeKb,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payloadCount => $composableBuilder(
    column: $table.payloadCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);
}

class $$TelemetryUploadLogTableTableManager
    extends
        RootTableManager<
          _$TelemetryDatabase,
          $TelemetryUploadLogTable,
          TelemetryUploadLogData,
          $$TelemetryUploadLogTableFilterComposer,
          $$TelemetryUploadLogTableOrderingComposer,
          $$TelemetryUploadLogTableAnnotationComposer,
          $$TelemetryUploadLogTableCreateCompanionBuilder,
          $$TelemetryUploadLogTableUpdateCompanionBuilder,
          (
            TelemetryUploadLogData,
            BaseReferences<
              _$TelemetryDatabase,
              $TelemetryUploadLogTable,
              TelemetryUploadLogData
            >,
          ),
          TelemetryUploadLogData,
          PrefetchHooks Function()
        > {
  $$TelemetryUploadLogTableTableManager(
    _$TelemetryDatabase db,
    $TelemetryUploadLogTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TelemetryUploadLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TelemetryUploadLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TelemetryUploadLogTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> success = const Value.absent(),
                Value<int> attemptedAtMs = const Value.absent(),
                Value<int> payloadSizeKb = const Value.absent(),
                Value<int> payloadCount = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> error = const Value.absent(),
              }) => TelemetryUploadLogCompanion(
                id: id,
                success: success,
                attemptedAtMs: attemptedAtMs,
                payloadSizeKb: payloadSizeKb,
                payloadCount: payloadCount,
                retryCount: retryCount,
                error: error,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool success,
                required int attemptedAtMs,
                required int payloadSizeKb,
                Value<int> payloadCount = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> error = const Value.absent(),
              }) => TelemetryUploadLogCompanion.insert(
                id: id,
                success: success,
                attemptedAtMs: attemptedAtMs,
                payloadSizeKb: payloadSizeKb,
                payloadCount: payloadCount,
                retryCount: retryCount,
                error: error,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TelemetryUploadLogTableProcessedTableManager =
    ProcessedTableManager<
      _$TelemetryDatabase,
      $TelemetryUploadLogTable,
      TelemetryUploadLogData,
      $$TelemetryUploadLogTableFilterComposer,
      $$TelemetryUploadLogTableOrderingComposer,
      $$TelemetryUploadLogTableAnnotationComposer,
      $$TelemetryUploadLogTableCreateCompanionBuilder,
      $$TelemetryUploadLogTableUpdateCompanionBuilder,
      (
        TelemetryUploadLogData,
        BaseReferences<
          _$TelemetryDatabase,
          $TelemetryUploadLogTable,
          TelemetryUploadLogData
        >,
      ),
      TelemetryUploadLogData,
      PrefetchHooks Function()
    >;

class $TelemetryDatabaseManager {
  final _$TelemetryDatabase _db;
  $TelemetryDatabaseManager(this._db);
  $$TelemetryQueueTableTableManager get telemetryQueue =>
      $$TelemetryQueueTableTableManager(_db, _db.telemetryQueue);
  $$TelemetryUploadLogTableTableManager get telemetryUploadLog =>
      $$TelemetryUploadLogTableTableManager(_db, _db.telemetryUploadLog);
}
