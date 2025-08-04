// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 22,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _projectNameMeta = const VerificationMeta(
    'projectName',
  );
  @override
  late final GeneratedColumn<String> projectName = GeneratedColumn<String>(
    'project_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 256,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<Uint8List> data = GeneratedColumn<Uint8List>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.blob,
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
    projectId,
    projectName,
    data,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('project_name')) {
      context.handle(
        _projectNameMeta,
        projectName.isAcceptableOrUnknown(
          data['project_name']!,
          _projectNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_projectNameMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
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
  Set<GeneratedColumn> get $primaryKey => {projectId};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      projectName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_name'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}data'],
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
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final String projectId;
  final String projectName;
  final Uint8List data;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Project({
    required this.projectId,
    required this.projectName,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['project_id'] = Variable<String>(projectId);
    map['project_name'] = Variable<String>(projectName);
    map['data'] = Variable<Uint8List>(data);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      projectId: Value(projectId),
      projectName: Value(projectName),
      data: Value(data),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      projectId: serializer.fromJson<String>(json['projectId']),
      projectName: serializer.fromJson<String>(json['projectName']),
      data: serializer.fromJson<Uint8List>(json['data']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'projectId': serializer.toJson<String>(projectId),
      'projectName': serializer.toJson<String>(projectName),
      'data': serializer.toJson<Uint8List>(data),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Project copyWith({
    String? projectId,
    String? projectName,
    Uint8List? data,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Project(
    projectId: projectId ?? this.projectId,
    projectName: projectName ?? this.projectName,
    data: data ?? this.data,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      projectName: data.projectName.present
          ? data.projectName.value
          : this.projectName,
      data: data.data.present ? data.data.value : this.data,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('projectId: $projectId, ')
          ..write('projectName: $projectName, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    projectId,
    projectName,
    $driftBlobEquality.hash(data),
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.projectId == this.projectId &&
          other.projectName == this.projectName &&
          $driftBlobEquality.equals(other.data, this.data) &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> projectId;
  final Value<String> projectName;
  final Value<Uint8List> data;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.projectId = const Value.absent(),
    this.projectName = const Value.absent(),
    this.data = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    required String projectId,
    required String projectName,
    required Uint8List data,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       projectName = Value(projectName),
       data = Value(data),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Project> custom({
    Expression<String>? projectId,
    Expression<String>? projectName,
    Expression<Uint8List>? data,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (projectId != null) 'project_id': projectId,
      if (projectName != null) 'project_name': projectName,
      if (data != null) 'data': data,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? projectId,
    Value<String>? projectName,
    Value<Uint8List>? data,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      data: data ?? this.data,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (projectName.present) {
      map['project_name'] = Variable<String>(projectName.value);
    }
    if (data.present) {
      map['data'] = Variable<Uint8List>(data.value);
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
    return (StringBuffer('ProjectsCompanion(')
          ..write('projectId: $projectId, ')
          ..write('projectName: $projectName, ')
          ..write('data: $data, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 22,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _videoIdMeta = const VerificationMeta(
    'videoId',
  );
  @override
  late final GeneratedColumn<int> videoId = GeneratedColumn<int>(
    'video_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zoneIdMeta = const VerificationMeta('zoneId');
  @override
  late final GeneratedColumn<int> zoneId = GeneratedColumn<int>(
    'zone_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<int> classId = GeneratedColumn<int>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _spawnedMeta = const VerificationMeta(
    'spawned',
  );
  @override
  late final GeneratedColumn<int> spawned = GeneratedColumn<int>(
    'spawned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vanishedMeta = const VerificationMeta(
    'vanished',
  );
  @override
  late final GeneratedColumn<int> vanished = GeneratedColumn<int>(
    'vanished',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enteredMeta = const VerificationMeta(
    'entered',
  );
  @override
  late final GeneratedColumn<int> entered = GeneratedColumn<int>(
    'entered',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exitedMeta = const VerificationMeta('exited');
  @override
  late final GeneratedColumn<int> exited = GeneratedColumn<int>(
    'exited',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stagnantMeta = const VerificationMeta(
    'stagnant',
  );
  @override
  late final GeneratedColumn<int> stagnant = GeneratedColumn<int>(
    'stagnant',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reenteredMeta = const VerificationMeta(
    'reentered',
  );
  @override
  late final GeneratedColumn<int> reentered = GeneratedColumn<int>(
    'reentered',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occupiedMeta = const VerificationMeta(
    'occupied',
  );
  @override
  late final GeneratedColumn<int> occupied = GeneratedColumn<int>(
    'occupied',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stayDurationMeta = const VerificationMeta(
    'stayDuration',
  );
  @override
  late final GeneratedColumn<int> stayDuration = GeneratedColumn<int>(
    'stay_duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    videoId,
    zoneId,
    classId,
    createdAt,
    spawned,
    vanished,
    entered,
    exited,
    stagnant,
    reentered,
    occupied,
    stayDuration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Activity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(
        _videoIdMeta,
        videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('zone_id')) {
      context.handle(
        _zoneIdMeta,
        zoneId.isAcceptableOrUnknown(data['zone_id']!, _zoneIdMeta),
      );
    } else if (isInserting) {
      context.missing(_zoneIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('spawned')) {
      context.handle(
        _spawnedMeta,
        spawned.isAcceptableOrUnknown(data['spawned']!, _spawnedMeta),
      );
    } else if (isInserting) {
      context.missing(_spawnedMeta);
    }
    if (data.containsKey('vanished')) {
      context.handle(
        _vanishedMeta,
        vanished.isAcceptableOrUnknown(data['vanished']!, _vanishedMeta),
      );
    } else if (isInserting) {
      context.missing(_vanishedMeta);
    }
    if (data.containsKey('entered')) {
      context.handle(
        _enteredMeta,
        entered.isAcceptableOrUnknown(data['entered']!, _enteredMeta),
      );
    } else if (isInserting) {
      context.missing(_enteredMeta);
    }
    if (data.containsKey('exited')) {
      context.handle(
        _exitedMeta,
        exited.isAcceptableOrUnknown(data['exited']!, _exitedMeta),
      );
    } else if (isInserting) {
      context.missing(_exitedMeta);
    }
    if (data.containsKey('stagnant')) {
      context.handle(
        _stagnantMeta,
        stagnant.isAcceptableOrUnknown(data['stagnant']!, _stagnantMeta),
      );
    } else if (isInserting) {
      context.missing(_stagnantMeta);
    }
    if (data.containsKey('reentered')) {
      context.handle(
        _reenteredMeta,
        reentered.isAcceptableOrUnknown(data['reentered']!, _reenteredMeta),
      );
    } else if (isInserting) {
      context.missing(_reenteredMeta);
    }
    if (data.containsKey('occupied')) {
      context.handle(
        _occupiedMeta,
        occupied.isAcceptableOrUnknown(data['occupied']!, _occupiedMeta),
      );
    } else if (isInserting) {
      context.missing(_occupiedMeta);
    }
    if (data.containsKey('stay_duration')) {
      context.handle(
        _stayDurationMeta,
        stayDuration.isAcceptableOrUnknown(
          data['stay_duration']!,
          _stayDurationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stayDurationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      videoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}video_id'],
      )!,
      zoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zone_id'],
      )!,
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}class_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      spawned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spawned'],
      )!,
      vanished: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vanished'],
      )!,
      entered: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entered'],
      )!,
      exited: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exited'],
      )!,
      stagnant: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stagnant'],
      )!,
      reentered: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reentered'],
      )!,
      occupied: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occupied'],
      )!,
      stayDuration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stay_duration'],
      )!,
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class Activity extends DataClass implements Insertable<Activity> {
  final int id;
  final String projectId;
  final int videoId;
  final int zoneId;
  final int classId;
  final DateTime createdAt;
  final int spawned;
  final int vanished;
  final int entered;
  final int exited;
  final int stagnant;
  final int reentered;
  final int occupied;
  final int stayDuration;
  const Activity({
    required this.id,
    required this.projectId,
    required this.videoId,
    required this.zoneId,
    required this.classId,
    required this.createdAt,
    required this.spawned,
    required this.vanished,
    required this.entered,
    required this.exited,
    required this.stagnant,
    required this.reentered,
    required this.occupied,
    required this.stayDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<String>(projectId);
    map['video_id'] = Variable<int>(videoId);
    map['zone_id'] = Variable<int>(zoneId);
    map['class_id'] = Variable<int>(classId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['spawned'] = Variable<int>(spawned);
    map['vanished'] = Variable<int>(vanished);
    map['entered'] = Variable<int>(entered);
    map['exited'] = Variable<int>(exited);
    map['stagnant'] = Variable<int>(stagnant);
    map['reentered'] = Variable<int>(reentered);
    map['occupied'] = Variable<int>(occupied);
    map['stay_duration'] = Variable<int>(stayDuration);
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      videoId: Value(videoId),
      zoneId: Value(zoneId),
      classId: Value(classId),
      createdAt: Value(createdAt),
      spawned: Value(spawned),
      vanished: Value(vanished),
      entered: Value(entered),
      exited: Value(exited),
      stagnant: Value(stagnant),
      reentered: Value(reentered),
      occupied: Value(occupied),
      stayDuration: Value(stayDuration),
    );
  }

  factory Activity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<String>(json['projectId']),
      videoId: serializer.fromJson<int>(json['videoId']),
      zoneId: serializer.fromJson<int>(json['zoneId']),
      classId: serializer.fromJson<int>(json['classId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      spawned: serializer.fromJson<int>(json['spawned']),
      vanished: serializer.fromJson<int>(json['vanished']),
      entered: serializer.fromJson<int>(json['entered']),
      exited: serializer.fromJson<int>(json['exited']),
      stagnant: serializer.fromJson<int>(json['stagnant']),
      reentered: serializer.fromJson<int>(json['reentered']),
      occupied: serializer.fromJson<int>(json['occupied']),
      stayDuration: serializer.fromJson<int>(json['stayDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<String>(projectId),
      'videoId': serializer.toJson<int>(videoId),
      'zoneId': serializer.toJson<int>(zoneId),
      'classId': serializer.toJson<int>(classId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'spawned': serializer.toJson<int>(spawned),
      'vanished': serializer.toJson<int>(vanished),
      'entered': serializer.toJson<int>(entered),
      'exited': serializer.toJson<int>(exited),
      'stagnant': serializer.toJson<int>(stagnant),
      'reentered': serializer.toJson<int>(reentered),
      'occupied': serializer.toJson<int>(occupied),
      'stayDuration': serializer.toJson<int>(stayDuration),
    };
  }

  Activity copyWith({
    int? id,
    String? projectId,
    int? videoId,
    int? zoneId,
    int? classId,
    DateTime? createdAt,
    int? spawned,
    int? vanished,
    int? entered,
    int? exited,
    int? stagnant,
    int? reentered,
    int? occupied,
    int? stayDuration,
  }) => Activity(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    videoId: videoId ?? this.videoId,
    zoneId: zoneId ?? this.zoneId,
    classId: classId ?? this.classId,
    createdAt: createdAt ?? this.createdAt,
    spawned: spawned ?? this.spawned,
    vanished: vanished ?? this.vanished,
    entered: entered ?? this.entered,
    exited: exited ?? this.exited,
    stagnant: stagnant ?? this.stagnant,
    reentered: reentered ?? this.reentered,
    occupied: occupied ?? this.occupied,
    stayDuration: stayDuration ?? this.stayDuration,
  );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      zoneId: data.zoneId.present ? data.zoneId.value : this.zoneId,
      classId: data.classId.present ? data.classId.value : this.classId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      spawned: data.spawned.present ? data.spawned.value : this.spawned,
      vanished: data.vanished.present ? data.vanished.value : this.vanished,
      entered: data.entered.present ? data.entered.value : this.entered,
      exited: data.exited.present ? data.exited.value : this.exited,
      stagnant: data.stagnant.present ? data.stagnant.value : this.stagnant,
      reentered: data.reentered.present ? data.reentered.value : this.reentered,
      occupied: data.occupied.present ? data.occupied.value : this.occupied,
      stayDuration: data.stayDuration.present
          ? data.stayDuration.value
          : this.stayDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('videoId: $videoId, ')
          ..write('zoneId: $zoneId, ')
          ..write('classId: $classId, ')
          ..write('createdAt: $createdAt, ')
          ..write('spawned: $spawned, ')
          ..write('vanished: $vanished, ')
          ..write('entered: $entered, ')
          ..write('exited: $exited, ')
          ..write('stagnant: $stagnant, ')
          ..write('reentered: $reentered, ')
          ..write('occupied: $occupied, ')
          ..write('stayDuration: $stayDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    videoId,
    zoneId,
    classId,
    createdAt,
    spawned,
    vanished,
    entered,
    exited,
    stagnant,
    reentered,
    occupied,
    stayDuration,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.videoId == this.videoId &&
          other.zoneId == this.zoneId &&
          other.classId == this.classId &&
          other.createdAt == this.createdAt &&
          other.spawned == this.spawned &&
          other.vanished == this.vanished &&
          other.entered == this.entered &&
          other.exited == this.exited &&
          other.stagnant == this.stagnant &&
          other.reentered == this.reentered &&
          other.occupied == this.occupied &&
          other.stayDuration == this.stayDuration);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<int> id;
  final Value<String> projectId;
  final Value<int> videoId;
  final Value<int> zoneId;
  final Value<int> classId;
  final Value<DateTime> createdAt;
  final Value<int> spawned;
  final Value<int> vanished;
  final Value<int> entered;
  final Value<int> exited;
  final Value<int> stagnant;
  final Value<int> reentered;
  final Value<int> occupied;
  final Value<int> stayDuration;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.videoId = const Value.absent(),
    this.zoneId = const Value.absent(),
    this.classId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.spawned = const Value.absent(),
    this.vanished = const Value.absent(),
    this.entered = const Value.absent(),
    this.exited = const Value.absent(),
    this.stagnant = const Value.absent(),
    this.reentered = const Value.absent(),
    this.occupied = const Value.absent(),
    this.stayDuration = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    this.id = const Value.absent(),
    required String projectId,
    required int videoId,
    required int zoneId,
    required int classId,
    required DateTime createdAt,
    required int spawned,
    required int vanished,
    required int entered,
    required int exited,
    required int stagnant,
    required int reentered,
    required int occupied,
    required int stayDuration,
  }) : projectId = Value(projectId),
       videoId = Value(videoId),
       zoneId = Value(zoneId),
       classId = Value(classId),
       createdAt = Value(createdAt),
       spawned = Value(spawned),
       vanished = Value(vanished),
       entered = Value(entered),
       exited = Value(exited),
       stagnant = Value(stagnant),
       reentered = Value(reentered),
       occupied = Value(occupied),
       stayDuration = Value(stayDuration);
  static Insertable<Activity> custom({
    Expression<int>? id,
    Expression<String>? projectId,
    Expression<int>? videoId,
    Expression<int>? zoneId,
    Expression<int>? classId,
    Expression<DateTime>? createdAt,
    Expression<int>? spawned,
    Expression<int>? vanished,
    Expression<int>? entered,
    Expression<int>? exited,
    Expression<int>? stagnant,
    Expression<int>? reentered,
    Expression<int>? occupied,
    Expression<int>? stayDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (videoId != null) 'video_id': videoId,
      if (zoneId != null) 'zone_id': zoneId,
      if (classId != null) 'class_id': classId,
      if (createdAt != null) 'created_at': createdAt,
      if (spawned != null) 'spawned': spawned,
      if (vanished != null) 'vanished': vanished,
      if (entered != null) 'entered': entered,
      if (exited != null) 'exited': exited,
      if (stagnant != null) 'stagnant': stagnant,
      if (reentered != null) 'reentered': reentered,
      if (occupied != null) 'occupied': occupied,
      if (stayDuration != null) 'stay_duration': stayDuration,
    });
  }

  ActivitiesCompanion copyWith({
    Value<int>? id,
    Value<String>? projectId,
    Value<int>? videoId,
    Value<int>? zoneId,
    Value<int>? classId,
    Value<DateTime>? createdAt,
    Value<int>? spawned,
    Value<int>? vanished,
    Value<int>? entered,
    Value<int>? exited,
    Value<int>? stagnant,
    Value<int>? reentered,
    Value<int>? occupied,
    Value<int>? stayDuration,
  }) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      videoId: videoId ?? this.videoId,
      zoneId: zoneId ?? this.zoneId,
      classId: classId ?? this.classId,
      createdAt: createdAt ?? this.createdAt,
      spawned: spawned ?? this.spawned,
      vanished: vanished ?? this.vanished,
      entered: entered ?? this.entered,
      exited: exited ?? this.exited,
      stagnant: stagnant ?? this.stagnant,
      reentered: reentered ?? this.reentered,
      occupied: occupied ?? this.occupied,
      stayDuration: stayDuration ?? this.stayDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<int>(videoId.value);
    }
    if (zoneId.present) {
      map['zone_id'] = Variable<int>(zoneId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<int>(classId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (spawned.present) {
      map['spawned'] = Variable<int>(spawned.value);
    }
    if (vanished.present) {
      map['vanished'] = Variable<int>(vanished.value);
    }
    if (entered.present) {
      map['entered'] = Variable<int>(entered.value);
    }
    if (exited.present) {
      map['exited'] = Variable<int>(exited.value);
    }
    if (stagnant.present) {
      map['stagnant'] = Variable<int>(stagnant.value);
    }
    if (reentered.present) {
      map['reentered'] = Variable<int>(reentered.value);
    }
    if (occupied.present) {
      map['occupied'] = Variable<int>(occupied.value);
    }
    if (stayDuration.present) {
      map['stay_duration'] = Variable<int>(stayDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('videoId: $videoId, ')
          ..write('zoneId: $zoneId, ')
          ..write('classId: $classId, ')
          ..write('createdAt: $createdAt, ')
          ..write('spawned: $spawned, ')
          ..write('vanished: $vanished, ')
          ..write('entered: $entered, ')
          ..write('exited: $exited, ')
          ..write('stagnant: $stagnant, ')
          ..write('reentered: $reentered, ')
          ..write('occupied: $occupied, ')
          ..write('stayDuration: $stayDuration')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final Index idxProjectsProjectId = Index(
    'idx_projects_project_id',
    'CREATE INDEX idx_projects_project_id ON projects (project_id)',
  );
  late final Index idxProjectsCreatedAt = Index(
    'idx_projects_created_at',
    'CREATE INDEX idx_projects_created_at ON projects (created_at)',
  );
  late final Index idxActivitiesProjectCreatedAt = Index(
    'idx_activities_project_created_at',
    'CREATE INDEX idx_activities_project_created_at ON activities (project_id, created_at)',
  );
  late final Index idxActivitiesCreatedAt = Index(
    'idx_activities_created_at',
    'CREATE INDEX idx_activities_created_at ON activities (created_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    activities,
    idxProjectsProjectId,
    idxProjectsCreatedAt,
    idxActivitiesProjectCreatedAt,
    idxActivitiesCreatedAt,
  ];
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      required String projectId,
      required String projectName,
      required Uint8List data,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<String> projectId,
      Value<String> projectName,
      Value<Uint8List> data,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get projectName => $composableBuilder(
    column: $table.projectName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get data => $composableBuilder(
    column: $table.data,
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

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get projectName => $composableBuilder(
    column: $table.projectName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get data => $composableBuilder(
    column: $table.data,
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

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<String> get projectName => $composableBuilder(
    column: $table.projectName,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
          Project,
          PrefetchHooks Function()
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> projectId = const Value.absent(),
                Value<String> projectName = const Value.absent(),
                Value<Uint8List> data = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                projectId: projectId,
                projectName: projectName,
                data: data,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String projectId,
                required String projectName,
                required Uint8List data,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                projectId: projectId,
                projectName: projectName,
                data: data,
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

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, BaseReferences<_$AppDatabase, $ProjectsTable, Project>),
      Project,
      PrefetchHooks Function()
    >;
typedef $$ActivitiesTableCreateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> id,
      required String projectId,
      required int videoId,
      required int zoneId,
      required int classId,
      required DateTime createdAt,
      required int spawned,
      required int vanished,
      required int entered,
      required int exited,
      required int stagnant,
      required int reentered,
      required int occupied,
      required int stayDuration,
    });
typedef $$ActivitiesTableUpdateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> id,
      Value<String> projectId,
      Value<int> videoId,
      Value<int> zoneId,
      Value<int> classId,
      Value<DateTime> createdAt,
      Value<int> spawned,
      Value<int> vanished,
      Value<int> entered,
      Value<int> exited,
      Value<int> stagnant,
      Value<int> reentered,
      Value<int> occupied,
      Value<int> stayDuration,
    });

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
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

  ColumnFilters<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get videoId => $composableBuilder(
    column: $table.videoId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get zoneId => $composableBuilder(
    column: $table.zoneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spawned => $composableBuilder(
    column: $table.spawned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vanished => $composableBuilder(
    column: $table.vanished,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entered => $composableBuilder(
    column: $table.entered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exited => $composableBuilder(
    column: $table.exited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stagnant => $composableBuilder(
    column: $table.stagnant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reentered => $composableBuilder(
    column: $table.reentered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occupied => $composableBuilder(
    column: $table.occupied,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stayDuration => $composableBuilder(
    column: $table.stayDuration,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
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

  ColumnOrderings<String> get projectId => $composableBuilder(
    column: $table.projectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get videoId => $composableBuilder(
    column: $table.videoId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get zoneId => $composableBuilder(
    column: $table.zoneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spawned => $composableBuilder(
    column: $table.spawned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vanished => $composableBuilder(
    column: $table.vanished,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entered => $composableBuilder(
    column: $table.entered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exited => $composableBuilder(
    column: $table.exited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stagnant => $composableBuilder(
    column: $table.stagnant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reentered => $composableBuilder(
    column: $table.reentered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occupied => $composableBuilder(
    column: $table.occupied,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stayDuration => $composableBuilder(
    column: $table.stayDuration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get projectId =>
      $composableBuilder(column: $table.projectId, builder: (column) => column);

  GeneratedColumn<int> get videoId =>
      $composableBuilder(column: $table.videoId, builder: (column) => column);

  GeneratedColumn<int> get zoneId =>
      $composableBuilder(column: $table.zoneId, builder: (column) => column);

  GeneratedColumn<int> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get spawned =>
      $composableBuilder(column: $table.spawned, builder: (column) => column);

  GeneratedColumn<int> get vanished =>
      $composableBuilder(column: $table.vanished, builder: (column) => column);

  GeneratedColumn<int> get entered =>
      $composableBuilder(column: $table.entered, builder: (column) => column);

  GeneratedColumn<int> get exited =>
      $composableBuilder(column: $table.exited, builder: (column) => column);

  GeneratedColumn<int> get stagnant =>
      $composableBuilder(column: $table.stagnant, builder: (column) => column);

  GeneratedColumn<int> get reentered =>
      $composableBuilder(column: $table.reentered, builder: (column) => column);

  GeneratedColumn<int> get occupied =>
      $composableBuilder(column: $table.occupied, builder: (column) => column);

  GeneratedColumn<int> get stayDuration => $composableBuilder(
    column: $table.stayDuration,
    builder: (column) => column,
  );
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitiesTable,
          Activity,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (Activity, BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>),
          Activity,
          PrefetchHooks Function()
        > {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<int> videoId = const Value.absent(),
                Value<int> zoneId = const Value.absent(),
                Value<int> classId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> spawned = const Value.absent(),
                Value<int> vanished = const Value.absent(),
                Value<int> entered = const Value.absent(),
                Value<int> exited = const Value.absent(),
                Value<int> stagnant = const Value.absent(),
                Value<int> reentered = const Value.absent(),
                Value<int> occupied = const Value.absent(),
                Value<int> stayDuration = const Value.absent(),
              }) => ActivitiesCompanion(
                id: id,
                projectId: projectId,
                videoId: videoId,
                zoneId: zoneId,
                classId: classId,
                createdAt: createdAt,
                spawned: spawned,
                vanished: vanished,
                entered: entered,
                exited: exited,
                stagnant: stagnant,
                reentered: reentered,
                occupied: occupied,
                stayDuration: stayDuration,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String projectId,
                required int videoId,
                required int zoneId,
                required int classId,
                required DateTime createdAt,
                required int spawned,
                required int vanished,
                required int entered,
                required int exited,
                required int stagnant,
                required int reentered,
                required int occupied,
                required int stayDuration,
              }) => ActivitiesCompanion.insert(
                id: id,
                projectId: projectId,
                videoId: videoId,
                zoneId: zoneId,
                classId: classId,
                createdAt: createdAt,
                spawned: spawned,
                vanished: vanished,
                entered: entered,
                exited: exited,
                stagnant: stagnant,
                reentered: reentered,
                occupied: occupied,
                stayDuration: stayDuration,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitiesTable,
      Activity,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (Activity, BaseReferences<_$AppDatabase, $ActivitiesTable, Activity>),
      Activity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
}
