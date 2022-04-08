import 'package:flutter/material.dart';
import 'package:internsquad/persistent_database/sharedpreferences.dart';
import 'package:internsquad/providers/applicationProvider.dart';
import 'package:internsquad/providers/bookmarkProvider.dart';
import 'package:internsquad/providers/employer_provider.dart';
import 'package:internsquad/providers/internshipProvider.dart';
import 'package:internsquad/providers/internship_provider.dart';
import 'package:internsquad/screens/blog_screen.dart';
import 'package:internsquad/screens/certificatescreen.dart';
import 'package:internsquad/screens/feedback.dart';
import 'package:internsquad/screens/filteredCategory.dart';
import 'package:internsquad/screens/filteredDepartment.dart';
import 'package:internsquad/screens/filteredLocation.dart';
import 'package:internsquad/screens/filteredWorkEnvironment.dart';
import 'package:internsquad/screens/forgotpassword.dart';
import 'package:internsquad/screens/individual_blog.dart';
import 'package:internsquad/screens/internship_detail_screen.dart';
import 'package:internsquad/screens/login.dart';
import 'package:internsquad/screens/profile.dart';
import 'package:internsquad/screens/settings.dart';
import 'package:internsquad/screens/signup.dart';
import 'package:internsquad/screens/signup_employer.dart';
import 'package:provider/provider.dart';
import './screens/bookmark.dart';
import './screens/track.dart';
import './screens/internships.dart';
import './widgets/appbar.dart';
import './screens/tabscreen.dart';

void main() {
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
    if (token != '') {
      isAuthenticated = true;
    }
    return token;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isLoggedIn();
    print("IsAuthenticated$isAuthenticated");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InternshipProvider()),
        ChangeNotifierProvider(create: (context) => Employers()),
        ChangeNotifierProvider(create: (context) => ApplicationProvider()),
        ChangeNotifierProvider(create: (context) => BookMarkProvider()),
      ],
      child: MaterialApp(
        title: 'InternSquad',
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
        home: isAuthenticated ? LoginScreen() : TabScreen(),
        routes: {
          // '/': (context) => TabScreen(),
          // '/': (context) => LoginScreen(),
          InternshipScreen.routeName: (context) => InternshipScreen(),
          BookmarkScreen.routeName: (context) => BookmarkScreen(),
          TrackScreen.routeName: (context) => TrackScreen(),
          InternshipDetailScreen.routeName: (context) =>
              InternshipDetailScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
          TabScreen.routeName: (context) => TabScreen(),
          SignUpEmployerScreen.routeName: (context) => SignUpEmployerScreen(),
          FeedbackScreen.routeName: (context) => FeedbackScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
          CertificateScreen.routeName: (context) => CertificateScreen(),
          ProfilePage.routeName: (context) => ProfilePage(),
          BlogScreen.routeName: (context) => BlogScreen(),
          BlogDetailsScreen.routeName: (context) => BlogDetailsScreen(),
          FilteredInternshipByLocationScreen.routeName: (context) =>
              FilteredInternshipByLocationScreen(),
          FilteredInternshipByDepartmentScreen.routeName: (context) =>
              FilteredInternshipByDepartmentScreen(),
          FilteredInternshipByCategoryScreen.routeName: (context) =>
              FilteredInternshipByCategoryScreen(),
          FilteredEnvironmentScreenByWorkEnvironment.routeName: (context) =>
              FilteredEnvironmentScreenByWorkEnvironment(),
        },
        // home: Scaffold(
        //   appBar: MyAppBar(title: 'Intern Squad'),
        //   body: Center(
        //     child: Text(
        //       'Welcome to the world',
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
