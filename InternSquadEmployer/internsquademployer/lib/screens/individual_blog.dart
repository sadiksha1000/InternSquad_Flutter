import 'package:flutter/material.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:intl/intl.dart';

class BlogDetailsScreen extends StatelessWidget {
  static const routeName = '/individual-blog';
  const BlogDetailsScreen({Key? key}) : super(key: key);

  String formatDate(DateTime date) => new DateFormat("MMMM d").format(date);

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  String dateConvertor(DateTime uploadDate) {
    return DateFormat('yyyy-MM-dd').format(uploadDate);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> blog =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String uploadDate = blog['uploadDate']!.split('T')[0];

    return Scaffold(
        appBar: MyAppBar(
          title: '',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog['title'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(uploadDate),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    Bidi.stripHtmlIfNeeded(blog['description']),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
