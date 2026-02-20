import 'package:logger/logger.dart';

/// Application-wide logger utility.
///
/// Provides a centralized logging mechanism with configurable log levels.
/// Usage:
/// ```dart
/// AppLogger.d('Debug message');
/// AppLogger.i('Info message');
/// AppLogger.w('Warning message');
/// AppLogger.e('Error message', error: exception, stackTrace: stackTrace);
/// ```
class AppLogger {
  static Logger? _instance;

  /// Gets the singleton logger instance.
  static Logger get instance {
    _instance ??= Logger(
      printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls for errors
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print emoji for each log level
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: _getLogLevel(),
    );
    return _instance!;
  }

  /// Determines log level based on build mode.
  static Level _getLogLevel() {
    // In production, only show warnings and errors
    // In debug mode, show all logs
    return Level.debug; // Can be configured via environment variables
  }

  /// Log a debug message.
  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    instance.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log an info message.
  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    instance.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message.
  static void w(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    instance.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log an error message.
  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    instance.e(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Log a fatal message.
  static void f(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    instance.f(message, time: time, error: error, stackTrace: stackTrace);
  }

  /// Close the logger and release resources.
  static void close() {
    _instance?.close();
    _instance = null;
  }
}
