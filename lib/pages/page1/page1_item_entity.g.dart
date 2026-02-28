// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page1_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Page1ItemEntityImpl _$$Page1ItemEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$Page1ItemEntityImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$Page1ItemEntityImplToJson(
        _$Page1ItemEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'createdAt': instance.createdAt.toIso8601String(),
    };
