import 'package:flutter/material.dart';
import 'package:internsquademployer/persistent_database/sharedpreferences.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/screens/addblog.dart';
import 'package:internsquademployer/screens/blogs.dart';
import 'package:internsquademployer/screens/feedback.dart';
import 'package:internsquademployer/screens/internship_posting.dart';
import 'package:internsquademployer/screens/internshipscreen.dart';
import 'package:internsquademployer/screens/login.dart';
import 'package:internsquademployer/screens/myinternships.dart';
import 'package:internsquademployer/screens/profile.dart';
import 'package:internsquademployer/screens/settings.dart';
import 'package:internsquademployer/screens/shortlist.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget drawerOption(
      BuildContext context, String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              fontSize: 20,
              color: Colors.black,
            ),
      ),
      onTap: () => onTap(),
    );
  }

  Future<Map<String, dynamic>> viewProfile() {
    var res = EmployerProvider().viewProfile(EmployerProvider.token);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Drawer(
        child: Column(
      children: [
        InkWell(
          onTap: () async {
            Map<String, dynamic> emp = await viewProfile();

            Navigator.of(context)
                .pushNamed(ProfilePage.routeName, arguments: emp);
          },
          child: Container(
            height: height * 0.22,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: height * 0.015),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('assets/images/user.png')
                      as ImageProvider,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                )
              ],
            ),
          ),
        ),
        drawerOption(
          context,
          'Manage Internships',
          Icons.home_repair_service,
          () {
            Navigator.pushNamed(context, MyInternshipPostings.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'Add Blog',
          TablerIcons.file_plus,
          () {
            Navigator.pushNamed(context, AddBlog.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'My Blogs',
          TablerIcons.files,
          () {
            Navigator.pushNamed(context, BlogScreen.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'Settings',
          Icons.settings,
          () {
            Navigator.of(context).pushNamed(SettingsScreen.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'Feedbacks',
          Icons.feedback_outlined,
          () {
            Navigator.of(context).pushNamed(FeedbackScreen.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'LogOut',
          Icons.logout_outlined,
          () async {
            SharedPreferencesHelper().removeAuthToken();
            // EmployerProvider.token = '';
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
        )
      ],
    ));
  }
}
