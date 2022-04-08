import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:internsquademployer/persistent_database/sharedpreferences.dart';
import 'package:internsquademployer/provider/employer_provider.dart';
import 'package:internsquademployer/screens/home.dart';
import 'package:internsquademployer/screens/internship_posting.dart';
import 'package:internsquademployer/screens/internshipscreen.dart';
import 'package:internsquademployer/screens/login.dart';
import 'package:internsquademployer/screens/shortlist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'dart:async';
import 'package:shake/shake.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/tabs';
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, Object>> _pages;
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  void setUserToken() async {
    final token = await SharedPreferencesHelper().getAuthToken();
    EmployerProvider.token = token!;
  }

  @override
  void initState() {
    setUserToken();
    _pages = [
      {'page': HomeScreen(), 'title': 'InternSquad'},
      {'page': InternshipScreen(), 'title': 'Internships'},
      {'page': ShortlistScreen(), 'title': 'Applicants'},
      {'page': InternshipPosting(), 'title': 'Add Internship Posting'}
    ];
    // Proximity Sensor
    listenSensor();

    // Shake Sensor
    ShakeDetector.autoStart(onPhoneShake: () {
      Navigator.of(context).pushNamed(TabScreen.routeName);
    });
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Allow Notifications'),
            content: Text('Our app would like to send you notifications'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Don\'t Allow',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context));
                },
                child: Text(
                  'Allow',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }
    });

    // AwesomeNotifications()
    //     .actionStream
    //     .listen((ReceivedNotification receivedNotification) {
    //   // Navigator.of(context).pushNamed(
    //   //     '/NotificationPage',
    //   //     arguments: {
    //   //         // your page params. I recommend you to pass the
    //   //         // entire *receivedNotification* object
    //   //         id: receivedNotification.id
    //   //     }
    //   // );
    // });
  }

  Future<void> listenSensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0) ? true : false;
      });
      if (_isNear) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: _pages[_selectedPageIndex]['title'] as String,
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          backgroundColor: Colors.white,
          selectedFontSize: 17,
          unselectedFontSize: 16,
          elevation: 5,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontFamily: "Roboto-Medium",
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: "Roboto-Regular",
            fontWeight: FontWeight.w500,
          ),
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_repair_service),
              label: 'Internship',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              label: 'Applicants',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_rounded),
              label: 'Posting',
            ),
          ]),
    );
  }
}
