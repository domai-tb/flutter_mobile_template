import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app_skeleton/widgets/app_button.dart';
import 'package:mobile_app_skeleton/widgets/app_icon_button.dart';

/// Widget tests for shared UI components.
void main() {
  group('Widget Tests', () {
    group('AppButton', () {
      testWidgets('renders button with text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Test Button',
                onTap: () {},
              ),
            ),
          ),
        );

        expect(find.text('Test Button'), findsOneWidget);
      });

      testWidgets('calls onTap when pressed', (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                text: 'Test Button',
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AppButton));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      });

      testWidgets('renders light variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.light(
                text: 'Light Button',
                onTap: _noop,
              ),
            ),
          ),
        );

        expect(find.text('Light Button'), findsOneWidget);
      });
    });

    group('AppIconButton', () {
      testWidgets('renders icon button', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconButton(
                icon: Icons.search,
                onTap: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('calls onTap when pressed', (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppIconButton(
                icon: Icons.search,
                onTap: () => tapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AppIconButton));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      });
    });
  });
}

void _noop() {}
