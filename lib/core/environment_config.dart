import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration manager.
///
/// Loads and provides access to environment-specific configuration values.
/// Values are loaded from .env files based on the current environment.
///
/// Usage:
/// ```dart
/// await EnvironmentConfig.load();
/// final apiUrl = EnvironmentConfig.apiBaseUrl;
/// ```
class EnvironmentConfig {
  static bool _isLoaded = false;

  /// Load environment configuration from .env file.
  ///
  /// Attempts to load environment-specific .env file based on the flavor.
  /// Falls back to default .env file if specific one doesn't exist.
  static Future<void> load({String? flavor}) async {
    if (_isLoaded) return;

    try {
      // Try to load flavor-specific .env file first
      if (flavor != null) {
        await dotenv.load(fileName: '.env.$flavor');
      } else {
        await dotenv.load(fileName: '.env');
      }
      _isLoaded = true;
    } catch (e) {
      // If specific file doesn't exist, try default
      try {
        await dotenv.load(fileName: '.env');
        _isLoaded = true;
      } catch (e) {
        // No .env file found - use default values
        _isLoaded = true;
      }
    }
  }

  /// Get environment variable value.
  static String get(String key, {String defaultValue = ''}) {
    return dotenv.get(key, fallback: defaultValue);
  }

  /// Get environment variable value or null if not found.
  static String? maybeGet(String key) {
    return dotenv.maybeGet(key);
  }

  // Commonly used configuration values with defaults

  /// Base URL for API requests.
  static String get apiBaseUrl =>
      get('API_BASE_URL', defaultValue: 'https://api.example.com');

  /// API request timeout in milliseconds.
  static int get apiTimeout =>
      int.tryParse(get('API_TIMEOUT', defaultValue: '30000')) ?? 30000;

  /// Whether analytics is enabled.
  static bool get enableAnalytics =>
      get('ENABLE_ANALYTICS', defaultValue: 'false').toLowerCase() == 'true';

  /// Whether crash reporting is enabled.
  static bool get enableCrashReporting =>
      get('ENABLE_CRASH_REPORTING', defaultValue: 'false').toLowerCase() ==
      'true';

  /// Current log level.
  static String get logLevel => get('LOG_LEVEL', defaultValue: 'info');

  /// Application name.
  static String get appName =>
      get('APP_NAME', defaultValue: 'Mobile App Skeleton');

  /// Reset the loaded state (useful for testing).
  static void reset() {
    _isLoaded = false;
  }
}
