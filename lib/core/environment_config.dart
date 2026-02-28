/// Environment configuration manager.
///
/// Provides access to environment-specific configuration values using
/// compile-time constants via --dart-define flags or hardcoded defaults.
///
/// Usage:
/// ```dart
/// final apiUrl = EnvironmentConfig.apiBaseUrl;
/// final timeout = EnvironmentConfig.apiTimeout;
/// ```
///
/// To override values at build time, use --dart-define:
/// ```bash
/// flutter run --dart-define=API_BASE_URL=https://api.prod.com
/// flutter build apk --dart-define=API_BASE_URL=https://api.prod.com --dart-define=LOG_LEVEL=error
/// ```
class EnvironmentConfig {
  // Private constructor to prevent instantiation
  EnvironmentConfig._();

  // Commonly used configuration values with defaults

  /// Base URL for API requests.
  /// Override with: --dart-define=API_BASE_URL=https://api.example.com
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  );

  /// API request timeout in milliseconds.
  /// Override with: --dart-define=API_TIMEOUT=30000
  static const int apiTimeout = int.fromEnvironment(
    'API_TIMEOUT',
    defaultValue: 30000,
  );

  /// Whether analytics is enabled.
  /// Override with: --dart-define=ENABLE_ANALYTICS=true
  static const bool enableAnalytics = bool.fromEnvironment('ENABLE_ANALYTICS');

  /// Whether crash reporting is enabled.
  /// Override with: --dart-define=ENABLE_CRASH_REPORTING=true
  static const bool enableCrashReporting = bool.fromEnvironment(
    'ENABLE_CRASH_REPORTING',
  );

  /// Current log level.
  /// Override with: --dart-define=LOG_LEVEL=debug
  static const String logLevel = String.fromEnvironment(
    'LOG_LEVEL',
    defaultValue: 'info',
  );

  /// Application name.
  /// Override with: --dart-define=APP_NAME=My App
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Mobile App Skeleton',
  );
}
