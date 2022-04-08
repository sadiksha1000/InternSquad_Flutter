import 'package:flutter/material.dart';
import 'package:internsquademployer/models/application.dart';
import 'package:internsquademployer/provider/application_provider.dart';
import 'package:internsquademployer/screens/internship_detail_screen.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class ShortlistScreen extends StatefulWidget {
  static const routeName = '/shortlist';
  const ShortlistScreen({Key? key}) : super(key: key);

  @override
  State<ShortlistScreen> createState() => _ShortlistScreenState();
}

class _ShortlistScreenState extends State<ShortlistScreen> {
  late Future<List<Application>> application;

  @override
  void initState() {
    super.initState();
    application = ApplicationProvider().getMyApplicants();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Application>>(
          future: application,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 10),
                      child: applicationBuilder(
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

  Widget applicationBuilder(Application application, height, width) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(application.internId!.fullName as String),
                SizedBox(height: height * 0.015),
                Text(application.internshipId!.title as String)
              ],
            ),
            InkWell(
              onTap: () {
                Map<String, dynamic> internshipData = {
                  'title': application.internshipId!.title,
                  'workEnvironment': application.internshipId!.workEnvironment,
                  'startDate': application.internshipId!.startDate,
                  'duration': application.internshipId!.duration,
                  'stipend': application.internshipId!.stipend,
                  'deadline': application.internshipId!.deadline,
                  'internshipDetails':
                      application.internshipId!.internshipDetails,
                  'skills': application.internshipId!.skills,
                  'whoCanApply': application.internshipId!.whoCanApply,
                  'perks': application.internshipId!.perks,
                  'numberOfOpenings':
                      application.internshipId!.numberOfOpenings,
                  'department': application.internshipId!.department,
                  'internshipType': application.internshipId!.internshipType,
                  'companyName': application.internshipId!.companyName,
                  'companyProfile': application.internshipId!.companyProfile,
                  'address': application.internshipId!.address,
                  'email': application.internshipId!.email,
                  'phone': application.internshipId!.phone,
                  'image': application.internshipId!.image,
                };
                Navigator.of(context).pushNamed(
                    InternshipDetailScreen.routeName,
                    arguments: internshipData);
              },
              child: Icon(
                Icons.remove_red_eye,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ));
  }
}
