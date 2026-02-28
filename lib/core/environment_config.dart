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

  /// Get environment variable value from compile-time constant.
  static const String _getEnv(String key, String defaultValue) {
    return String.fromEnvironment(key, defaultValue: defaultValue);
  }

  /// Get boolean environment variable.
  static const bool _getEnvBool(String key, {bool defaultValue = false}) {
    return bool.fromEnvironment(key, defaultValue: defaultValue);
  }

  /// Get integer environment variable.
  static const int _getEnvInt(String key, {int defaultValue = 0}) {
    return int.fromEnvironment(key, defaultValue: defaultValue);
  }

  // Commonly used configuration values with defaults

  /// Base URL for API requests.
  /// Override with: --dart-define=API_BASE_URL=https://api.example.com
  static const String apiBaseUrl = _getEnv('API_BASE_URL', 'https://api.example.com');

  /// API request timeout in milliseconds.
  /// Override with: --dart-define=API_TIMEOUT=30000
  static const int apiTimeout = _getEnvInt('API_TIMEOUT', defaultValue: 30000);

  /// Whether analytics is enabled.
  /// Override with: --dart-define=ENABLE_ANALYTICS=true
  static const bool enableAnalytics = _getEnvBool('ENABLE_ANALYTICS', defaultValue: false);

  /// Whether crash reporting is enabled.
  /// Override with: --dart-define=ENABLE_CRASH_REPORTING=true
  static const bool enableCrashReporting = _getEnvBool('ENABLE_CRASH_REPORTING', defaultValue: false);

  /// Current log level.
  /// Override with: --dart-define=LOG_LEVEL=debug
  static const String logLevel = _getEnv('LOG_LEVEL', 'info');

  /// Application name.
  /// Override with: --dart-define=APP_NAME=My App
  static const String appName = _getEnv('APP_NAME', 'Mobile App Skeleton');
}
