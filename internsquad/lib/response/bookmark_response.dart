import 'package:internsquad/models/bookmark.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bookmark_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkResponse {
  bool? success;
  final List<Bookmark> bookmark;

  BookmarkResponse({this.success, required this.bookmark});

  factory BookmarkResponse.fromJson(Map<String, dynamic> obj) =>
      _$BookmarkResponseFromJson(obj);
  Map<String, dynamic> toJson() => _$BookmarkResponseToJson(this);
}
