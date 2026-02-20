import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mobile_app_skeleton/core/connectivity_checker.dart';
import 'package:mobile_app_skeleton/core/http_client.dart';
import 'package:mobile_app_skeleton/core/logger.dart';

/// Mock classes for testing.
class MockHttpClient extends Mock implements HttpClient {}

void main() {
  group('Core Infrastructure Tests', () {
    group('AppLogger', () {
      test('logger instance is singleton', () {
        final instance1 = AppLogger.instance;
        final instance2 = AppLogger.instance;

        expect(instance1, equals(instance2));
      });

      test('logger supports different log levels', () {
        expect(() => AppLogger.d('Debug message'), returnsNormally);
        expect(() => AppLogger.i('Info message'), returnsNormally);
        expect(() => AppLogger.w('Warning message'), returnsNormally);
        expect(
          () => AppLogger.e('Error message', error: Exception('test')),
          returnsNormally,
        );
      });
    });

    group('ConnectivityChecker', () {
      late ConnectivityChecker checker;

      setUp(() {
        checker = ConnectivityChecker();
      });

      tearDown(() {
        checker.dispose();
      });

      test('can check connection status', () async {
        final hasConnection = await checker.hasConnection;
        expect(hasConnection, isA<bool>());
      });

      test('connectivity stream emits bool values', () async {
        checker.startMonitoring();

        expectLater(
          checker.onConnectivityChanged,
          emitsInAnyOrder([isA<bool>()]),
        );

        // Allow some time for the stream to emit
        await Future.delayed(const Duration(milliseconds: 100));
        checker.stopMonitoring();
      });

      test('can start and stop monitoring', () {
        expect(() => checker.startMonitoring(), returnsNormally);
        expect(() => checker.stopMonitoring(), returnsNormally);
      });
    });
  });
}
