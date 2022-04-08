import 'package:flutter/material.dart';
import 'package:internsquad/persistent_database/sharedpreferences.dart';
import 'package:internsquad/providers/intern_provider.dart';
import 'package:internsquad/screens/blog_screen.dart';
import 'package:internsquad/screens/certificatescreen.dart';
import 'package:internsquad/screens/feedback.dart';
import 'package:internsquad/screens/login.dart';
import 'package:internsquad/screens/profile.dart';
import 'package:internsquad/screens/settings.dart';
import 'package:internsquad/screens/tabscreen.dart';
import '../screens/bookmark.dart';
import '../screens/internships.dart';
import '../screens/track.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
    var res = InternProvider().viewProfile(InternProvider.token);
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
            Map<String, dynamic> intern = await viewProfile();
            Navigator.of(context)
                .pushNamed(ProfilePage.routeName, arguments: intern);
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
          'Internships',
          Icons.home_repair_service,
          () {
            Navigator.pushReplacementNamed(context, TabScreen.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'Internship Certificates',
          TablerIcons.certificate,
          () {
            Navigator.pushNamed(context, CertificateScreen.routeName);
          },
        ),
        SizedBox(
          height: height * 0.010,
        ),
        drawerOption(
          context,
          'Blogs',
          TablerIcons.files,
          () {
            Navigator.of(context).pushNamed(BlogScreen.routeName);
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
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
        )
      ],
    ));
  }
}
