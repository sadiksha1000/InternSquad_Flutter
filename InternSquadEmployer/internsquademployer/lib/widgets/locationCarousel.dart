import 'package:flutter/material.dart';
import 'package:internsquademployer/screens/filteredLocation.dart';
import 'package:internsquademployer/widgets/internshipCard.dart';
import 'package:internsquademployer/widgets/itembuilder.dart';

class LocationCarousel extends StatefulWidget {
  const LocationCarousel({Key? key}) : super(key: key);

  @override
  _LocationCarouselState createState() => _LocationCarouselState();
}

class _LocationCarouselState extends State<LocationCarousel> {
  final List<InternshipCard> _items = [
    InternshipCard(
      image:
          'https://mediaim.expedia.com/destination/1/510cb51ae5042609f6f6a4af86a78928.jpg?impolicy=fcrop&w=536&h=384&q=high',
      title: 'Kathmandu',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByLocationScreen.routeName,
            arguments: 'Kathmandu');
      },
    ),
    InternshipCard(
      image:
          'https://lp-cms-production.imgix.net/2019-06/d1f38e6a43e898025b82377c136f56dd-durbar-square.jpg',
      title: 'Lalitpur',
      onTap: (BuildContext context) {
        Navigator.of(context).pushNamed(
            FilteredInternshipByLocationScreen.routeName,
            arguments: 'Patan');
      },
    ),
    InternshipCard(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmyp_atdLGtTB-drX2OpVYfyUTh1M893DbJA&usqp=CAU',
      title: 'Pokhara',
      // onTap: InternshipProvider().filterInternshipsByLocation('Pokhara'),
    ),
    InternshipCard(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLoqouwf3mFPbBV7UPlZNUgNEOgEATesqHPg&usqp=CAU',
      title: 'Chitwan',
      // onTap: InternshipProvider().filterInternshipsByLocation('Patan'),
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
