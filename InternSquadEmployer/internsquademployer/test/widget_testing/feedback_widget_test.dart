import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internsquademployer/provider/blog_provider.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/screens/feedback.dart';
import 'package:internsquademployer/screens/settings.dart';
import 'package:internsquademployer/widgets/appbar.dart';
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
