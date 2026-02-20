# Flutter Mobile Template - Best Practices Implementation

## Overview

This document outlines the modern Flutter and Dart best practices implemented in this template.

## Architecture Improvements

### 1. Error Handling with Result Pattern

We've implemented a functional error handling approach using the `fpdart` package:

```dart
import 'package:mobile_app_skeleton/core/result.dart';

// In your use case or repository
Result<User> fetchUser() async {
  try {
    final user = await api.getUser();
    return Results.success(user);
  } catch (e) {
    return Results.failure(ServerFailure());
  }
}

// Using the result
final result = await fetchUser();
result.fold(
  (failure) => showError(failure),
  (user) => displayUser(user),
);
```

**Benefits:**
- Type-safe error handling
- Forces explicit error handling at call sites
- Makes error paths visible in the code
- Eliminates throw-catch throughout the codebase

### 2. Improved Exception Hierarchy

All exceptions now include:
- Optional error messages
- Context information (status codes, retry timers)
- Proper `toString()` implementations for debugging

```dart
throw ServerException(
  message: 'Failed to fetch data',
  statusCode: 500,
);
```

### 3. Network Layer with Dio

A robust HTTP client wrapper with:
- Automatic request/response logging
- Timeout configuration from environment
- Comprehensive error handling
- Interceptor support for authentication, retry logic, etc.

```dart
final client = HttpClient();
final response = await client.get('/users');
```

### 4. Logging Framework

Centralized logging with the `logger` package:

```dart
AppLogger.d('Debug message');
AppLogger.i('Info message');
AppLogger.w('Warning message');
AppLogger.e('Error occurred', error: exception, stackTrace: stack);
```

**Features:**
- Configurable log levels
- Pretty printing for development
- Automatic method name and line number tracking
- Support for production log filtering

### 5. Environment Configuration

Support for multiple environments using `.env` files:

```dart
await EnvironmentConfig.load(); // Load .env
await EnvironmentConfig.load(flavor: 'dev'); // Load .env.dev
await EnvironmentConfig.load(flavor: 'prod'); // Load .env.prod

final apiUrl = EnvironmentConfig.apiBaseUrl;
final timeout = EnvironmentConfig.apiTimeout;
```

**Benefits:**
- Separate configuration for dev/staging/prod
- No hardcoded API URLs or keys
- Easy to add new configuration values
- Type-safe access to config values

### 6. Connectivity Monitoring

Real-time network connectivity checking:

```dart
final checker = ConnectivityChecker();

// Check current status
final isConnected = await checker.hasConnection;

// Monitor changes
checker.startMonitoring();
checker.onConnectivityChanged.listen((isConnected) {
  if (isConnected) {
    print('Back online');
  } else {
    print('Offline');
  }
});
```

### 7. Immutable Entities with Freezed

Entities now use `freezed` for:
- Immutability by default
- Value equality
- JSON serialization
- `copyWith` method for updates
- Union types for complex states

```dart
@freezed
class Page1ItemEntity with _$Page1ItemEntity {
  const factory Page1ItemEntity({
    required String id,
    required String title,
    required String subtitle,
    required DateTime createdAt,
  }) = _Page1ItemEntity;

  factory Page1ItemEntity.fromJson(Map<String, dynamic> json) =>
      _$Page1ItemEntityFromJson(json);
}

// Usage
final item = Page1ItemEntity(/*...*/);
final updated = item.copyWith(title: 'New Title');
```

## Code Generation

### Running Code Generation

After modifying entities with `@freezed` or `@JsonSerializable`:

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (rebuilds on changes)
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
dart run build_runner clean
```

## Testing Infrastructure

### Test Organization

Tests are organized by layer and feature:

```
test/
├── core_infrastructure_test.dart  # Core utilities
├── page1_feature_test.dart        # Feature-specific tests
├── widget_test.dart               # Widget tests
└── integration/                   # Integration tests (future)
```

### Test Types

#### 1. Unit Tests

```dart
test('returns items successfully', () async {
  final usecases = Page1Usecases(
    repository: Page1Repository(dataSource: Page1DataSource()),
  );

  final items = await usecases.getItems();
  expect(items, isNotEmpty);
});
```

#### 2. Widget Tests

```dart
testWidgets('button renders correctly', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: AppButton(label: 'Test', onTap: () {}),
    ),
  );

  expect(find.text('Test'), findsOneWidget);
});
```

#### 3. Tests with Mocks (using Mocktail)

```dart
class MockRepository extends Mock implements Page1Repository {}

test('handles error correctly', () async {
  final mockRepo = MockRepository();
  when(() => mockRepo.getItems()).thenThrow(ServerException());

  final usecases = Page1Usecases(repository: mockRepo);
  expect(() => usecases.getItems(), throwsA(isA<ServerException>()));
});
```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/page1_feature_test.dart

# Run tests in watch mode
flutter test --watch
```

## CI/CD Pipeline

The template includes a comprehensive GitHub Actions workflow:

### Stages

1. **Analyze & Lint**
   - Code formatting verification
   - Static analysis with `flutter analyze`
   - Runs on every push and PR

2. **Test**
   - Runs all unit and widget tests
   - Generates code coverage report
   - Uploads coverage to Codecov

3. **Build Android**
   - Builds release APK
   - Uploads build artifact

4. **Build iOS**
   - Builds iOS app (no codesign)
   - Creates IPA archive
   - Uploads build artifact

### Workflow Configuration

The workflow is defined in `.github/workflows/flutter_ci.yml` and runs on:
- Push to `main`, `develop`, or `skeleton` branches
- Pull requests targeting these branches

## Best Practices Summary

### ✅ DO

1. **Use Result type** for operations that can fail
2. **Use freezed** for all entity/model classes
3. **Add documentation** to public APIs
4. **Write tests** for new features
5. **Use const constructors** wherever possible
6. **Use named parameters** for functions with multiple parameters
7. **Keep functions small** (under 50 lines)
8. **Follow the layer architecture** (UI → UseCases → Repository → DataSource)
9. **Log important operations** using AppLogger
10. **Handle connectivity** for network operations

### ❌ DON'T

1. **Don't use print()** - use AppLogger instead
2. **Don't hardcode configuration** - use EnvironmentConfig
3. **Don't expose implementation details** - keep datasource logic private
4. **Don't skip error handling** - use Result type
5. **Don't create mutable entities** - use freezed
6. **Don't skip tests** for new features
7. **Don't use magic numbers** - define constants
8. **Don't ignore lint warnings** - fix them

## Migration Guide

### Converting Existing Entities to Freezed

Before:
```dart
class MyEntity {
  final String id;
  final String name;

  const MyEntity({required this.id, required this.name});
}
```

After:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_entity.freezed.dart';
part 'my_entity.g.dart';

@freezed
class MyEntity with _$MyEntity {
  const factory MyEntity({
    required String id,
    required String name,
  }) = _MyEntity;

  factory MyEntity.fromJson(Map<String, dynamic> json) =>
      _$MyEntityFromJson(json);
}
```

Then run: `dart run build_runner build --delete-conflicting-outputs`

### Adding Network Calls to DataSources

```dart
class Page1DataSource {
  final HttpClient _client;

  Page1DataSource({HttpClient? client})
      : _client = client ?? HttpClient();

  Future<List<Page1ItemEntity>> fetchItems() async {
    try {
      final response = await _client.get('/items');
      final List<dynamic> data = response.data;
      return data.map((json) => Page1ItemEntity.fromJson(json)).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw UnexpectedException(originalError: e);
    }
  }
}
```

### Using Result Type in Repositories

```dart
class Page1Repository {
  final Page1DataSource _dataSource;

  Page1Repository({required Page1DataSource dataSource})
      : _dataSource = dataSource;

  Future<Result<List<Page1ItemEntity>>> getItems() async {
    return Results.tryCatchAsync(
      () => _dataSource.fetchItems(),
      onError: (error, stack) {
        if (error is ServerException) {
          return ServerFailure();
        }
        return GeneralFailure();
      },
    );
  }
}
```

## Additional Resources

- [Flutter Best Practices](https://docs.flutter.dev/development/best-practices)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [freezed Package](https://pub.dev/packages/freezed)
- [fpdart Package](https://pub.dev/packages/fpdart)
- [Dio Package](https://pub.dev/packages/dio)
- [Logger Package](https://pub.dev/packages/logger)
