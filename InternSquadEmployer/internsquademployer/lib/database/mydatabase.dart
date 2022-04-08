import 'package:flutter/material.dart';
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:internsquademployer/dao/internshipsdao.dart';
import 'package:internsquademployer/entity/internship.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'mydatabase.g.dart';

@Database(version: 1, entities: [Internships])
abstract class AppDataBase extends FloorDatabase {
  InternshipDao get internshipDao;
}
