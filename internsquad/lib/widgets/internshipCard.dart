import 'package:flutter/material.dart';
import 'package:internsquad/models/internship.dart';

class InternshipCard {
  String? title;
  String? image;
  Function? onTap;

  InternshipCard({this.image, this.onTap, this.title});
}
