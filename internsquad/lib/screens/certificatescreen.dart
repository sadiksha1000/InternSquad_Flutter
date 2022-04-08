import 'package:flutter/material.dart';
import 'package:internsquad/widgets/appbar.dart';

class CertificateScreen extends StatelessWidget {
  static const routeName = '/certificates';
  const CertificateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'My Certificates'),
      body: Column(
        children: [
          Container(
            height: height * 0.8,
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Image(
              image: AssetImage('assets/images/nocontent.jpg'),
            ),
          ),
          Center(
            child: Text(
              'No Certificates Yet !!!!!',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
