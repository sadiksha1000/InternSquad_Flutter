import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:internsquademployer/persistent_database/sharedpreferences.dart';
import 'package:internsquademployer/provider/blog_provider.dart';
import 'package:internsquademployer/provider/internship_provider.dart';
import 'package:internsquademployer/screens/addblog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:internsquademployer/screens/blogs.dart';
import 'package:internsquademployer/screens/feedback.dart';
import 'package:internsquademployer/screens/filteredCategory.dart';
import 'package:internsquademployer/screens/filteredDepartment.dart';
import 'package:internsquademployer/screens/filteredLocation.dart';
import 'package:internsquademployer/screens/filteredWorkEnvironment.dart';
import 'package:internsquademployer/screens/forgotpassword.dart';
import 'package:internsquademployer/screens/home.dart';
import 'package:internsquademployer/screens/individual_blog.dart';
import 'package:internsquademployer/screens/internshipDetailScreen.dart';
import 'package:internsquademployer/screens/internship_detail_screen.dart';
import 'package:internsquademployer/screens/internship_posting.dart';
import 'package:internsquademployer/screens/internshipscreen.dart';
import 'package:internsquademployer/screens/login.dart';
import 'package:internsquademployer/screens/myinternships.dart';
import 'package:internsquademployer/screens/profile.dart';
import 'package:internsquademployer/screens/settings.dart';
import 'package:internsquademployer/screens/shortlist.dart';
import 'package:internsquademployer/screens/signup.dart';
import 'package:internsquademployer/screens/tabscreen.dart';
import 'package:internsquademployer/screens/updateBlog.dart';
import 'package:internsquademployer/screens/updateinternship.dart';
import 'package:internsquademployer/sensors/proximity_sensor.dart';
import 'package:internsquademployer/sensors/sensors.dart';
import 'package:internsquademployer/widgets/appbar.dart';
import 'package:provider/provider.dart';

void main() async {
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xff005f73),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
          channelShowBadge: true,
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(MyApp());
}

const Map<int, Color> myColor = {
  50: Color.fromRGBO(12, 90, 219, 0.1),
  100: Color.fromRGBO(12, 90, 219, 0.2),
  200: Color.fromRGBO(12, 90, 219, 0.3),
  300: Color.fromRGBO(12, 90, 219, 0.4),
  400: Color.fromRGBO(12, 90, 219, 0.5),
  500: Color.fromRGBO(12, 90, 219, 0.6),
  600: Color.fromRGBO(12, 90, 219, 0.7),
  700: Color.fromRGBO(12, 90, 219, 0.8),
  800: Color.fromRGBO(12, 90, 219, 0.9),
  900: Color.fromRGBO(12, 90, 219, 1),
};

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  var isAuthenticated = false;

  Future<String?> isLoggedIn() async {
    final token = await SharedPreferencesHelper().getAuthToken();
    print(token);
    if (token != '') {
      isAuthenticated = true;
    }
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BlogProvider()),
        ChangeNotifierProvider(create: (context) => InternshipProvider())
      ],
      child: MaterialApp(
        title: 'InternSquadForEmployers',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xff005f73, myColor),
          fontFamily: "Roboto",
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontFamily: "Roboto",
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
            subtitle1: TextStyle(
              color: Colors.grey,
              fontFamily: "Roboto",
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            subtitle2: TextStyle(
              color: Colors.black,
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
            headline1: TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
            ),
            headline2: TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
            ),
            headline3: TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
            ),
            headline4: TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
              fontSize: 20,
            ),
            headline5: TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
              fontSize: 23,
            ),
            headline6: TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
        ),
        // home: ProxySensor(),
        home: isAuthenticated ? LoginScreen() : TabScreen(),
        routes: {
          // '/': (context) => LoginScreen(),
          SignUpEmployerScreen.routeName: (context) => SignUpEmployerScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
          TabScreen.routeName: (context) => TabScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          InternshipScreen.routeName: (context) => InternshipScreen(),
          ShortlistScreen.routeName: (context) => ShortlistScreen(),
          InternshipPosting.routeName: (context) => InternshipPosting(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          FeedbackScreen.routeName: (context) => FeedbackScreen(),
          ProfilePage.routeName: (context) => ProfilePage(),
          BlogScreen.routeName: (context) => BlogScreen(),
          BlogDetailsScreen.routeName: (context) => BlogDetailsScreen(),
          InternshipDetailScreen.routeName: (context) =>
              InternshipDetailScreen(),
          AddBlog.routeName: (context) => AddBlog(),
          UpdateBlog.routeName: (context) => UpdateBlog(),
          MyInternshipPostings.routeName: (context) => MyInternshipPostings(),
          UpdateInternshipPost.routeName: (context) => UpdateInternshipPost(),
          InternshipDetail.routeName: (context) => InternshipDetail(),
          FilteredInternshipByLocationScreen.routeName: (context) =>
              FilteredInternshipByLocationScreen(),
          FilteredInternshipByDepartmentScreen.routeName: (context) =>
              FilteredInternshipByDepartmentScreen(),
          FilteredInternshipByCategoryScreen.routeName: (context) =>
              FilteredInternshipByCategoryScreen(),
          FilteredEnvironmentScreenByWorkEnvironment.routeName: (context) =>
              FilteredEnvironmentScreenByWorkEnvironment(),
        },
      ),
    );
  }
}
