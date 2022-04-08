import 'package:flutter/material.dart';
import 'package:internsquademployer/screens/filteredDepartment.dart';
import 'package:internsquademployer/widgets/internshipCard.dart';
import 'package:internsquademployer/widgets/itembuilder.dart';

class DepartmentCarousel extends StatefulWidget {
  const DepartmentCarousel({Key? key}) : super(key: key);

  @override
  _DepartmentCarouselState createState() => _DepartmentCarouselState();
}

class _DepartmentCarouselState extends State<DepartmentCarousel> {
  final List<InternshipCard> _items = [
    InternshipCard(
      image:
          'https://cyber.olympiadsuccess.com/assets/images/cyber_square/C10LAT2.jpg',
      title: 'IT',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByDepartmentScreen.routeName,
            arguments: 'IT');
      },
    ),
    InternshipCard(
      image:
          'https://i0.wp.com/www.inventiva.co.in/wp-content/uploads/2021/12/digital_marketing_img_00.jpg?resize=780%2C470&ssl=1',
      title: 'Marketing',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByDepartmentScreen.routeName,
            arguments: 'Marketing');
      },
    ),
    InternshipCard(
      image:
          'https://ec.europa.eu/reform-support/sites/default/files/styles/oe_theme_medium_no_crop/public/2021-05/AdobeStock_268784201.jpeg?itok=BK7RrbOO',
      title: 'Finance',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByDepartmentScreen.routeName,
            arguments: 'IT');
      },
    ),
    InternshipCard(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsxJgr7hqLd3ZP6wcn12L-wbOAn3qkzrq4hA&usqp=CAU',
      title: 'Design',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByDepartmentScreen.routeName,
            arguments: 'Designing');
      },
    ),
    InternshipCard(
      image:
          'https://www.edumilestones.com/career-library/images/architect.png',
      title: 'Architect',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByDepartmentScreen.routeName,
            arguments: 'IT');
      },
    ),
    InternshipCard(
      image:
          'https://cdn.edvoy.com/article/5f60a8dfa42b5709b52ec3c2/banner/civil-engineer.jpg',
      title: 'Engineering',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByDepartmentScreen.routeName,
            arguments: 'IT');
      },
    ),
  ];

  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);
  double _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _page = _pageController.page!;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: height * 0.25,
        child: PageView.builder(
          controller: _pageController,
          itemCount: _items.length ~/ 2 + _items.length % 2,
          itemBuilder: (context, index) {
            return SizedBox(
              child: Row(
                children: [
                  Expanded(child: ItemBuilder(items: _items, index: index * 2)),
                  Expanded(
                      child: index * 2 + 1 >= _items.length
                          ? const SizedBox()
                          : ItemBuilder(items: _items, index: index * 2 + 1)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
