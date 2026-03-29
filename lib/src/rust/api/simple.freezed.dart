// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UiCommand {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) toggleStage,
    required TResult Function(String slimeId, String hatId) equipHat,
    required TResult Function(String missionId, List<String> operatorIds)
    launchMission,
    required TResult Function(String id, String newName) renameSlime,
    required TResult Function() syncState,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? toggleStage,
    TResult? Function(String slimeId, String hatId)? equipHat,
    TResult? Function(String missionId, List<String> operatorIds)?
    launchMission,
    TResult? Function(String id, String newName)? renameSlime,
    TResult? Function()? syncState,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? toggleStage,
    TResult Function(String slimeId, String hatId)? equipHat,
    TResult Function(String missionId, List<String> operatorIds)? launchMission,
    TResult Function(String id, String newName)? renameSlime,
    TResult Function()? syncState,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UiCommand_ToggleStage value) toggleStage,
    required TResult Function(UiCommand_EquipHat value) equipHat,
    required TResult Function(UiCommand_LaunchMission value) launchMission,
    required TResult Function(UiCommand_RenameSlime value) renameSlime,
    required TResult Function(UiCommand_SyncState value) syncState,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UiCommand_ToggleStage value)? toggleStage,
    TResult? Function(UiCommand_EquipHat value)? equipHat,
    TResult? Function(UiCommand_LaunchMission value)? launchMission,
    TResult? Function(UiCommand_RenameSlime value)? renameSlime,
    TResult? Function(UiCommand_SyncState value)? syncState,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UiCommand_ToggleStage value)? toggleStage,
    TResult Function(UiCommand_EquipHat value)? equipHat,
    TResult Function(UiCommand_LaunchMission value)? launchMission,
    TResult Function(UiCommand_RenameSlime value)? renameSlime,
    TResult Function(UiCommand_SyncState value)? syncState,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiCommandCopyWith<$Res> {
  factory $UiCommandCopyWith(UiCommand value, $Res Function(UiCommand) then) =
      _$UiCommandCopyWithImpl<$Res, UiCommand>;
}

/// @nodoc
class _$UiCommandCopyWithImpl<$Res, $Val extends UiCommand>
    implements $UiCommandCopyWith<$Res> {
  _$UiCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$UiCommand_ToggleStageImplCopyWith<$Res> {
  factory _$$UiCommand_ToggleStageImplCopyWith(
    _$UiCommand_ToggleStageImpl value,
    $Res Function(_$UiCommand_ToggleStageImpl) then,
  ) = __$$UiCommand_ToggleStageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$UiCommand_ToggleStageImplCopyWithImpl<$Res>
    extends _$UiCommandCopyWithImpl<$Res, _$UiCommand_ToggleStageImpl>
    implements _$$UiCommand_ToggleStageImplCopyWith<$Res> {
  __$$UiCommand_ToggleStageImplCopyWithImpl(
    _$UiCommand_ToggleStageImpl _value,
    $Res Function(_$UiCommand_ToggleStageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$UiCommand_ToggleStageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UiCommand_ToggleStageImpl extends UiCommand_ToggleStage {
  const _$UiCommand_ToggleStageImpl({required this.id}) : super._();

  @override
  final String id;

  @override
  String toString() {
    return 'UiCommand.toggleStage(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiCommand_ToggleStageImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiCommand_ToggleStageImplCopyWith<_$UiCommand_ToggleStageImpl>
  get copyWith =>
      __$$UiCommand_ToggleStageImplCopyWithImpl<_$UiCommand_ToggleStageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) toggleStage,
    required TResult Function(String slimeId, String hatId) equipHat,
    required TResult Function(String missionId, List<String> operatorIds)
    launchMission,
    required TResult Function(String id, String newName) renameSlime,
    required TResult Function() syncState,
  }) {
    return toggleStage(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? toggleStage,
    TResult? Function(String slimeId, String hatId)? equipHat,
    TResult? Function(String missionId, List<String> operatorIds)?
    launchMission,
    TResult? Function(String id, String newName)? renameSlime,
    TResult? Function()? syncState,
  }) {
    return toggleStage?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? toggleStage,
    TResult Function(String slimeId, String hatId)? equipHat,
    TResult Function(String missionId, List<String> operatorIds)? launchMission,
    TResult Function(String id, String newName)? renameSlime,
    TResult Function()? syncState,
    required TResult orElse(),
  }) {
    if (toggleStage != null) {
      return toggleStage(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UiCommand_ToggleStage value) toggleStage,
    required TResult Function(UiCommand_EquipHat value) equipHat,
    required TResult Function(UiCommand_LaunchMission value) launchMission,
    required TResult Function(UiCommand_RenameSlime value) renameSlime,
    required TResult Function(UiCommand_SyncState value) syncState,
  }) {
    return toggleStage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UiCommand_ToggleStage value)? toggleStage,
    TResult? Function(UiCommand_EquipHat value)? equipHat,
    TResult? Function(UiCommand_LaunchMission value)? launchMission,
    TResult? Function(UiCommand_RenameSlime value)? renameSlime,
    TResult? Function(UiCommand_SyncState value)? syncState,
  }) {
    return toggleStage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UiCommand_ToggleStage value)? toggleStage,
    TResult Function(UiCommand_EquipHat value)? equipHat,
    TResult Function(UiCommand_LaunchMission value)? launchMission,
    TResult Function(UiCommand_RenameSlime value)? renameSlime,
    TResult Function(UiCommand_SyncState value)? syncState,
    required TResult orElse(),
  }) {
    if (toggleStage != null) {
      return toggleStage(this);
    }
    return orElse();
  }
}

abstract class UiCommand_ToggleStage extends UiCommand {
  const factory UiCommand_ToggleStage({required final String id}) =
      _$UiCommand_ToggleStageImpl;
  const UiCommand_ToggleStage._() : super._();

  String get id;

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiCommand_ToggleStageImplCopyWith<_$UiCommand_ToggleStageImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UiCommand_EquipHatImplCopyWith<$Res> {
  factory _$$UiCommand_EquipHatImplCopyWith(
    _$UiCommand_EquipHatImpl value,
    $Res Function(_$UiCommand_EquipHatImpl) then,
  ) = __$$UiCommand_EquipHatImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String slimeId, String hatId});
}

/// @nodoc
class __$$UiCommand_EquipHatImplCopyWithImpl<$Res>
    extends _$UiCommandCopyWithImpl<$Res, _$UiCommand_EquipHatImpl>
    implements _$$UiCommand_EquipHatImplCopyWith<$Res> {
  __$$UiCommand_EquipHatImplCopyWithImpl(
    _$UiCommand_EquipHatImpl _value,
    $Res Function(_$UiCommand_EquipHatImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? slimeId = null, Object? hatId = null}) {
    return _then(
      _$UiCommand_EquipHatImpl(
        slimeId: null == slimeId
            ? _value.slimeId
            : slimeId // ignore: cast_nullable_to_non_nullable
                  as String,
        hatId: null == hatId
            ? _value.hatId
            : hatId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UiCommand_EquipHatImpl extends UiCommand_EquipHat {
  const _$UiCommand_EquipHatImpl({required this.slimeId, required this.hatId})
    : super._();

  @override
  final String slimeId;
  @override
  final String hatId;

  @override
  String toString() {
    return 'UiCommand.equipHat(slimeId: $slimeId, hatId: $hatId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiCommand_EquipHatImpl &&
            (identical(other.slimeId, slimeId) || other.slimeId == slimeId) &&
            (identical(other.hatId, hatId) || other.hatId == hatId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, slimeId, hatId);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiCommand_EquipHatImplCopyWith<_$UiCommand_EquipHatImpl> get copyWith =>
      __$$UiCommand_EquipHatImplCopyWithImpl<_$UiCommand_EquipHatImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) toggleStage,
    required TResult Function(String slimeId, String hatId) equipHat,
    required TResult Function(String missionId, List<String> operatorIds)
    launchMission,
    required TResult Function(String id, String newName) renameSlime,
    required TResult Function() syncState,
  }) {
    return equipHat(slimeId, hatId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? toggleStage,
    TResult? Function(String slimeId, String hatId)? equipHat,
    TResult? Function(String missionId, List<String> operatorIds)?
    launchMission,
    TResult? Function(String id, String newName)? renameSlime,
    TResult? Function()? syncState,
  }) {
    return equipHat?.call(slimeId, hatId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? toggleStage,
    TResult Function(String slimeId, String hatId)? equipHat,
    TResult Function(String missionId, List<String> operatorIds)? launchMission,
    TResult Function(String id, String newName)? renameSlime,
    TResult Function()? syncState,
    required TResult orElse(),
  }) {
    if (equipHat != null) {
      return equipHat(slimeId, hatId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UiCommand_ToggleStage value) toggleStage,
    required TResult Function(UiCommand_EquipHat value) equipHat,
    required TResult Function(UiCommand_LaunchMission value) launchMission,
    required TResult Function(UiCommand_RenameSlime value) renameSlime,
    required TResult Function(UiCommand_SyncState value) syncState,
  }) {
    return equipHat(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UiCommand_ToggleStage value)? toggleStage,
    TResult? Function(UiCommand_EquipHat value)? equipHat,
    TResult? Function(UiCommand_LaunchMission value)? launchMission,
    TResult? Function(UiCommand_RenameSlime value)? renameSlime,
    TResult? Function(UiCommand_SyncState value)? syncState,
  }) {
    return equipHat?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UiCommand_ToggleStage value)? toggleStage,
    TResult Function(UiCommand_EquipHat value)? equipHat,
    TResult Function(UiCommand_LaunchMission value)? launchMission,
    TResult Function(UiCommand_RenameSlime value)? renameSlime,
    TResult Function(UiCommand_SyncState value)? syncState,
    required TResult orElse(),
  }) {
    if (equipHat != null) {
      return equipHat(this);
    }
    return orElse();
  }
}

abstract class UiCommand_EquipHat extends UiCommand {
  const factory UiCommand_EquipHat({
    required final String slimeId,
    required final String hatId,
  }) = _$UiCommand_EquipHatImpl;
  const UiCommand_EquipHat._() : super._();

  String get slimeId;
  String get hatId;

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiCommand_EquipHatImplCopyWith<_$UiCommand_EquipHatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UiCommand_LaunchMissionImplCopyWith<$Res> {
  factory _$$UiCommand_LaunchMissionImplCopyWith(
    _$UiCommand_LaunchMissionImpl value,
    $Res Function(_$UiCommand_LaunchMissionImpl) then,
  ) = __$$UiCommand_LaunchMissionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String missionId, List<String> operatorIds});
}

/// @nodoc
class __$$UiCommand_LaunchMissionImplCopyWithImpl<$Res>
    extends _$UiCommandCopyWithImpl<$Res, _$UiCommand_LaunchMissionImpl>
    implements _$$UiCommand_LaunchMissionImplCopyWith<$Res> {
  __$$UiCommand_LaunchMissionImplCopyWithImpl(
    _$UiCommand_LaunchMissionImpl _value,
    $Res Function(_$UiCommand_LaunchMissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? missionId = null, Object? operatorIds = null}) {
    return _then(
      _$UiCommand_LaunchMissionImpl(
        missionId: null == missionId
            ? _value.missionId
            : missionId // ignore: cast_nullable_to_non_nullable
                  as String,
        operatorIds: null == operatorIds
            ? _value._operatorIds
            : operatorIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$UiCommand_LaunchMissionImpl extends UiCommand_LaunchMission {
  const _$UiCommand_LaunchMissionImpl({
    required this.missionId,
    required final List<String> operatorIds,
  }) : _operatorIds = operatorIds,
       super._();

  @override
  final String missionId;
  final List<String> _operatorIds;
  @override
  List<String> get operatorIds {
    if (_operatorIds is EqualUnmodifiableListView) return _operatorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_operatorIds);
  }

  @override
  String toString() {
    return 'UiCommand.launchMission(missionId: $missionId, operatorIds: $operatorIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiCommand_LaunchMissionImpl &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            const DeepCollectionEquality().equals(
              other._operatorIds,
              _operatorIds,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    missionId,
    const DeepCollectionEquality().hash(_operatorIds),
  );

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiCommand_LaunchMissionImplCopyWith<_$UiCommand_LaunchMissionImpl>
  get copyWith =>
      __$$UiCommand_LaunchMissionImplCopyWithImpl<
        _$UiCommand_LaunchMissionImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) toggleStage,
    required TResult Function(String slimeId, String hatId) equipHat,
    required TResult Function(String missionId, List<String> operatorIds)
    launchMission,
    required TResult Function(String id, String newName) renameSlime,
    required TResult Function() syncState,
  }) {
    return launchMission(missionId, operatorIds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? toggleStage,
    TResult? Function(String slimeId, String hatId)? equipHat,
    TResult? Function(String missionId, List<String> operatorIds)?
    launchMission,
    TResult? Function(String id, String newName)? renameSlime,
    TResult? Function()? syncState,
  }) {
    return launchMission?.call(missionId, operatorIds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? toggleStage,
    TResult Function(String slimeId, String hatId)? equipHat,
    TResult Function(String missionId, List<String> operatorIds)? launchMission,
    TResult Function(String id, String newName)? renameSlime,
    TResult Function()? syncState,
    required TResult orElse(),
  }) {
    if (launchMission != null) {
      return launchMission(missionId, operatorIds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UiCommand_ToggleStage value) toggleStage,
    required TResult Function(UiCommand_EquipHat value) equipHat,
    required TResult Function(UiCommand_LaunchMission value) launchMission,
    required TResult Function(UiCommand_RenameSlime value) renameSlime,
    required TResult Function(UiCommand_SyncState value) syncState,
  }) {
    return launchMission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UiCommand_ToggleStage value)? toggleStage,
    TResult? Function(UiCommand_EquipHat value)? equipHat,
    TResult? Function(UiCommand_LaunchMission value)? launchMission,
    TResult? Function(UiCommand_RenameSlime value)? renameSlime,
    TResult? Function(UiCommand_SyncState value)? syncState,
  }) {
    return launchMission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UiCommand_ToggleStage value)? toggleStage,
    TResult Function(UiCommand_EquipHat value)? equipHat,
    TResult Function(UiCommand_LaunchMission value)? launchMission,
    TResult Function(UiCommand_RenameSlime value)? renameSlime,
    TResult Function(UiCommand_SyncState value)? syncState,
    required TResult orElse(),
  }) {
    if (launchMission != null) {
      return launchMission(this);
    }
    return orElse();
  }
}

abstract class UiCommand_LaunchMission extends UiCommand {
  const factory UiCommand_LaunchMission({
    required final String missionId,
    required final List<String> operatorIds,
  }) = _$UiCommand_LaunchMissionImpl;
  const UiCommand_LaunchMission._() : super._();

  String get missionId;
  List<String> get operatorIds;

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiCommand_LaunchMissionImplCopyWith<_$UiCommand_LaunchMissionImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UiCommand_RenameSlimeImplCopyWith<$Res> {
  factory _$$UiCommand_RenameSlimeImplCopyWith(
    _$UiCommand_RenameSlimeImpl value,
    $Res Function(_$UiCommand_RenameSlimeImpl) then,
  ) = __$$UiCommand_RenameSlimeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String newName});
}

/// @nodoc
class __$$UiCommand_RenameSlimeImplCopyWithImpl<$Res>
    extends _$UiCommandCopyWithImpl<$Res, _$UiCommand_RenameSlimeImpl>
    implements _$$UiCommand_RenameSlimeImplCopyWith<$Res> {
  __$$UiCommand_RenameSlimeImplCopyWithImpl(
    _$UiCommand_RenameSlimeImpl _value,
    $Res Function(_$UiCommand_RenameSlimeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? newName = null}) {
    return _then(
      _$UiCommand_RenameSlimeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        newName: null == newName
            ? _value.newName
            : newName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UiCommand_RenameSlimeImpl extends UiCommand_RenameSlime {
  const _$UiCommand_RenameSlimeImpl({required this.id, required this.newName})
    : super._();

  @override
  final String id;
  @override
  final String newName;

  @override
  String toString() {
    return 'UiCommand.renameSlime(id: $id, newName: $newName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiCommand_RenameSlimeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.newName, newName) || other.newName == newName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, newName);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiCommand_RenameSlimeImplCopyWith<_$UiCommand_RenameSlimeImpl>
  get copyWith =>
      __$$UiCommand_RenameSlimeImplCopyWithImpl<_$UiCommand_RenameSlimeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) toggleStage,
    required TResult Function(String slimeId, String hatId) equipHat,
    required TResult Function(String missionId, List<String> operatorIds)
    launchMission,
    required TResult Function(String id, String newName) renameSlime,
    required TResult Function() syncState,
  }) {
    return renameSlime(id, newName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? toggleStage,
    TResult? Function(String slimeId, String hatId)? equipHat,
    TResult? Function(String missionId, List<String> operatorIds)?
    launchMission,
    TResult? Function(String id, String newName)? renameSlime,
    TResult? Function()? syncState,
  }) {
    return renameSlime?.call(id, newName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? toggleStage,
    TResult Function(String slimeId, String hatId)? equipHat,
    TResult Function(String missionId, List<String> operatorIds)? launchMission,
    TResult Function(String id, String newName)? renameSlime,
    TResult Function()? syncState,
    required TResult orElse(),
  }) {
    if (renameSlime != null) {
      return renameSlime(id, newName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UiCommand_ToggleStage value) toggleStage,
    required TResult Function(UiCommand_EquipHat value) equipHat,
    required TResult Function(UiCommand_LaunchMission value) launchMission,
    required TResult Function(UiCommand_RenameSlime value) renameSlime,
    required TResult Function(UiCommand_SyncState value) syncState,
  }) {
    return renameSlime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UiCommand_ToggleStage value)? toggleStage,
    TResult? Function(UiCommand_EquipHat value)? equipHat,
    TResult? Function(UiCommand_LaunchMission value)? launchMission,
    TResult? Function(UiCommand_RenameSlime value)? renameSlime,
    TResult? Function(UiCommand_SyncState value)? syncState,
  }) {
    return renameSlime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UiCommand_ToggleStage value)? toggleStage,
    TResult Function(UiCommand_EquipHat value)? equipHat,
    TResult Function(UiCommand_LaunchMission value)? launchMission,
    TResult Function(UiCommand_RenameSlime value)? renameSlime,
    TResult Function(UiCommand_SyncState value)? syncState,
    required TResult orElse(),
  }) {
    if (renameSlime != null) {
      return renameSlime(this);
    }
    return orElse();
  }
}

abstract class UiCommand_RenameSlime extends UiCommand {
  const factory UiCommand_RenameSlime({
    required final String id,
    required final String newName,
  }) = _$UiCommand_RenameSlimeImpl;
  const UiCommand_RenameSlime._() : super._();

  String get id;
  String get newName;

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiCommand_RenameSlimeImplCopyWith<_$UiCommand_RenameSlimeImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UiCommand_SyncStateImplCopyWith<$Res> {
  factory _$$UiCommand_SyncStateImplCopyWith(
    _$UiCommand_SyncStateImpl value,
    $Res Function(_$UiCommand_SyncStateImpl) then,
  ) = __$$UiCommand_SyncStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UiCommand_SyncStateImplCopyWithImpl<$Res>
    extends _$UiCommandCopyWithImpl<$Res, _$UiCommand_SyncStateImpl>
    implements _$$UiCommand_SyncStateImplCopyWith<$Res> {
  __$$UiCommand_SyncStateImplCopyWithImpl(
    _$UiCommand_SyncStateImpl _value,
    $Res Function(_$UiCommand_SyncStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UiCommand
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UiCommand_SyncStateImpl extends UiCommand_SyncState {
  const _$UiCommand_SyncStateImpl() : super._();

  @override
  String toString() {
    return 'UiCommand.syncState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiCommand_SyncStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) toggleStage,
    required TResult Function(String slimeId, String hatId) equipHat,
    required TResult Function(String missionId, List<String> operatorIds)
    launchMission,
    required TResult Function(String id, String newName) renameSlime,
    required TResult Function() syncState,
  }) {
    return syncState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? toggleStage,
    TResult? Function(String slimeId, String hatId)? equipHat,
    TResult? Function(String missionId, List<String> operatorIds)?
    launchMission,
    TResult? Function(String id, String newName)? renameSlime,
    TResult? Function()? syncState,
  }) {
    return syncState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? toggleStage,
    TResult Function(String slimeId, String hatId)? equipHat,
    TResult Function(String missionId, List<String> operatorIds)? launchMission,
    TResult Function(String id, String newName)? renameSlime,
    TResult Function()? syncState,
    required TResult orElse(),
  }) {
    if (syncState != null) {
      return syncState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UiCommand_ToggleStage value) toggleStage,
    required TResult Function(UiCommand_EquipHat value) equipHat,
    required TResult Function(UiCommand_LaunchMission value) launchMission,
    required TResult Function(UiCommand_RenameSlime value) renameSlime,
    required TResult Function(UiCommand_SyncState value) syncState,
  }) {
    return syncState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UiCommand_ToggleStage value)? toggleStage,
    TResult? Function(UiCommand_EquipHat value)? equipHat,
    TResult? Function(UiCommand_LaunchMission value)? launchMission,
    TResult? Function(UiCommand_RenameSlime value)? renameSlime,
    TResult? Function(UiCommand_SyncState value)? syncState,
  }) {
    return syncState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UiCommand_ToggleStage value)? toggleStage,
    TResult Function(UiCommand_EquipHat value)? equipHat,
    TResult Function(UiCommand_LaunchMission value)? launchMission,
    TResult Function(UiCommand_RenameSlime value)? renameSlime,
    TResult Function(UiCommand_SyncState value)? syncState,
    required TResult orElse(),
  }) {
    if (syncState != null) {
      return syncState(this);
    }
    return orElse();
  }
}

abstract class UiCommand_SyncState extends UiCommand {
  const factory UiCommand_SyncState() = _$UiCommand_SyncStateImpl;
  const UiCommand_SyncState._() : super._();
}
