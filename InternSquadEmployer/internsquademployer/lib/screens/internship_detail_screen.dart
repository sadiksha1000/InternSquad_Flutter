import 'package:flutter/material.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class InternshipDetailScreen extends StatefulWidget {
  static const routeName = '/internship-detail';
  const InternshipDetailScreen({Key? key}) : super(key: key);

  @override
  _InternshipDetailScreenState createState() => _InternshipDetailScreenState();
}

class _InternshipDetailScreenState extends State<InternshipDetailScreen> {
  bool checkWorkEnvironment(workEnvironment) {
    if (workEnvironment == 'Work from Home') {
      return true;
    } else {
      return false;
    }
  }

  String dateConvertor(DateTime deadline) {
    return DateFormat('yyyy-MM-dd').format(deadline);
  }

  List<Chip> chipBuilder(List<String> skills) {
    return skills
        .map(
          (skill) => Chip(
            label: FittedBox(
              child: Text(
                skill,
                style: TextStyle(
                  // backgroundColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> internship =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;

    String date = internship['deadline']!.split('T')[0];
    String image = internship['image']!.split("\\")[1];

    // String detail = Bidi.stripHtmlIfNeeded(internship['internshipDetails']);

    HtmlWidget detail = HtmlWidget(
      internship['internshipDetails'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    HtmlWidget skills = HtmlWidget(
      internship['skills'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    HtmlWidget credentials = HtmlWidget(
      internship['whoCanApply'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    HtmlWidget perks = HtmlWidget(
      internship['perks'],
      textStyle: TextStyle(
        color: Colors.black87,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    return Scaffold(
      appBar: MyAppBar(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(23.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          internship['title'] as String,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "Roboto-Regular"),
                        ),
                        SizedBox(height: height * 0.007),
                        Text(
                          internship['companyName'] as String,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            // 'http://10.0.2.2:90/employerDocuments/${image}',
                            'http://192.168.1.73:90/employerDocuments/${image}',
                            scale: 100)
                        // child: Image.network(
                        //   internship['image'] as String,
                        //   fit: BoxFit.fill,
                        // ),
                        ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                Row(
                  children: [
                    checkWorkEnvironment(internship['workEnvironment'])
                        ? const Icon(
                            Icons.home,
                            size: 25,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.business_center,
                            size: 25,
                            color: Colors.grey,
                          ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        internship['workEnvironment'] as String,
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                Row(
                  children: [
                    const Icon(
                      Icons.money,
                      size: 25,
                      color: Colors.grey,
                    ),
                    SizedBox(width: width * 0.014),
                    Text(
                      'Rs.${internship['stipend']} /month',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                    SizedBox(width: width * 0.014),
                    Text(
                      '${internship['duration']} months',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.hourglass_bottom_rounded,
                      size: 25,
                      color: Colors.grey,
                    ),
                    SizedBox(width: width * 0.013),
                    Text(
                      'Apply by ${date}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.020),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.05,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: height * 0.25,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    // padding: EdgeInsets.fromLTRB(15, 15, 25, 15),
                    child: Scrollbar(
                      isAlwaysShown: true,
                      thickness: 3.5,
                      showTrackOnHover: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About ${internship['companyName'] as String}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: height * 0.008),
                            Text(
                              internship['companyProfile'] as String,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                                wordSpacing: 0.25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.020),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        ' Internship Detail',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      detail,
                      // Text(
                      //   detail,
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 17,
                      //     fontWeight: FontWeight.normal,
                      //     wordSpacing: 0.25,
                      //   ),
                      //   textAlign: TextAlign.justify,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        ' Skills Required',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      skills,
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Credentials to apply for the post',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.010),
                      credentials,
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Perks',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      perks,
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Number of Openings',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Text('${internship['numberOfOpenings']}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'APPLY',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 10,
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
