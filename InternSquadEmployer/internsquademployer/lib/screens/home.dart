import 'package:flutter/material.dart';
import 'package:internsquademployer/widgets/categoryCarousel.dart';
import 'package:internsquademployer/widgets/departmentCarousel.dart';
import 'package:internsquademployer/widgets/locationCarousel.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Text(
                  'Popular Cities',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: height * 0.026),
                ),
                SizedBox(
                  height: height * 0.010,
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.23,
                  child: LocationCarousel(),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Text(
                  'Internships By Industry',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: height * 0.026),
                ),
                SizedBox(
                  height: height * 0.010,
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.23,
                  child: DepartmentCarousel(),
                ),
                SizedBox(
                  height: height * 0.015,
                ),
                Text(
                  'Popular Category',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: height * 0.026),
                ),
                SizedBox(
                  height: height * 0.010,
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.23,
                  child: CategoryCarousel(),
                ),
              ],
            ),
          ),
        ));
  }
}
