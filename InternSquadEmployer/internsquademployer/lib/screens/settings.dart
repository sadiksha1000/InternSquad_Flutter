import 'package:flutter/material.dart';
import 'package:internsquademployer/screens/forgotpassword.dart';
import 'package:internsquademployer/widgets/appbar.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool val = true;

  onChangeFunction(bool newVal) {
    setState(() {
      val = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;

    return Scaffold(
      appBar: MyAppBar(title: 'Settings'),
      body: Container(
        height: height,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              customSwitch(
                  'Turn on your notifications', val, onChangeFunction, context),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Change password',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_right_rounded),
                  ],
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ForgotPasswordScreen.routeName);
                },
              ),
              SizedBox(
                height: height * 0.035,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customSwitch(
    String text, bool val, Function onChangeMethod, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      Spacer(),
      Switch(
          activeColor: Theme.of(context).primaryColor,
          value: val,
          onChanged: (newVal) {
            onChangeMethod(newVal);
          })
    ],
  );
}
