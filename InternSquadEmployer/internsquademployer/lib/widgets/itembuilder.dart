import 'package:flutter/material.dart';
import 'package:internsquademployer/widgets/internshipCard.dart';

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required List<InternshipCard> items,
    required this.index,
  })  : _items = items,
        super(key: key);

  final List<InternshipCard> _items;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height;
    final width = screenSize.width;
    return Container(
      color: Colors.white,
      // margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: InkWell(
        onTap: () {
          print("Tapped");
          _items[index].onTap!(context);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: height * 0.17,
                  child: Image.network(
                    _items[index].image as String,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                right: 10,
                child: Container(
                  height: height * 0.045,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 7, bottom: 5),
                    child: Text(
                      _items[index].title as String,
                      style: TextStyle(
                        fontSize: width * 0.039,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
