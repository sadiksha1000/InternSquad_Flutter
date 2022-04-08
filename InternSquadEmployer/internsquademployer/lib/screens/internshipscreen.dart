import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internsquademployer/database/database_instance.dart';
import 'package:internsquademployer/entity/internship.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/screens/internship_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InternshipScreen extends StatefulWidget {
  static const routeName = '/internship';
  const InternshipScreen({Key? key}) : super(key: key);

  @override
  State<InternshipScreen> createState() => _InternshipScreenState();
}

class _InternshipScreenState extends State<InternshipScreen> {
  late Future<List<Internship>> internship;
  late Future<List<Internship>> internshipOffline;

  var postings;
  @override
  void initState() {
    super.initState();
    final internshipData =
        Provider.of<InternshipProvider>(context, listen: false);
    internship = InternshipProvider().getInternships(Client());
    internshipData.setInternships();
    internshipOffline = InternshipProvider().getInternshipsOffline(Client());
    print("InternshipOffline$internshipOffline");

    // print("InternMod${internshipData.internships}");
    // print("Internship$internship");
  }

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
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Internship>>(
          future: internship,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: internshipCardBuilder(
                          snapshot.data![index], height, width),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }

  Widget internshipCardBuilder(Internship internship, height, width) {
    String date = internship.deadline!.split('T')[0];
    String image = internship.image!.split("\\")[1];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Map<String, dynamic> internshipData = {
            'title': internship.title,
            'workEnvironment': internship.workEnvironment,
            'startDate': internship.startDate,
            'duration': internship.duration,
            'stipend': internship.stipend,
            'deadline': internship.deadline,
            'internshipDetails': internship.internshipDetails,
            'skills': internship.skills,
            'whoCanApply': internship.whoCanApply,
            'perks': internship.perks,
            'numberOfOpenings': internship.numberOfOpenings,
            'department': internship.department,
            'internshipType': internship.internshipType,
            'companyName': internship.companyName,
            'companyProfile': internship.companyProfile,
            'address': internship.address,
            'email': internship.email,
            'phone': internship.phone,
            'image': internship.image,
          };
          Navigator.of(context).pushNamed(InternshipDetailScreen.routeName,
              arguments: internshipData);
        },
        focusColor: Theme.of(context).primaryColor,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 7,
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
                          internship.companyName as String,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                        // 'http://10.0.2.2:90/employerDocuments/${image}',
                        'http://192.168.1.73:90/employerDocuments/${image}',
                        scale: 50,
                      ),
                      // child: Image(
                      //     image: AssetImage('assets/images/company.png'))
                      // child: internship.image == null?
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