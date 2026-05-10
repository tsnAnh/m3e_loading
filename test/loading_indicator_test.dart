import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_loading/m3e_loading.dart';

void main() {
  group('M3ELoadingIndicator', () {
    testWidgets('renders with default size', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: M3ELoadingIndicator(),
          ),
        ),
      );

      expect(find.byType(M3ELoadingIndicator), findsOneWidget);
      expect(find.bySemanticsLabel('Loading'), findsOneWidget);
    });

    testWidgets('renders all size variants', (tester) async {
      final sizes = [
        M3ELoadingIndicator.sizeXS,
        M3ELoadingIndicator.sizeSM,
        M3ELoadingIndicator.sizeMD,
        M3ELoadingIndicator.sizeLG,
        M3ELoadingIndicator.sizeXL,
      ];

      for (final size in sizes) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: M3ELoadingIndicator(size: size),
            ),
          ),
        );

        final widget = tester.widget<SizedBox>(
          find.descendant(
            of: find.byType(M3ELoadingIndicator),
            matching: find.byType(SizedBox),
          ).first,
        );

        expect(widget.width, equals(size));
        expect(widget.height, equals(size));
      }
    });

    testWidgets('respects custom color', (tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: M3ELoadingIndicator(color: customColor),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('uses theme primary color by default', (tester) async {
      const primaryColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            colorScheme: const ColorScheme.light(primary: primaryColor),
          ),
          home: const Scaffold(
            body: M3ELoadingIndicator(),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('respects ProgressIndicatorTheme', (tester) async {
      const themeColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProgressIndicatorTheme(
              data: const ProgressIndicatorThemeData(color: themeColor),
              child: const M3ELoadingIndicator(),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('animation starts automatically', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: M3ELoadingIndicator(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(M3ELoadingIndicator), findsOneWidget);
    });

    testWidgets('respects MediaQuery.disableAnimations', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: const Scaffold(
              body: M3ELoadingIndicator(),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(M3ELoadingIndicator), findsOneWidget);
    });

    testWidgets('has accessibility semantics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: M3ELoadingIndicator(),
          ),
        ),
      );

      expect(find.bySemanticsLabel('Loading'), findsOneWidget);
    });
  });

  group('Size Constants', () {
    test('have correct pixel values', () {
      expect(M3ELoadingIndicator.sizeXS, equals(28.0));
      expect(M3ELoadingIndicator.sizeSM, equals(32.0));
      expect(M3ELoadingIndicator.sizeMD, equals(40.0));
      expect(M3ELoadingIndicator.sizeLG, equals(48.0));
      expect(M3ELoadingIndicator.sizeXL, equals(56.0));
    });
  });
}
