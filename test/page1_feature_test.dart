import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mobile_app_skeleton/pages/page1/page1_datasource.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_item_entity.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_repository.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_usecases.dart';

/// Mock classes for testing.
class MockPage1DataSource extends Mock implements Page1DataSource {}

class MockPage1Repository extends Mock implements Page1Repository {}

void main() {
  group('Page1 Feature Tests', () {
    group('Page1Usecases', () {
      test('returns placeholder items', () async {
        final usecases = Page1Usecases(
          repository: Page1Repository(dataSource: Page1DataSource()),
        );

        final items = await usecases.getItems();
        expect(items, isNotEmpty);
        expect(items.length, 20);
      });

      test('supports query filtering', () async {
        final usecases = Page1Usecases(
          repository: Page1Repository(dataSource: Page1DataSource()),
        );

        final all = await usecases.getItems();
        final firstTitleWord = all.first.title.split(' ').last; // "1"
        final filtered = await usecases.getItems(query: firstTitleWord);

        expect(filtered, isNotEmpty);
        expect(filtered.length, lessThanOrEqualTo(all.length));
      });

      test('returns empty list when no items match query', () async {
        final usecases = Page1Usecases(
          repository: Page1Repository(dataSource: Page1DataSource()),
        );

        final filtered =
            await usecases.getItems(query: 'nonexistent_query_xyz');

        expect(filtered, isEmpty);
      });
    });

    group('Page1Repository', () {
      late MockPage1DataSource mockDataSource;
      late Page1Repository repository;

      setUp(() {
        mockDataSource = MockPage1DataSource();
        repository = Page1Repository(dataSource: mockDataSource);
      });

      test('delegates to datasource for fetching items', () async {
        final testItems = [
          Page1ItemEntity(
            id: '1',
            title: 'Test Item',
            subtitle: 'Test Subtitle',
            createdAt: DateTime.now(),
          ),
        ];

        when(() => mockDataSource.fetchItems(query: any(named: 'query')))
            .thenAnswer((_) async => testItems);

        final result = await repository.getItems();

        expect(result, equals(testItems));
        verify(() => mockDataSource.fetchItems(query: any(named: 'query')))
            .called(1);
      });
    });

    group('Page1ItemEntity', () {
      test('creates entity with required fields', () {
        final now = DateTime.now();
        final entity = Page1ItemEntity(
          id: '123',
          title: 'Test Title',
          subtitle: 'Test Subtitle',
          createdAt: now,
        );

        expect(entity.id, '123');
        expect(entity.title, 'Test Title');
        expect(entity.subtitle, 'Test Subtitle');
        expect(entity.createdAt, now);
      });

      test('entities with same values are equal', () {
        final now = DateTime.now();
        final entity1 = Page1ItemEntity(
          id: '123',
          title: 'Test',
          subtitle: 'Subtitle',
          createdAt: now,
        );
        final entity2 = Page1ItemEntity(
          id: '123',
          title: 'Test',
          subtitle: 'Subtitle',
          createdAt: now,
        );

        expect(entity1, equals(entity2));
      });

      test('copyWith creates new instance with updated fields', () {
        final now = DateTime.now();
        final entity = Page1ItemEntity(
          id: '123',
          title: 'Test',
          subtitle: 'Subtitle',
          createdAt: now,
        );

        final updated = entity.copyWith(title: 'Updated Title');

        expect(updated.id, entity.id);
        expect(updated.title, 'Updated Title');
        expect(updated.subtitle, entity.subtitle);
        expect(updated.createdAt, entity.createdAt);
      });
    });
  });
}
