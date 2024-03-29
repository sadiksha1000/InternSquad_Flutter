import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/providers/blog_provider.dart';
import 'package:internsquad/providers/internshipProvider.dart';
import 'package:internsquad/widgets/appbar.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('MyAppBar widget has a title', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        ChangeNotifierProvider(create: (context) => InternshipProvider())
      ],
      child: MaterialApp(home: MyAppBar(title: 'InternSquad')),
    ));

    // Finders
    final titleFinder = find.text('InternSquad');

    // Matcher
    expect(titleFinder, findsOneWidget);
  });
}
