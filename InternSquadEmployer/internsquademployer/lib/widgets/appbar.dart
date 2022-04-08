import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  MyAppBar({Key? key, required this.title})
      : preferredSize = const Size.fromHeight(50),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
