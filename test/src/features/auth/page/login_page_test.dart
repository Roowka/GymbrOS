import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymbros/src/features/auth/page/login_page.dart';
import 'package:gymbros/src/features/auth/service/auth_service.dart';
import 'package:gymbros/src/features/providers/user_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([AuthService, UserProvider])
void main() {
  late MockAuthService mockAuthService;
  late MockUserProvider mockUserProvider;

  setUp(() {
    mockAuthService = MockAuthService();
    mockUserProvider = MockUserProvider();
  });

  Widget createTestWidget(Widget child) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          Provider<AuthService>.value(value: mockAuthService),
          ChangeNotifierProvider<UserProvider>.value(value: mockUserProvider),
        ],
        child: child,
      ),
    );
  }

  group('LoginPage Tests', () {
    testWidgets('renders login page elements', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(LoginPage()));

      // Check for email field
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Enter email address'), findsOneWidget);

      // Check for password field
      expect(find.text('Enter password'), findsOneWidget);

      // Check for login button
      expect(find.text('Login'), findsOneWidget);

      // Check for signup link
      expect(
          find.text('Don\'t have an account? Create Account'), findsOneWidget);
    });

    testWidgets('shows error when login fails', (WidgetTester tester) async {
      // Mock a failed login
      when(mockAuthService.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => 'Invalid credentials');

      await tester.pumpWidget(createTestWidget(LoginPage()));

      // Enter email and password
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify snackbar with error message
      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('navigates to home page on successful login',
        (WidgetTester tester) async {
      // Mock a successful login
      when(mockAuthService.login(
              email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => 'Login successful!');
      when(mockUserProvider.loadUser('test@example.com'))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createTestWidget(LoginPage()));

      // Enter email and password
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'correctpassword');

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Verify navigation to home page
      expect(find.text('GymbrOS App'),
          findsNothing); // Assuming "GymbrOS App" is the home title
    });

    testWidgets('navigates to signup page on link tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget(LoginPage()));

      // Tap the signup link
      await tester.tap(find.text('Don\'t have an account? Create Account'));
      await tester.pumpAndSettle();

      // Verify navigation to signup page
      expect(find.text('Sign Up'),
          findsOneWidget); // Assuming "Sign Up" is on signup page
    });
  });
}
