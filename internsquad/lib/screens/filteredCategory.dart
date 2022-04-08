import 'package:flutter/material.dart';
import 'package:internsquad/models/internship.dart';
import 'package:internsquad/providers/internshipProvider.dart';
import 'package:internsquad/widgets/appbar.dart';
import 'package:internsquad/widgets/internshipCardBuilder.dart';
import 'package:provider/provider.dart';

class FilteredInternshipByCategoryScreen extends StatefulWidget {
  static const routeName = '/filterByCategory';
  const FilteredInternshipByCategoryScreen({Key? key}) : super(key: key);

  @override
  _FilteredInternshipByCategoryScreenState createState() =>
      _FilteredInternshipByCategoryScreenState();
}

class _FilteredInternshipByCategoryScreenState
    extends State<FilteredInternshipByCategoryScreen> {
  late Future<List<Internship>> internship;

  @override
  void didChangeDependencies() {
    final internshipData =
        Provider.of<InternshipProvider>(context, listen: false);
    final category = ModalRoute.of(context)!.settings.arguments as String;
    internship = internshipData.filterInternshipsByCategory(category);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final category = ModalRoute.of(context)!.settings.arguments as String;
    final height = screenSize.height;
    final width = screenSize.width;

    return Scaffold(
        appBar: MyAppBar(title: '$category Internships'),
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
