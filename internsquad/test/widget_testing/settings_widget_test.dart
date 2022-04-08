import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/providers/blog_provider.dart';
import 'package:internsquad/providers/internshipProvider.dart';
import 'package:internsquad/screens/settings.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Settings Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        ChangeNotifierProvider(create: (context) => InternshipProvider())
      ],
      child: MaterialApp(home: SettingsScreen()),
    ));

    // Finders
    final titleFinder = find.text('Settings');

    // Matcher
    expect(titleFinder, findsOneWidget);
  });
}
