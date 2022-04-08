import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class InternshipDetail extends StatefulWidget {
  static const routeName = '/internshipdetailscreen';
  const InternshipDetail({Key? key}) : super(key: key);

  @override
  _InternshipDetailState createState() => _InternshipDetailState();
}

class _InternshipDetailState extends State<InternshipDetail> {
  bool isBookmarked = false;
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

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;

    final internshipId = ModalRoute.of(context)!.settings.arguments as String;
    // print("ID${internshipId}");
    final internship = Provider.of<InternshipProvider>(context, listen: false)
        .findById(internshipId);
    // print("InternshipDetail${internship}");

    String date = internship.deadline!.split('T')[0];
    String image = internship.eid!.image!.split("\\")[1];

    // String detail = Bidi.stripHtmlIfNeeded(internship['internshipDetails']);

    HtmlWidget detail = HtmlWidget(
      internship.internshipDetails as String,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    HtmlWidget skills = HtmlWidget(
      internship.skills as String,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    HtmlWidget credentials = HtmlWidget(
      internship.whoCanApply as String,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.normal,
        wordSpacing: 0.25,
      ),
    );

    HtmlWidget perks = HtmlWidget(
      internship.perks as String,
      textStyle: TextStyle(
        color: Colors.black,
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
                          internship.title as String,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "Roboto-Regular"),
                        ),
                        SizedBox(height: height * 0.007),
                        Text(
                          internship.eid!.companyName as String,
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
                        scale: 70,
                      ),
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
                    checkWorkEnvironment(internship.workEnvironment)
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
                        internship.workEnvironment as String,
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
                      'Rs.${internship.stipend} /month',
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
                      '${internship.duration} months',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.007),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                    // InkWell(
                    //   onTap: () async {
                    //     setState(() {
                    //       isBookmarked = !isBookmarked;
                    //     });

                    //     final bookmarkProvider = Provider.of<BookMarkProvider>(
                    //         context,
                    //         listen: false);
                    //     Map<String, dynamic> bookmark = {
                    //       "internshipId": internship.id
                    //     };
                    //     bool isPosted =
                    //         await bookmarkProvider.bookmarkInternship(bookmark);
                    //     if (isPosted) {
                    //       Navigator.of(context)
                    //           .pushNamed(BookmarkScreen.routeName);
                    //       MotionToast.success(
                    //               description:
                    //                   const Text('Added to the bookmarks'))
                    //           .show(context);
                    //     } else {
                    //       MotionToast.error(
                    //               description:
                    //                   const Text('Failed to add bookmark'))
                    //           .show(context);
                    //     }
                    //   },
                    // child: isBookmarked ?
                    //       Icon(Icons.bookmark,
                    //           size: 40, color: Theme.of(context).primaryColor)
                    //       : Icon(
                    //           Icons.bookmark_outline,
                    //           size: 40,
                    //           color: Colors.grey,
                    //         ),
                    // )
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
                              'About ${internship.eid!.companyName as String}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: height * 0.008),
                            Text(
                              internship.eid!.companyProfile as String,
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
                      Text('${internship.numberOfOpenings}'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // final applicationProvider =
                    //     Provider.of<ApplicationProvider>(context,
                    //         listen: false);
                    // Map<String, dynamic> application = {
                    //   "internshipId": internship.id
                    // };
                    // bool isPosted =
                    //     await applicationProvider.postApplication(application);
                    // if (isPosted) {
                    //   Navigator.of(context).pushNamed(TrackScreen.routeName);
                    //   MotionToast.success(
                    //           description: const Text(
                    //               'You have successfully applied to the internship'))
                    //       .show(context);
                    // } else {
                    //   MotionToast.error(
                    //           description:
                    //               const Text('Failed to post internship'))
                    //       .show(context);
                    // }
                  },
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
