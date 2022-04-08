import 'package:flutter/material.dart';
import 'package:internsquad/models/internship.dart';
import 'package:internsquad/screens/internship_detail_screen.dart';
import 'package:intl/intl.dart';

class InternshipCardBuilder extends StatelessWidget {
  final Internship internship;
  final double height;
  final double width;
  const InternshipCardBuilder(
      {Key? key,
      required this.internship,
      required this.height,
      required this.width})
      : super(key: key);

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
    String date = internship.deadline!.split('T')[0];
    String image = internship.eid!.image!.split("\\")[1];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(InternshipDetailScreen.routeName,
              arguments: internship.id);
        },
        focusColor: Theme.of(context).primaryColor,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
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
                          internship.title as String,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: "Roboto-Regular"),
                        ),
                        SizedBox(height: height * 0.006),
                        Text(
                          internship.eid!.companyName as String,
                          // 'Company',
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
                        scale: 50,
                      ),
                      // child: internship.image == null ?
                      //     Image(
                      //         image: AssetImage('assets/images/company.png'))
                      //     : Image.network(
                      //         'http://10.0.0.2:90/${internship.image}',
                      //         fit: BoxFit.fill,
                      //         height: 50,
                      //       ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.006),
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
                      'Rs.${internship.stipend} /month',
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
                      '${internship.duration} months',
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
                      date as String,
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
