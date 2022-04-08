import 'package:flutter/material.dart';
import 'package:internsquad/models/intern.dart';
import 'package:internsquad/models/internship.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark.g.dart';

@JsonSerializable()
class Bookmark {
  @JsonKey(name: '_id')
  String? id;
  Intern? internId;
  Internship? internshipId;

  Bookmark({
    this.id,
    this.internId,
    this.internshipId,
  });

  factory Bookmark.fromJson(Map<String, dynamic> obj) =>
      _$BookmarkFromJson(obj);
  Map<String, dynamic> toJson() => _$BookmarkToJson(this);
}
