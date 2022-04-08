import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquad/providers/blog_provider.dart';
import 'package:internsquad/providers/internshipProvider.dart';
import 'package:internsquad/screens/feedback.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Feedback Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        ChangeNotifierProvider(create: (context) => InternshipProvider())
      ],
      child: MaterialApp(home: FeedbackScreen()),
    ));

    // Finders
    final titleFinder = find.text('Feedbacks');
    final feedbackFinder = find.byKey(Key('feedback'));

    // Matcher
    expect(titleFinder, findsOneWidget);
    expect(feedbackFinder, findsOneWidget);
  });
}
