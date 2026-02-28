// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page1_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Page1ItemEntityImpl _$$Page1ItemEntityImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$Page1ItemEntityImpl',
      json,
      ($checkedConvert) {
        final val = _$Page1ItemEntityImpl(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          subtitle: $checkedConvert('subtitle', (v) => v as String),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$Page1ItemEntityImplToJson(
        _$Page1ItemEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'createdAt': instance.createdAt.toIso8601String(),
    };
