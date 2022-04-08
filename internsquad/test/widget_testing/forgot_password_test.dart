import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/providers/blog_provider.dart';
import 'package:internsquad/providers/internshipProvider.dart';
import 'package:internsquad/screens/forgotpassword.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Forgot Password Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        ChangeNotifierProvider(create: (context) => InternshipProvider())
      ],
      child: MaterialApp(home: ForgotPasswordScreen()),
    ));

    // Finders
    final oldPasswordFinder = find.byKey(Key('oldPassword'));
    final newPasswordFinder = find.byKey(Key('newPassword'));

    // Matcher
    expect(oldPasswordFinder, findsOneWidget);
    expect(newPasswordFinder, findsOneWidget);
  });
}
