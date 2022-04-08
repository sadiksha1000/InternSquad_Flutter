import 'package:internsquad/models/intern.dart';
import 'package:internsquad/models/internship.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application.g.dart';

@JsonSerializable()
class Application {
  @JsonKey(name: '_id')
  String? id;
  Intern? internId;
  Internship? internshipId;

  Application({
    this.id,
    this.internId,
    this.internshipId,
  });

  factory Application.fromJson(Map<String, dynamic> obj) =>
      _$ApplicationFromJson(obj);
  Map<String, dynamic> toJson() => _$ApplicationToJson(this);
}
