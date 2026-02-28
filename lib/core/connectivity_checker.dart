import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:mobile_app_skeleton/core/logger.dart';

/// Network connectivity checker service.
///
/// Monitors network connectivity status and provides methods to check
/// whether the device has an active internet connection.
///
/// Usage:
/// ```dart
/// final checker = ConnectivityChecker();
/// final isConnected = await checker.hasConnection;
///
/// // Listen to connectivity changes
/// checker.onConnectivityChanged.listen((isConnected) {
///   if (isConnected) {
///     print('Connected to internet');
///   } else {
///     print('No internet connection');
///   }
/// });
/// ```
class ConnectivityChecker {
  ConnectivityChecker({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  final StreamController<bool> _connectivityController =
      StreamController<bool>.broadcast();

  /// Stream of connectivity status changes.
  ///
  /// Emits `true` when connected, `false` when disconnected.
  Stream<bool> get onConnectivityChanged => _connectivityController.stream;

  /// Check if the device currently has an internet connection.
  Future<bool> get hasConnection async {
    final results = await _connectivity.checkConnectivity();
    return _hasActiveConnection(results);
  }

  /// Start monitoring connectivity changes.
  ///
  /// Call this method to begin listening to network status changes.
  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      (results) {
        final isConnected = _hasActiveConnection(results);
        AppLogger.d('Connectivity changed: $isConnected (results: $results)');
        _connectivityController.add(isConnected);
      },
      onError: (error) {
        AppLogger.e('Connectivity monitoring error', error: error);
        _connectivityController.add(false);
      },
    );
  }

  /// Stop monitoring connectivity changes.
  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// Dispose of resources.
  void dispose() {
    stopMonitoring();
    _connectivityController.close();
  }

  /// Check if any of the connectivity results indicate an active connection.
  bool _hasActiveConnection(List<ConnectivityResult> results) {
    if (results.isEmpty) return false;

    // Check if any result indicates connectivity
    // (excludes none, bluetooth)
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn,
    );
  }
}
