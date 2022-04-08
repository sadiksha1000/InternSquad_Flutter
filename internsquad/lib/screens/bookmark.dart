import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internsquad/models/bookmark.dart';
import 'package:internsquad/providers/bookmarkProvider.dart';
import 'package:internsquad/screens/internship_detail_screen.dart';
import 'package:motion_toast/motion_toast.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BookmarkScreen extends StatefulWidget {
  static const routeName = '/bookmark';
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late Future<List<Bookmark>> bookmark;

  @override
  void initState() {
    super.initState();
    bookmark = BookMarkProvider().getMyBookmarks();
    print("Bookmarks${bookmark}");
  }

  Future<bool> deleteBookmark(id) {
    // var applicationProvider = Provider.of<ApplicationProvider>(context);
    var res = BookMarkProvider().deleteBookmark(id, Client());
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
      // appBar: MyAppBar(title: 'My Internship Posts'),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Bookmark>>(
        future: bookmark,
        builder: (context, snapshot) {
          print("SnapshotData${snapshot}");
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: applicationCardBuilder(
                        snapshot.data![index], height, width),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            // print('Mt');
            noContentBuilder(height);
          }
          return Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }

  bool checkWorkEnvironment(workEnvironment) {
    if (workEnvironment == 'Work from Home') {
      return true;
    } else {
      return false;
    }
  }

  Widget noContentBuilder(height) {
    return Container(
      height: height * 0.4,
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Image(
        image: AssetImage('assets/images/interns.jpg'),
      ),
    );
  }

  Widget applicationCardBuilder(Bookmark bookmark, height, width) {
    String date = bookmark.internshipId!.deadline!.split('T')[0];
    String image = bookmark.internshipId!.eid!.image!.split("\\")[1];
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                        bookmark.internshipId!.title as String,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Roboto-Regular"),
                      ),
                      SizedBox(height: height * 0.006),
                      Text(
                        bookmark.internshipId!.eid!.companyName as String,
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
                  checkWorkEnvironment(bookmark.internshipId!.workEnvironment)
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
                      bookmark.internshipId!.workEnvironment as String,
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
                    'Rs.${bookmark.internshipId!.stipend} /month',
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
                    '${bookmark.internshipId!.duration} months',
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
              SizedBox(height: height * 0.006),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          InternshipDetailScreen.routeName,
                          arguments: bookmark.internshipId!.id);
                    },
                    child: Chip(
                      label: Text('View'),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      avatar: CircleAvatar(
                        child: Icon(
                          Icons.home_repair_service,
                          color: Colors.white,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      bool isDeleted = await deleteBookmark(bookmark.id);
                      if (isDeleted) {
                        Navigator.of(context)
                            .pushNamed(BookmarkScreen.routeName);
                        MotionToast.success(
                                description: const Text(
                                    'Your bookmark was removed successfully'))
                            .show(context);
                      }
                    },
                    child: Chip(
                      label: Text('Remove Bookmark'),
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
              )
            ],
          ),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        shadowColor: Colors.black54,
      ),
    );
  }
}
