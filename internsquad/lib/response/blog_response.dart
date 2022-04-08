import 'package:internsquad/models/blog.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blog_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BlogResponse {
  bool? success;
  final List<Blog> blog;

  BlogResponse({this.success, required this.blog});

  factory BlogResponse.fromJson(Map<String, dynamic> obj) =>
      _$BlogResponseFromJson(obj);
  Map<String, dynamic> toJson() => _$BlogResponseToJson(this);
}
