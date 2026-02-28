import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mobile_app_skeleton/core/connectivity_checker.dart';
import 'package:mobile_app_skeleton/core/http_client.dart';
import 'package:mobile_app_skeleton/core/logger.dart';

/// Mock classes for testing.
class MockHttpClient extends Mock implements HttpClient {}

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
      late MockConnectivity mockConnectivity;
      late StreamController<List<ConnectivityResult>> connectivityController;

      setUp(() {
        mockConnectivity = MockConnectivity();
        connectivityController =
            StreamController<List<ConnectivityResult>>.broadcast();

        when(() => mockConnectivity.checkConnectivity()).thenAnswer(
          (_) async => [ConnectivityResult.wifi],
        );
        when(() => mockConnectivity.onConnectivityChanged)
            .thenAnswer((_) => connectivityController.stream);

        checker = ConnectivityChecker(connectivity: mockConnectivity);
      });

      tearDown(() async {
        checker.dispose();
        await connectivityController.close();
      });

      test('can check connection status', () async {
        final hasConnection = await checker.hasConnection;
        expect(hasConnection, isA<bool>());
        expect(hasConnection, isTrue);
      });

      test('connectivity stream emits bool values', () async {
        checker.startMonitoring();

        final event = checker.onConnectivityChanged.first;
        connectivityController.add([ConnectivityResult.mobile]);
        expect(await event, isTrue);
        checker.stopMonitoring();
      });

      test('can start and stop monitoring', () {
        expect(() => checker.startMonitoring(), returnsNormally);
        expect(() => checker.stopMonitoring(), returnsNormally);
      });
    });
  });
}
