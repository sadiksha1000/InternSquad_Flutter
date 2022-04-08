import 'package:flutter/material.dart';
import 'package:internsquad/screens/internship_detail_screen.dart';
import 'package:intl/intl.dart';

class InternshipOverview extends StatelessWidget {
  final String id;
  final String title;
  final String workEnvironment;
  final String companyName;
  final int stipend;
  final int duration;
  final DateTime deadline;
  final String image;

  const InternshipOverview({
    Key? key,
    required this.id,
    required this.title,
    required this.workEnvironment,
    required this.companyName,
    required this.stipend,
    required this.duration,
    required this.deadline,
    required this.image,
  }) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(InternshipDetailScreen.routeName, arguments: id);
        },
        focusColor: Theme.of(context).primaryColor,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "Roboto-Regular"),
                        ),
                        SizedBox(height: height * 0.006),
                        Text(
                          companyName,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.006),
                Row(
                  children: [
                    checkWorkEnvironment(workEnvironment)
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
                        workEnvironment,
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.006),
                Row(
                  children: [
                    const Icon(
                      Icons.money,
                      size: 25,
                      color: Colors.grey,
                    ),
                    SizedBox(width: width * 0.014),
                    Text(
                      'Rs.${stipend} /month',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.006),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                    SizedBox(width: width * 0.014),
                    Text(
                      '${duration} months',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.006),
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
                      'Apply by ${dateConvertor(deadline)}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          shadowColor: Colors.black54,
        ),
      ),
    );
  }
}
