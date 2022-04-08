import 'package:flutter/material.dart';
import 'package:internsquademployer/models/internship.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/screens/updateinternship.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:motion_toast/motion_toast.dart';

class MyInternshipPostings extends StatefulWidget {
  static const routeName = '/myinternshipposts';
  const MyInternshipPostings({Key? key}) : super(key: key);

  @override
  _MyInternshipPostingsState createState() => _MyInternshipPostingsState();
}

class _MyInternshipPostingsState extends State<MyInternshipPostings> {
  late Future<List<Internship>> internship;

  @override
  void initState() {
    super.initState();
    internship = InternshipProvider().getMyPosting();
    // print("Internship$internship");
  }

  bool checkWorkEnvironment(workEnvironment) {
    if (workEnvironment == 'Work from Home') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteInternship(id) {
    var res = InternshipProvider().deleteInternship(id);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
        appBar: MyAppBar(title: 'My Internship Posts'),
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
        onTap: () {},
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
                      //         'http://10.0.0.2:90/employerDocuments/${image}',
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        print("InternshipId${internship.id}");
                        Navigator.of(context).pushNamed(
                          UpdateInternshipPost.routeName,
                          arguments: internship.id,
                        );
                      },
                      child: Chip(
                        label: Text('Edit'),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        avatar: CircleAvatar(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        bool isDeleted = await deleteInternship(internship.id);
                        if (isDeleted) {
                          Navigator.of(context).pushReplacementNamed(
                              MyInternshipPostings.routeName);
                          MotionToast.success(
                                  description: const Text(
                                      'Internship Post deleted successfully'))
                              .show(context);
                        }
                      },
                      child: Chip(
                        label: Text('Delete'),
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        labelPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        avatar: CircleAvatar(
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
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
