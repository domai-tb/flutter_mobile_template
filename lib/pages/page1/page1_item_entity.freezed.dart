// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page1_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Page1ItemEntity _$Page1ItemEntityFromJson(Map<String, dynamic> json) {
  return _Page1ItemEntity.fromJson(json);
}

/// @nodoc
mixin _$Page1ItemEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Page1ItemEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Page1ItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Page1ItemEntityCopyWith<Page1ItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Page1ItemEntityCopyWith<$Res> {
  factory $Page1ItemEntityCopyWith(
          Page1ItemEntity value, $Res Function(Page1ItemEntity) then) =
      _$Page1ItemEntityCopyWithImpl<$Res, Page1ItemEntity>;
  @useResult
  $Res call({String id, String title, String subtitle, DateTime createdAt});
}

/// @nodoc
class _$Page1ItemEntityCopyWithImpl<$Res, $Val extends Page1ItemEntity>
    implements $Page1ItemEntityCopyWith<$Res> {
  _$Page1ItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Page1ItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Page1ItemEntityImplCopyWith<$Res>
    implements $Page1ItemEntityCopyWith<$Res> {
  factory _$$Page1ItemEntityImplCopyWith(_$Page1ItemEntityImpl value,
          $Res Function(_$Page1ItemEntityImpl) then) =
      __$$Page1ItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String subtitle, DateTime createdAt});
}

/// @nodoc
class __$$Page1ItemEntityImplCopyWithImpl<$Res>
    extends _$Page1ItemEntityCopyWithImpl<$Res, _$Page1ItemEntityImpl>
    implements _$$Page1ItemEntityImplCopyWith<$Res> {
  __$$Page1ItemEntityImplCopyWithImpl(
      _$Page1ItemEntityImpl _value, $Res Function(_$Page1ItemEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of Page1ItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = null,
    Object? createdAt = null,
  }) {
    return _then(_$Page1ItemEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Page1ItemEntityImpl implements _Page1ItemEntity {
  const _$Page1ItemEntityImpl(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.createdAt});

  factory _$Page1ItemEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$Page1ItemEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Page1ItemEntity(id: $id, title: $title, subtitle: $subtitle, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Page1ItemEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, subtitle, createdAt);

  /// Create a copy of Page1ItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Page1ItemEntityImplCopyWith<_$Page1ItemEntityImpl> get copyWith =>
      __$$Page1ItemEntityImplCopyWithImpl<_$Page1ItemEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Page1ItemEntityImplToJson(
      this,
    );
  }
}

abstract class _Page1ItemEntity implements Page1ItemEntity {
  const factory _Page1ItemEntity(
      {required final String id,
      required final String title,
      required final String subtitle,
      required final DateTime createdAt}) = _$Page1ItemEntityImpl;

  factory _Page1ItemEntity.fromJson(Map<String, dynamic> json) =
      _$Page1ItemEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  DateTime get createdAt;

  /// Create a copy of Page1ItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Page1ItemEntityImplCopyWith<_$Page1ItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
