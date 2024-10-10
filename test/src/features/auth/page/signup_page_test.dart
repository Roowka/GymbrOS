import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymbros/src/features/auth/page/signup_page.dart';
import 'package:gymbros/src/shared/widget/custom_button.dart';
import 'package:gymbros/src/shared/widget/custom_text_field.dart'; // Adjust the import path based on your project structure

void main() {
  // Helper function to create and return the tested widget
  Widget makeTestableWidget() => MaterialApp(home: SignUpPage());

  group('SignUpPage Tests', () {
    testWidgets('SignUpPage UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(makeTestableWidget());

      // Check for text fields
      expect(find.widgetWithText(CustomTextField, 'Enter full name'),
          findsOneWidget);
      expect(find.widgetWithText(CustomTextField, 'Enter email address'),
          findsOneWidget);
      expect(
          find.widgetWithText(CustomTextField, 'New password'), findsOneWidget);
      expect(find.widgetWithText(CustomTextField, 'Confirm password'),
          findsOneWidget);

      // Check for the continue button
      expect(find.widgetWithText(CustomButton, 'Continue'), findsOneWidget);
    });
  });
}
