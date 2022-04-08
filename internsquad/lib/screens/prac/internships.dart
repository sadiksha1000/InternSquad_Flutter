import 'package:flutter/material.dart';
import 'package:internsquad/providers/internship_provider.dart';
import 'package:provider/provider.dart';

// import '../widgets/internship_overview_widget.dart';

import 'package:internsquad/models/internship.dart';
import 'package:internsquad/providers/employer_provider.dart';

class Internship extends StatelessWidget {
  static const routeName = '/internships';
  const Internship({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final employer = Provider.of<Employers>(context);
    final internship = Provider.of<Internships>(context);
    return Scaffold(body: Text('Error'));
    //     body: ListView.builder(
    //   itemBuilder: (context, index) => InternshipOverview(
    //     id: internship.internships[index].id as String,
    //     title: internship.internships[index].title as String,
    //     workEnvironment:
    //         internship.internships[index].workEnvironment as String,
    //     companyName: internship.internships[index].emp!.companyName as String,
    //     stipend: internship.internships[index].stipend as int,
    //     duration: internship.internships[index].duration as int,
    //     deadline: internship.internships[index].deadline as DateTime,
    //     image: internship.internships[index].emp!.image as String,
    //   ),
    //   itemCount: internship.internships.length,
    // ));
  }
}
