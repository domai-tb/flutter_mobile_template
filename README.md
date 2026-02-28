# Flutter Mobile App Skeleton

A production-ready Flutter mobile app template with clean architecture, modern best practices, and comprehensive tooling.

## Features

### Architecture & Design
- **Clean Architecture**: Clear separation of concerns with datasources, repositories, use cases, and UI layers
- **Feature-based Structure**: Six placeholder feature modules ready for customization
- **Dependency Injection**: GetIt service locator for centralized dependency management
- **Responsive Design**: Adaptive layouts for phones and tablets with bottom/side navigation

### Modern Best Practices
- **Functional Error Handling**: Result type pattern using `fpdart` for type-safe error handling
- **Immutable Entities**: Freezed-based entities with value equality and JSON serialization
- **Network Layer**: Dio-based HTTP client with automatic error handling and logging
- **Environment Configuration**: Support for multiple environments (.env files)
- **Connectivity Monitoring**: Real-time network status tracking
- **Centralized Logging**: Logger package with configurable log levels

### Developer Experience
- **Code Generation**: Freezed and JSON serialization setup with build_runner
- **Comprehensive Testing**: Unit tests, widget tests, and mocking infrastructure
- **CI/CD Pipeline**: GitHub Actions workflow for analyze, test, and build
- **Strict Linting**: 180+ lint rules enforcing code quality and consistency
- **Localization**: Built-in i18n support with English and German

## Structure

```
lib/
├── core/
│   ├── app_scope.dart              # InheritedWidget for dependency access
│   ├── app_services.dart           # Aggregated use cases
│   ├── injection.dart              # GetIt DI configuration
│   ├── settings.dart               # App settings with persistence
│   ├── themes.dart                 # Material 3 light/dark themes
│   ├── exceptions.dart             # Domain exceptions
│   ├── failures.dart               # Failure types for Result pattern
│   ├── result.dart                 # Result type for error handling
│   ├── logger.dart                 # Centralized logging utility
│   ├── environment_config.dart     # Environment configuration loader
│   ├── http_client.dart            # HTTP client wrapper with Dio
│   └── connectivity_checker.dart   # Network connectivity monitor
├── pages/
│   ├── home/                       # Main navigation shell
│   └── page1-6/                    # Six feature module placeholders
│       ├── pageN_datasource.dart   # Data access layer
│       ├── pageN_repository.dart   # Repository layer
│       ├── pageN_usecases.dart     # Business logic layer
│       ├── pageN_entity.dart       # Immutable data models
│       └── pageN_page.dart         # UI layer
├── widgets/                        # Reusable UI components
├── utils/                          # Utility functions and constants
└── l10n/                           # Generated localization files

test/
├── core_infrastructure_test.dart   # Core utilities tests
├── page1_feature_test.dart        # Feature layer tests
└── widget_test.dart               # UI component tests

docs/
├── BEST_PRACTICES.md              # Comprehensive best practices guide
└── wiki/                          # Detailed architecture documentation
```

## Getting Started

### Prerequisites

- Flutter SDK >=3.6.0
- Dart SDK >=3.6.0

### Setup

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd flutter_mobile_template
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

   **Optional**: Override configuration values for different environments:
   ```bash
   flutter run --dart-define=API_BASE_URL=https://dev-api.example.com --dart-define=LOG_LEVEL=debug
   ```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/page1_feature_test.dart
```

### Code Generation

After modifying entities or adding `@freezed` annotations:

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on changes)
dart run build_runner watch --delete-conflicting-outputs
```

## Customizing Features

### Replace Placeholder Pages

1. **Choose a page folder** (e.g., `lib/pages/page1`)
2. **Update the entity** with your data model:
   ```dart
   @freezed
   class MyFeatureEntity with _$MyFeatureEntity {
     const factory MyFeatureEntity({
       required String id,
       required String name,
       // Add your fields
     }) = _MyFeatureEntity;

     factory MyFeatureEntity.fromJson(Map<String, dynamic> json) =>
         _$MyFeatureEntityFromJson(json);
   }
   ```

3. **Implement the datasource** with real API calls:
   ```dart
   class MyFeatureDataSource {
     final HttpClient _client;

     MyFeatureDataSource({HttpClient? client})
         : _client = client ?? HttpClient();

     Future<List<MyFeatureEntity>> fetchItems() async {
       final response = await _client.get('/api/items');
       return (response.data as List)
           .map((json) => MyFeatureEntity.fromJson(json))
           .toList();
     }
   }
   ```

4. **Update the repository** to use Result type:
   ```dart
   Future<Result<List<MyFeatureEntity>>> getItems() async {
     return Results.tryCatchAsync(
       () => _dataSource.fetchItems(),
       onError: (error, _) => error is ServerException
           ? ServerFailure()
           : GeneralFailure(),
     );
   }
   ```

5. **Run code generation** and test your changes

## Environment Configuration

The template supports multiple environments using compile-time constants via `--dart-define` flags:

**Available Configuration Values:**
- `API_BASE_URL` - Base URL for API requests (default: `https://api.example.com`)
- `API_TIMEOUT` - API timeout in milliseconds (default: `30000`)
- `ENABLE_ANALYTICS` - Enable analytics (default: `false`)
- `ENABLE_CRASH_REPORTING` - Enable crash reporting (default: `false`)
- `LOG_LEVEL` - Log level (default: `info`)
- `APP_NAME` - Application name (default: `Mobile App Skeleton`)

**Usage Examples:**

Development build:
```bash
flutter run --dart-define=API_BASE_URL=https://dev-api.example.com --dart-define=LOG_LEVEL=debug
```

Production build:
```bash
flutter build apk --dart-define=API_BASE_URL=https://api.prod.com --dart-define=LOG_LEVEL=error --dart-define=ENABLE_ANALYTICS=true
```

Access in code:
```dart
final apiUrl = EnvironmentConfig.apiBaseUrl;
final timeout = EnvironmentConfig.apiTimeout;
```

**Benefits:**
- No .env files bundled in the app (smaller app size)
- Compile-time constants for better performance
- No runtime file loading overhead
- Separate configuration per build without changing code

## Best Practices

See [docs/BEST_PRACTICES.md](docs/BEST_PRACTICES.md) for comprehensive guidelines on:
- Error handling with Result pattern
- Entity design with Freezed
- Network layer usage
- Testing strategies
- Code generation
- CI/CD pipeline

## CI/CD

The template includes a GitHub Actions workflow that:
1. ✅ Verifies code formatting
2. ✅ Runs static analysis
3. ✅ Executes all tests with coverage
4. ✅ Builds Android APK
5. ✅ Builds iOS IPA

Workflow runs on pushes and PRs to `main`, `develop`, and `skeleton` branches.

## Key Dependencies

| Package | Purpose |
|---------|---------|
| `get_it` | Dependency injection |
| `fpdart` | Functional programming & Result type |
| `freezed` | Immutable classes & code generation |
| `dio` | HTTP client |
| `logger` | Logging framework |
| `connectivity_plus` | Network connectivity monitoring |
| `mocktail` | Testing mocks |
| `shared_preferences` | Local storage |

## Documentation

- **[Best Practices Guide](docs/BEST_PRACTICES.md)** - Comprehensive implementation guide
- **[Architecture](docs/wiki/Architecture.md)** - Detailed architecture documentation
- **[Getting Started](docs/wiki/Getting_Started.md)** - Development setup guide
- **[Pages](docs/wiki/Pages.md)** - Feature module documentation

## Contributing

1. Follow the existing code style
2. Write tests for new features
3. Update documentation
4. Run linting and tests before committing
5. Keep changes focused and minimal

## License

See [LICENSE](LICENSE) file for details.
