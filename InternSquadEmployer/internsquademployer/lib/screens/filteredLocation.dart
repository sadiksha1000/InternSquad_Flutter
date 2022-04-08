import 'package:flutter/material.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:internsquademployer/widgets/internshipCardBuilder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FilteredInternshipByLocationScreen extends StatefulWidget {
  static const routeName = '/filterByLocation';
  const FilteredInternshipByLocationScreen({Key? key}) : super(key: key);

  @override
  _FilteredInternshipByLocationScreenState createState() =>
      _FilteredInternshipByLocationScreenState();
}

class _FilteredInternshipByLocationScreenState
    extends State<FilteredInternshipByLocationScreen> {
  late Future<List<Internship>> internship;

  // @override
  // void initState() {
  //   final internshipData =
  //       Provider.of<InternshipProvider>(context, listen: false);
  //   final address = ModalRoute.of(context)!.settings.arguments as String;
  //   internship = internshipData.filterInternshipsByLocation(address);
  //   print("InternshipInKathmandu$internship");
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    final internshipData =
        Provider.of<InternshipProvider>(context, listen: false);
    final address = ModalRoute.of(context)!.settings.arguments as String;
    internship = internshipData.filterInternshipsByLocation(address);
    print("InternshipInKathmandu$internship");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final address = ModalRoute.of(context)!.settings.arguments as String;
    final height = screenSize.height;
    final width = screenSize.width;

    return Scaffold(
        appBar: MyAppBar(title: 'Internships in $address'),
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Internship>>(
          future: internship,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("Snapshot${snapshot.data}");
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data![index].eid!.id);
                    return Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: InternshipCardBuilder(
                          internship: snapshot.data![index],
                          height: height,
                          width: width),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: const CircularProgressIndicator());
          },
        ));
  }
}
