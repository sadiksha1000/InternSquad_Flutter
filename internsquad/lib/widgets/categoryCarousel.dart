import 'package:flutter/material.dart';
import 'package:internsquad/screens/filteredCategory.dart';
import 'package:internsquad/screens/filteredWorkEnvironment.dart';
import 'package:internsquad/widgets/internshipCard.dart';
import 'package:internsquad/widgets/itembuilder.dart';

class CategoryCarousel extends StatefulWidget {
  const CategoryCarousel({Key? key}) : super(key: key);

  @override
  _CategoryCarouselState createState() => _CategoryCarouselState();
}

class _CategoryCarouselState extends State<CategoryCarousel> {
  final List<InternshipCard> _items = [
    InternshipCard(
        image:
            'https://fjwp.s3.amazonaws.com/blog/wp-content/uploads/2016/06/11132525/Full-time-job.png',
        title: 'Full Time',
        onTap: (BuildContext context) {
          Navigator.of(context).pushNamed(
              FilteredInternshipByCategoryScreen.routeName,
              arguments: 'Full Time');
        }),
    InternshipCard(
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOHA4d_ZsC5SJHo7hSUFUTWfcaLzxLI8ujJgwwPiZORIHf5UitK0WvzXiN4UB9GTrP4aE&usqp=CAU',
        title: 'Part Time',
        onTap: (BuildContext context) {
          Navigator.of(context).pushNamed(
              FilteredInternshipByCategoryScreen.routeName,
              arguments: 'Part Time');
        }),
    InternshipCard(
        image:
            'https://assets-api.kathmandupost.com/thumb.php?src=https://assets-cdn.kathmandupost.com/uploads/source/news/2020/lifestyle/shutterstock_1683508351-%5BConverted%5D.jpg&w=900&height=601',
        title: 'Work from Home',
        onTap: (BuildContext context) {
          Navigator.of(context).pushNamed(
              FilteredEnvironmentScreenByWorkEnvironment.routeName,
              arguments: 'Work from Home');
        }),
    InternshipCard(
        image:
            'https://qph.fs.quoracdn.net/main-qimg-e07ded6dd0abd95455225746464d3c6c',
        title: 'Summertime',
        onTap: (BuildContext context) {
          Navigator.of(context).pushNamed(
              FilteredInternshipByCategoryScreen.routeName,
              arguments: 'Summertime Internship');
        }),
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
