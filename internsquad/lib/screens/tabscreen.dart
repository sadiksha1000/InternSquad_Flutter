import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:internsquad/persistent_database/sharedpreferences.dart';
import 'package:internsquad/providers/intern_provider.dart';
import 'package:internsquad/screens/login.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:shake/shake.dart';
import '../widgets/appbar.dart';
import './home.dart';
import './internships.dart';
import './bookmark.dart';
import './track.dart';
import '../widgets/drawer.dart';

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
    InternProvider.token = token!;
  }

  @override
  void initState() {
    setUserToken();
    _pages = [
      {'page': HomeScreen(), 'title': 'InternSquad'},
      {'page': InternshipScreen(), 'title': 'Internships'},
      {'page': BookmarkScreen(), 'title': 'Bookmarks'},
      {'page': TrackScreen(), 'title': 'Track Applications'}
    ];

    // Proximity Sensor
    listenSensor();

    // Shake Sensor
    ShakeDetector.autoStart(onPhoneShake: () {
      Navigator.of(context).pushNamed(TabScreen.routeName);
    });
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
              icon: Icon(Icons.bookmark_border_outlined),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Track',
            ),
          ]),
    );
  }
}
