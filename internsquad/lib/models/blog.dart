import 'package:json_annotation/json_annotation.dart';

part 'blog.g.dart';

@JsonSerializable()
class Blog {
  @JsonKey(name: '_id')
  String? id;
  String? title;
  String? description;
  DateTime? uploadDate;
  String? image;

  Blog({
    this.id,
    this.title,
    this.description,
    this.uploadDate,
    this.image,
  });

  factory Blog.fromJson(Map<String, dynamic> obj) => _$BlogFromJson(obj);
  Map<String, dynamic> toJson() => _$BlogToJson(this);
}
