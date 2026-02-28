import 'package:freezed_annotation/freezed_annotation.dart';

part 'page1_item_entity.freezed.dart';
part 'page1_item_entity.g.dart';

/// Represents an item in Page 1.
///
/// This is an immutable data class using freezed for value equality,
/// JSON serialization, and copy functionality.
@freezed
class Page1ItemEntity with _$Page1ItemEntity {
  const factory Page1ItemEntity({
    required String id,
    required String title,
    required String subtitle,
    required DateTime createdAt,
  }) = _Page1ItemEntity;

  /// Create instance from JSON.
  factory Page1ItemEntity.fromJson(Map<String, dynamic> json) =>
      _$Page1ItemEntityFromJson(json);
}
