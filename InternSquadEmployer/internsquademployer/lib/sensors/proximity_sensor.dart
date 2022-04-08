import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:internsquademployer/screens/login.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

class ProxySensor extends StatefulWidget {
  const ProxySensor({Key? key}) : super(key: key);

  @override
  _ProxySensorState createState() => _ProxySensorState();
}

class _ProxySensorState extends State<ProxySensor> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    listenSensor();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Proximity Sensor Example'),
        ),
        body: Center(
          child: Text('proximity sensor, is near ?  $_isNear\n'),
        ),
      ),
    );
  }
}
