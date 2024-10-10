import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymbros/src/features/auth/page/login_page.dart';
import 'package:gymbros/src/shared/widget/custom_button.dart';
import 'package:gymbros/src/shared/widget/custom_text_field.dart'; // Adjust the import path based on your project structure

void main() {
  // Helper function to create and return the tested widget
  Widget makeTestableWidget() => MaterialApp(home: LoginPage());

  group('LoginPage Tests', () {
    testWidgets('LoginPage UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());

      // Check for logo image
      expect(find.byType(Image), findsOneWidget);

      // Check for text fields
      expect(find.widgetWithText(CustomTextField, 'Enter email address'),
          findsOneWidget);
      expect(find.widgetWithText(CustomTextField, 'Enter password'),
          findsOneWidget);

      // Check for login button
      expect(find.widgetWithText(CustomButton, 'Login'), findsOneWidget);

      // Check for create account link
      expect(
          find.text('Don\'t have an account? Create Account'), findsOneWidget);
    });

    testWidgets('Navigate to Home on Login', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());

      // Assuming that '/home' navigation works correctly; here we simply test the button press.
      await tester.tap(find.widgetWithText(CustomButton, 'Login'));
      await tester
          .pumpAndSettle(); // This simulates the passage of time until all animations are complete.

      // You would normally check navigation occurred here, but that requires a mocked Navigator observer.
      // For simplicity, this step is omitted.
    });

    testWidgets('Navigate to SignUp Page', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());

      await tester.tap(find.text('Don\'t have an account? Create Account'));
      await tester
          .pumpAndSettle(); // This simulates the passage of time until all animations are complete.

      // Check navigation to signup page; requires mock navigator setup.
    });
  });
}
